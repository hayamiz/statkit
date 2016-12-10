
module Statkit
  module Spec
    class BaseExp
      # return true if this expression is evaluated with streaming input
      def streaming?
        false
      end

      # evaluate with bulk input
      def evaluate()
        raise NotImplementedError.new
      end

      # add input for evaluation
      def add_input(input_chunk)
        if ! input_chunk.is_a?(Array)
          input_chunk = [input_chunk]
        end

        add_input_chunk(input_chunk)
      end
    end

    class AvgFuncExp < BaseExp
      def initialize
        @nr_input = 0
        @sum = 0
      end

      def streaming?
        true
      end

      def add_input_chunk(input_chunk)
        input_chunk.each do |val|
          @sum += val
          @nr_input += 1
        end
      end

      def evaluate()
        @sum / @nr_input.to_f
      end
    end

    class StdevFuncExp < BaseExp
      def initialize
        @nr_input = 0
        @sum = 0
        @sum_sq = 0
      end

      def streaming?
        true
      end

      def add_input_chunk(input_chunk)
        input_chunk.each do |val|
          @nr_input += 1
          @sum += val
          @sum_sq += val ** 2
        end
      end

      def evaluate()
        var = @sum_sq / @nr_input.to_f - (@sum / @nr_input.to_f)**2
        Math.sqrt(var) * Math.sqrt(@nr_input / (@nr_input.to_f - 1))
      end
    end

    class MinFuncExp < BaseExp
      def initialize
        @min = nil
      end

      def streaming?
        true
      end

      def add_input_chunk(input_chunk)
        if @min.nil?
          @min = input_chunk.min
        else
          @min = (input_chunk + [@min]).min
        end
      end

      def evaluate()
        @min
      end
    end

    class MaxFuncExp < BaseExp
      def initialize
        @max = nil
      end

      def streaming?
        true
      end

      def add_input_chunk(input_chunk)
        if @max.nil?
          @max = input_chunk.max
        else
          @max = (input_chunk + [@max]).max
        end
      end

      def evaluate()
        @max
      end
    end
  end
end
