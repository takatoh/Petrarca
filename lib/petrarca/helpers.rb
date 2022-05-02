module Petrarca
  module Helpers

    extend self

    def split(isbn)
      isbn = isbn.to_s.delete("-")
      ean_prefix = isbn[0, 3]
      body = isbn[3, 9]
      check_digit = isbn[12, 1]
      registration_group, body = Helpers.split_to_parts(body, REGISTRATION_GROUP_RANGES[ean_prefix])
      prefix = "#{ean_prefix}-#{registration_group}"
      registrant, publication = Helpers.split_to_parts(body, REGISTRANT_RANGES[prefix])
      [ean_prefix, registration_group, registrant, publication, check_digit]
    end


    def split_to_parts(body, ranges)
      ranges.map do |range_str|
        s, e = range_str.split("-")
        prefix = body[0, s.size]
        if Range.new(s.to_i, e.to_i).cover?(prefix.to_i)
          [prefix, body[(prefix.size)..]]
        else
          nil
        end
      end.compact.first
    end


    def load_ranges(range_file)
      ranges = {}
      File.open(range_file, "r") do |f|
        f.each_line do |line|
          next if line.start_with?("#")
          g, r = line.chomp.split(":")
          ranges[g] = r.split(",") unless r.nil?
        end
      end
      ranges
    end

  end
end
