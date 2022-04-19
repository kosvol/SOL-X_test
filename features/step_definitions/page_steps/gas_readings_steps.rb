# frozen_string_literal: true

require_relative '../../../page_objects/gas_readings_page'

And('GasReadings fill equipment fields') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.fill_gas_equipment_fields
end

And('GasReadings add normal gas readings') do
  step('GasReadings fill equipment fields')
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.add_normal_gas_readings('1', '2', '3', '4')
end

And('GasReadings add random gas readings') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.add_normal_gas_readings(rand(1..10).to_s, rand(1..10).to_s, rand(1..10).to_s, rand(1..10).to_s)
end

And('GasReadings add toxic gas readings') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.add_toxic_gas_readings('Test', '20', '1.5', 'cc')
end

And('GasReadings click Review & Sign button') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.click_button('Review & Sign')
end

And('GasReadings click Enter pin and Submit button') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.click_pin_and_submit
end

And('GasReadings delete toxic reading') do
  @gas_readings_page.delete_toxic_readings
end

And('GasReadings verify toxic reading count {string}') do |count|
  @gas_readings_page.verify_toxic_count(count)
end

And('GasReadings verify placeholder text') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  step('GasReadings fill equipment fields')
  @gas_readings_page.verify_placeholder
end

And('GasReadings verify Submit button is {string}') do |option|
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.verify_submit_btn(option)
end

And('GasReadings click done button on gas reader dialog box') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.click_done_button
  sleep 1 # wait for screen
end

And('GasReadings verify gas reading display') do |table|
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.verify_gas_reading(table)
end

And('GasReadings verify location from signature') do |table|
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  parms = table.hashes.first
  @gas_readings_page.verify_location_in_sign(parms['location'])
end

And('GasReadings add gas readings') do |table|
  parms = table.hashes.first
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.add_normal_gas_readings(parms['o2_gas'], parms['hc_gas'], parms['h2s_gas'], parms['co_gas'])
end

Then('GasReadings select Date of Last Calibration as current day') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.select_calibration_date
end
