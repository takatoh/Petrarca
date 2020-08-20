require "isbn_utils/registration_group_ranges"
require "isbn_utils/registrant_ranges"


module ISBNUtils
  module Helpers

    def split_to_parts(body, prefix, ranges)
      g = ""
      ranges[prefix].each do |range_str|
        s, e = range_str.split("-")
        g = body[0..(s.size - 1)]
        break if Range.new(s.to_i, e.to_i).cover?(g.to_i)
      end
      [g, body[(g.size)..]]
    end

  end
end
