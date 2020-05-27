require "liquid"

require_relative "log"
# require_relative 'test_attribute'
require_relative "author"
require_relative "category"

module RelevantCodes
  module Model
    class Test < Liquid::Drop
      attr_reader :name, :description
      attr_reader :status
      attr_reader :get_start_time, :get_end_time, :get_run_duration
      attr_reader :logs, :children
      attr_reader :authors, :categories

      attr_writer :is_child

      def initialize(name, description)
        @name = name.strip
        @description = description.nil? || description == "" ? "" : description.strip
        @status = "fail"

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
        unless @name.nil? || sce_name.nil?
          @name.gsub!(/\)/, sce_name) if @name.include? ")"
        end
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

        if @arr.include?("fatal")
          @status = "fatal"
        elsif @arr.include?("fail")
          @status = "fail"
        elsif @arr.include?("error")
          @status = "error"
        elsif @arr.include?("warning")
          @status = "warning"
        elsif @arr.include?("pass")
          @status = "pass"
        elsif @arr.include?("skip")
          @status = "skip"
        elsif @arr.include?("info")
          @status = "pass"
        else
          @status = "skip"
        end
      end
    end
  end
end
