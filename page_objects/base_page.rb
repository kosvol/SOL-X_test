# frozen_string_literal: true

require_relative 'utils/driver_utils'
# BasePage object
class BasePage
  include DriverUtils
  def initialize(driver)
    @driver = driver
    @logger = Logger.new($stdout)
  end
end
