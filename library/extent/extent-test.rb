# frozen_string_literal: true

require 'liquid'
require './support/html_formatter'
$LOAD_PATH << './support'
$LOAD_PATH << './lib'

require_relative 'model/test'
require_relative 'model/log'
require_relative 'model/category'
require_relative 'model/author'

module RelevantCodes
  class ExtentTest < Liquid::Drop
    include Formatter

    def initialize(name, description = nil)
      @test = Model::Test.new(name, description)
    end

    def desc_append(scenario_name)
      @test.append_desc(scenario_name)
    end

    def info(status, step_name = nil, details, _scenario_name, browser)
      log = RelevantCodes::Model::Log.new
      log.status = status
      # Log.instance.info details
      screenshotpath = ReportUtils.get_screenshot(browser)
      # if status.to_s == "pass"
      log.step_name = step_name + "<a href=\"#{screenshotpath}\" target=\"_blank\"><p>Full Image</p></a>"
      # log.screenshot_html = "<a href=\"#{screenshotpath}\" target=\"_blank\"><p>Full Image</p></a>"
      # log.step_name = step_name + "<img src=\"#{screenshotpath}\" alt=\"#{screenshotpath}\" style=\"width:304px;height:228px;\">" + "<a href=\"#{screenshotpath}\" target=\"_blank\"><p>Full Image</p></a></>"
      log.details = details #+ "<img src=\"#{screenshotpath}\" alt=\"#{screenshotpath}\" style=\"width:304px;height:228px;\">" + "<a href=\"#{screenshotpath}\" target=\"_blank\">Full Image</a>"
      @test.log = log
    rescue Exception => e
    end

    def assign_category(*names)
      names.each do |name|
        @test.category = Model::Category.new(name)
      end
      self
    end

    attr_reader :test
  end
end
