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
  @ship_local_time_page.time_comparing
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
#draft
#
Then('ShipLocalTime get ship time') do
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.get_ship_time
end

Then('ShipLocalTime set UTC to default') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.open_page
  sleep 1
  @dashboard_page.click_time_button
  @ship_local_time_page ||= ShipLocalTimePage.new(@driver)
  @ship_local_time_page.retrieve_ship_utc
  if @ship_local_time_page.retrieve_ship_utc != '+00:00'
    @ship_local_time_page.set_utc_default
    @ship_local_time_page.click_confirm_btn
    @pin_entry_page ||= PinEntryPage.new(@driver)
    @pin_entry_page.enter_pin('C/O')
    puts('ship UTC set to +00:00')
  else
    puts('ship UTC already has +00:00 offset')
  end
end
