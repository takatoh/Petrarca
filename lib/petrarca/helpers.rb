module Petrarca
  module Helpers

    def split_to_parts(body, ranges)
      ranges.map do |range_str|
        s, e = range_str.split("-")
        prefix = body[0..(s.size - 1)]
        if Range.new(s.to_i, e.to_i).cover?(prefix.to_i)
          [prefix, body[(prefix.size)..]]
        else
          nil
        end
      end.compact.first
    end

    def hyphenate13(isbn)
      ean_prefix = isbn[0..2]
      body = isbn[3..11]
      check_digit = isbn[12..12]
      registration_group, body = split_to_parts(body, REGISTRATION_GROUP_RANGES[ean_prefix])
      prefix = "#{ean_prefix}-#{registration_group}"
      registrant, publication = split_to_parts(body, REGISTRANT_RANGES[prefix])
      [ean_prefix, registration_group, registrant, publication, check_digit].join("-")
    end


    def self.load_ranges(range_file)
      ranges = {}
      File.open(range_file, "r") do |f|
        f.each_line do |line|
          next if line.start_with?("#")
          g, r = line.chomp.split(":")
          ranges[g] = r.split(",")
        end
      end
      ranges
    end

  end
end
