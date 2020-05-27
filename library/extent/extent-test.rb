require "liquid"
require "./support/html_formatter"
$LOAD_PATH << "./support"
$LOAD_PATH << "./lib"

require_relative "model/test"
require_relative "model/log"
# require_relative 'model/test_attribute'
require_relative "model/category"
require_relative "model/author"

module RelevantCodes
  class ExtentTest < Liquid::Drop
    include Formatter

    def initialize(name, description = nil)
      @test = Model::Test.new(name, description)
    end

    def desc_append(scenario_name)
      @test.append_desc(scenario_name)
    end

    def info(status, step_name = nil, details, scenario_name, browser)
      begin
        log = RelevantCodes::Model::Log.new
        log.status = status
        log.step_name = step_name
        Log.instance.info details
        screenshotpath = ReportUtils.get_screenshot(browser)
        # if status.to_s == "pass"
        log.details = details + "<img src=\"#{screenshotpath}\" alt=\"#{screenshotpath}\" style=\"width:304px;height:228px;\">" + "<a href=\"#{screenshotpath}\" target=\"_blank\">Full Image</a>"
        # else
        # end
        # if ($obj_env_yml['screenshot'] == "true" && ENV['PLATFORM'].upcase!="API")
        #   sleep 1 #if ENV['PLATFORM'] == "web_app"

        # else
        #   log.details = details
        # end
        # if status.to_s == "fail"
        #   # log.details << "<br><a href=\"../log/#{scenario_name.gsub("#","%23")}.log\">Link to log</a>"
        # end
        @test.log = log
      rescue Exception => e
      end
    end

    def assign_category(*names)
      names.each do |name|
        @test.category = Model::Category.new(name)
      end
      self
    end

    def test
      @test
    end
  end
end
