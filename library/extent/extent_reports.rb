require 'rubygems'
require 'liquid'

require_relative 'report'
require_relative 'extent_test'
# require_relative 'icon'

module RelevantCodes
  class ExtentReports < Report
    def initialize(file_path)
      super(file_path)
    end

    def start_test(test_name, description = nil)
      @tests << RelevantCodes::ExtentTest.new(test_name, description)
      @tests[-1]
    end

    def end_test(extent_test)
      finalize_test(extent_test)
    end

    def append_desc(tables)
      tests_add_examples(tables)
    end

    def flush
      remove_child_tests
      file ||= 'library/extent/view/extent.html.liquid.html'
      markup = Liquid::Template.parse(File.read(file)).render('report' => self)

      File.open(@file_path, 'w') {
          |file| file.write(markup)
      }
    end
  end
end
