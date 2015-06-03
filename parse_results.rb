require 'nokogiri'
require 'csv'

module PhoronixResult

  def self.parse_xml(file)
    tests = []

    f = File.open(file)
    xml_doc = Nokogiri::XML(f)
    xml_doc.css("Result").each do |result|
      title = result.css("Title").text
      descrition = result.css("Description").first.text
      average = 0
      total = 0
      i = 0

      result.css("Value").each do |value|
        total += value.text.to_f
        i += 1
      end
      average = total / i
      tests << Test.new(descrition, title, average, total)
    end
    f.close
    tests
  end

  class Test < Struct.new(:description, :title, :average_result, :sum)
  end

  class PhoronixParser
    def initialize(file = 'composite.xml', directories = %w[micro-ec2 small-ec2 medium-ec2 large-ec2] )
      @file = file
      @directories = directories
      @phoronix_dir = %w[7zip gzip apache-bench php-benchmark stream-bench threaded-last]
      @results = Hash.new(0)
    end

    def print
      puts @results
    end

    def read_data
      file = @file


      @phoronix_dir.each do |phoronix_dir|
        benchs_results = Hash.new(0)
        @directories.each do |ec2_dir|
          tests = PhoronixResult.parse_xml(ec2_dir + '/' + phoronix_dir + '/' + file)
#          puts tests
          tests.each do |test|
            benchs_results[ec2_dir.split("-").first + '-' + test.description] = test.average_result
          end
        end
        @results[phoronix_dir] = benchs_results
      end
      @results
    end
    # writes each bench(7zip for small, 7zip for medium, 7zip for large 7zip for micro) to a csv file so we can make a chart
    def each_bench_to_csv
      @phoronix_dir.each do |phor_dir|
        @directories.each do |dir|
        end
      end
    end

    def all_tests_to_csv_file(file)
      results = @results
#      puts results

      CSV.open(file, "wb") do |csv|
        csv << [''] + %w[micro small medium large]
        results.each do |key, tests|

          # we have nested data
          if tests.values.size > 4
            (tests.values.size / 4).times do |i|
              csv << [tests.keys[i]] + tests.values[(i * 4)...((i + 1) * 4)]
#							puts tests.keys[i]
            end
          else
            csv << [key] + tests.values
          end
        end
      end
			CSV.open("threaded-all.csv", "wb") do |cs|
				results[results.keys.last].each do |key, value|
					cs << [key, value]
				end
			end
    end
  end
end


parser = PhoronixResult::PhoronixParser.new
parser.read_data
#parser.print
parser.all_tests_to_csv_file("all-results-final.csv")
#puts PhoronixResult.parse_xml("micro-ec2/7zip/composite.xml")
