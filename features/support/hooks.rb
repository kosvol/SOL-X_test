# frozen_string_literal: true

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
    embed(encoded_img, 'image/png;base64')
  end
end
