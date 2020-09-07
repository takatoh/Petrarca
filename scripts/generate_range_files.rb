# encoding: utf-8

require "nokogiri"


RANGE_MESSAGE_FILE = "RangeMessage.xml"
REGISTRATION_GROUP_RANGES_FILE = "registration_group_ranges.txt"
REGISTRANT_RANGES_FILE = "registrant_ranges.txt"


def main
  doc = File.open(RANGE_MESSAGE_FILE, "r"){|f| Nokogiri::XML(f) }

  source = doc.xpath("//MessageSource").text
  date = doc.xpath("//MessageDate").text

  registration_groups = extract_ranges(doc.xpath("//EAN.UCC"))
  registrants = extract_ranges(doc.xpath("//Group"))

  File.open(REGISTRATION_GROUP_RANGES_FILE, "w") do |f|
    f.puts "# " + source
    f.puts "# " + date
    f.puts "#"
    registration_groups.each do |group|
      f.puts "# " + group["agency"]
      f.puts group["prefix"] + ":" + group["ranges"].join(",")
    end
  end
  $stderr.puts "Generated: #{REGISTRATION_GROUP_RANGES_FILE}"

  File.open(REGISTRANT_RANGES_FILE, "w") do |f|
    f.puts "# " + source
    f.puts "# " + date
    f.puts "#"
    registrants.each do |registrant|
      f.puts "# " + registrant["agency"]
      f.puts registrant["prefix"] + ":" + registrant["ranges"].join(",")
    end
  end
  $stderr.puts "Generated: #{REGISTRANT_RANGES_FILE}"
end

def extract_ranges(nodes)
  nodes.map do |node|
    prefix = node.xpath("Prefix").text
    agency = node.xpath("Agency").text
    ranges = node.xpath("Rules/Rule").map do |rule|
      length = rule.xpath("Length").text.to_i
      range = if length > 0
        rule.xpath("Range").text.split("-").map{|s| s[0, length] }.join("-")
      else
        nil
      end
      range
    end.compact
    {
      "prefix" => prefix,
      "agency" => agency,
      "ranges" => ranges
    }
  end
end


main

