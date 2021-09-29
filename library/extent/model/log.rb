# frozen_string_literal: true

require 'rubygems'
require 'liquid'

module RelevantCodes
  module Model
    class Log < Liquid::Drop
      attr_accessor :step_name, :details
      attr_writer :status
      attr_reader :timestamp

      def initialize
        @timestamp = Time.new.strftime(TIME_FORMAT)
      end

      def get_status
        # p "Get status in log >>> #{@status.to_s}"
        @status.to_s
      end

      def get_icon
        ret_val = case get_status
                  when 'pass'
                    'mdi-action-check-circle'
                  when 'fail'
                    'mdi-navigation-cancel'
                  when 'fatal'
                    'mdi-navigation-cancel'
                  when 'error'
                    'mdi-alert-error'
                  when 'warning'
                    'mdi-alert-warning'
                  when 'skip'
                    'mdi-content-redo'
                  when 'info'
                    'mdi-action-info-outline'
                  when 'undefined'
                    'mdi-action-info-outline'
                  else
                    'mdi-action-help'
                  end
      end
    end
  end
end
