require 'ally/detector'
require 'ally/detector/quote/version'

module Ally
  module Detector
    class Quote
      include Ally::Detector

      def end_set
        @datapoints << @set.join(' ')[1..-2] # drop quotes
        @set = []
      end

      def detect
        return nil unless @inquiry.raw.chars.count('"') >= 2 || @inquiry.raw.chars.count("'") >= 2
        @datapoints = []
        @set = []
        @inquiry.words_with_punc.each do |w|
          if @set.length == 0
            # looking for the beginning of a quote
            if w =~ /^('|").*?('|")$/
              @set << w
              end_set
            elsif w =~ /^('|")/
              @set << w
            end
          else
            # looking for the end of a quote
            @set << w
            if w =~ /('|")$/
              end_set
            end
          end
        end
        @datapoints.length == 0 ? nil : @datapoints
      end
    end
  end
end
