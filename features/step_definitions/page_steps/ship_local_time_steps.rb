# frozen_string_literal: true

require_relative '../../../page_objects/ship_local_time_page'

And('ShipLocalTime click Confirm button') do
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.click_confirm_btn
end

And('ShipLocalTime click Cancel button') do
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.click_cancel_btn
end

Then('ShipLocalTime verify the time at UTC') do
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.compare_time
end

Then('ShipLocalTime set UTC to value by API {int}') do |value|
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.receive_utc_by_api(value)
end

Then('ShipLocalTime set UTC sign to value {string}') do |sign|
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.update_sign_to_value(sign)
end

Then('ShipLocalTime set UTC hour to value {string}') do |hour|
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.update_hour_to_value(hour)
end

Then('ShipLocalTime set UTC min to value {string}') do |min|
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.update_min_to_value(min)
end
