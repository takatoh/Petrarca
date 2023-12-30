module Petrarca

  class InvalidEANPrefixError < StandardError; end
  class InvalidRangeError < StandardError; end

  module Helpers

    extend self

    def split(isbn)
      isbn = Petrarca.dehyphenate(isbn)
      ean_prefix = isbn[0, 3]
      unless ean_prefix == "978" || ean_prefix == "979"
        raise InvalidEANPrefixError.new("Invalid EAN prefix: #{ean_prefix}")
      end
      body = isbn[3, 9]
      check_digit = isbn[12, 1]
      begin
        registration_group, body = Helpers.split_to_parts(body, REGISTRATION_GROUP_RANGES[ean_prefix])
      rescue InvalidRangeError
        raise InvalidRangeError.new("Registration group is not defined: #{body} (under #{ean_prefix})")
      end
      prefix = "#{ean_prefix}-#{registration_group}"
      begin
        registrant, publication = Helpers.split_to_parts(body, REGISTRANT_RANGES[prefix])
      rescue InvalidRangeError
        raise InvalidRangeError.new("Registrant is not defined: #{body} (under #{prefix})")
      end
      [ean_prefix, registration_group, registrant, publication, check_digit]
    end


    def split_to_parts(body, ranges)
      parts = ranges.map do |range_str|
        s, e = range_str.split("-")
        prefix = body[0, s.size]
        if Range.new(s.to_i, e.to_i).cover?(prefix.to_i)
          [prefix, body[(prefix.size)..]]
        else
          nil
        end
      end.compact
      unless parts.empty?
        parts.first
      else
        raise InvalidRangeError.new(body)
      end
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
