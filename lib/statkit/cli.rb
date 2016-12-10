
require 'optparse'

module Statkit
  class CLI
    def initialize()
      setup_parser
    end

    def setup_parser()
      @parser = OptionParser.new
      @parser.banner = "Usage: statkit [options] STAT_SPEC"

      @parser.on('-h', '--help', 'Show this help.') do
        puts(@parser.help)
        exit(true)
      end
    end

    def do_parse(argv)
      argv = argv.dup
      @parser.parse!(argv)
      @args = argv

      if @args.size < 1
        $stderr.puts("[ERROR] STAT_SPEC is not specified.")
        $stderr.puts("")
        puts(@parser.help)
        exit(false)
      end

      @stat_spec = @args.first

      true
    end

    def run(argv)
      do_parse(argv)

      exps = @stat_spec.split().map do |spec|
        case spec
        when "avg"
          ::Statkit::Spec::AvgFuncExp.new
        when "stdev"
          ::Statkit::Spec::StdevFuncExp.new
        when "min"
          ::Statkit::Spec::MinFuncExp.new
        when "max"
          ::Statkit::Spec::MaxFuncExp.new
        else
          raise RuntimeError.new("Unknown function: #{spec}")
        end
      end

      $stdin.each_line do |line|
        val = Float(line)

        exps.each do |exp|
          exp.add_input(val)
        end
      end

      puts(exps.map(&:evaluate).join("\t"))

      true
    end
  end
end
