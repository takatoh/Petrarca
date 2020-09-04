module Petrarca
  module Helpers

    extend self

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


    def load_ranges(range_file)
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
