# frozen_string_literal: true

require 'rubygems'
require 'liquid'

require_relative 'report'
require_relative 'extent_test'
# require_relative 'icon'

module RelevantCodes
  class ExtentReports < Report
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

    def flush_extent_report
      # remove_child_tests
      file ||= 'library/extent/view/extent.html.liquid.html'
      markup = Liquid::Template.parse(File.read(file)).render('report' => self)

      File.open(@file_path, 'w') do |item|
        item.write(markup)
      end
    end

    def flush_living_report
      remove_child_tests
      file ||= 'library/extent/view/living_documentation.html'
      markup = Liquid::Template.parse(File.read(file)).render('report' => self)

      File.open(@file_path, 'w') do |item|
        item.write(markup)
      end
    end
  end
end
