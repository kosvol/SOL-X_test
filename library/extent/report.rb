# frozen_string_literal: true

require 'liquid'
require 'socket'

module RelevantCodes
  class Report < Liquid::Drop
    def initialize(file_path)
      @file_path = file_path
      @get_start_time = Time.new.strftime(DATE_TIME_FORMAT)
      @get_end_time = nil
      @tests = []
      @category_test_context = {}

      # to decouple
      @system_variables = {
        # 'OS' => ENV['OS'],
        'User Name' => Socket.gethostname,
        'Ruby Version' => "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}",
        'Host Name' => Socket.gethostname
      }

      @configuration = {
        'encoding' => 'UTF-8',
        'document_title' => 'Sol-X',
        'report_name' => '../img/sol-x-logo.912a6bb7.svg',
        'report_headline' => '',
        'scripts' => '',
        'styles' => ''
      }
    end

    attr_reader :tests, :get_start_time

    def get_end_time
      Time.new.strftime(DATE_TIME_FORMAT)
    end

    def get_configuration
      @configuration
    end

    def get_system_variables
      @system_variables
    end

    def get_category_tests_context
      @category_test_context
    end

    def get_run_duration
      Time.at(Time.parse(get_end_time) - Time.parse(get_start_time)).utc.strftime(TIME_FORMAT)
    end

    private

    def finalize_test(extent_test)
      test = extent_test.test
      test.end
      test.categories.each do |category|
        @category_test_context[category.name] ||= []
        @category_test_context[category.name] << test
      end
    end

    def remove_child_tests
      @tests.each_with_index do |t, ix|
        @tests.delete_at(ix) if t.test.is_child?
      end
    end

    def tests_add_examples(table)
      @tests.each_with_index do |t, ix|
        t.desc_append(table[ix])
      end
    end
  end
end
