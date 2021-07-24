require 'liquid'

require_relative 'log'
# require_relative 'test_attribute'
require_relative 'author'
require_relative 'category'

module RelevantCodes
  module Model
    class Test < Liquid::Drop
      attr_reader :name, :description, :status, :get_start_time, :get_end_time, :get_run_duration, :logs, :children,
                  :authors, :categories

      attr_writer :is_child

      def initialize(name, description)
        @name = name.strip
        @description = description.nil? || description == '' ? '' : description.strip

        @child_node = false
        @has_ended = false
        @has_children = false

        @categories = []
        @authors = []

        @get_start_time = Time.new.strftime(DATE_TIME_FORMAT)
        @get_end_time = nil

        @children = []

        @logs = []

        @screen_captures = []
        @screen_casts = []

        @internal_warning = nil
      end

      def append_desc(sce_name)
        @name.gsub!(/\)/, sce_name) if !(@name.nil? || sce_name.nil?) && (@name.include? ')')
      end

      def get_run_duration
        Time.parse(@get_end_time) - Time.parse(@get_start_time)
      end

      def end
        @get_end_time = Time.new.strftime(DATE_TIME_FORMAT)
        @arr = []
        finalize self
      end

      def category=(category)
        @categories << category
      end

      def log=(l)
        @logs << l
      end

      def is_child?
        @is_child
      end

      def has_children?
        @has_children
      end

      private

      def finalize(test)
        test.logs.each do |log|
          @arr.push(log.get_status)
        end

        if test.has_children?
          test.children.each do |node|
            finalize(node)
          end
        end

        p "Status array >>> #{@arr}"
        @status = if @arr.include?('fatal')
                    'fatal'
                  elsif @arr.include?('fail')
                    'fail'
                  elsif @arr.include?('error')
                    'error'
                  elsif @arr.include?('warning')
                    'warning'
                  elsif @arr.include?('pass')
                    'pass'
                  elsif @arr.include?('skip')
                    'skip'
                  elsif @arr.include?('info')
                    'pass'
                  elsif @arr.include?('undefined')
                    'fail'
                  else
                    'fail'
                  end
      end
    end
  end
end
