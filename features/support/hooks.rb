# frozen_string_literal: true

require_relative 'driver_configuration'

DRIVER = DriverConfiguration.new.setup_driver

Before do
  @driver = DRIVER
end

Before('@skip') do
  skip_this_scenario
end

After do |scenario|
  if scenario.failed?
    encoded_img = DRIVER.screenshot_as(:base64)
    attach(encoded_img, 'image/png;base64')
  end
end
