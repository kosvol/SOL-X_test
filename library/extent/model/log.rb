require "rubygems"
require "liquid"

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
        return @status.to_s
      end

      def get_icon
        case self.get_status
        when "pass"
          ret_val = "mdi-action-check-circle"
        when "fail"
          ret_val = "mdi-navigation-cancel"
        when "fatal"
          ret_val = "mdi-navigation-cancel"
        when "error"
          ret_val = "mdi-alert-error"
        when "warning"
          ret_val = "mdi-alert-warning"
        when "skip"
          ret_val = "mdi-content-redo"
        when "info"
          ret_val = "mdi-action-info-outline"
        when "undefined"
          ret_val = "mdi-action-info-outline"
        else
          ret_val = "mdi-action-help"
        end
      end
    end
  end
end
