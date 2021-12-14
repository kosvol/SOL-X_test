# frozen_string_literal: true

require_relative '../../../page_objects/gas_readings_page'

#I add (all|only normal) gas readings with (.*) rank 1
And('GasReadings fill equipment fields') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.fill_gas_equipment_fields
end

#I add (all|only normal) gas readings with (.*) rank 2
And('GasReadings click add gas readings') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.click_add_gas_button
end

#I add (all|only normal) gas readings with (.*) rank 3
And('GasReadings add normal gas readings') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.add_normal_gas_readings('1', '2', '3', '4')
end

#I add (all|only normal) gas readings with (.*) rank 4
And('GasReadings add toxic gas readings') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.add_toxic_gas_readings('Test', '20', '1.5', 'cc')
end

#I add (all|only normal) gas readings with (.*) rank 5
And('GasReadings click Review & Sign button') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.click_review_and_sign
end

#I add (all|only normal) gas readings with (.*) rank 6
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
  @gas_readings_page.verify_placeholder
end

And('GasReadings verify Submit button is {string}') do |option|
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.verify_submit_btn(option)
end

#i dismiss gas reader dialog box
And('GasReadings click done button on gas reader dialog box') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.click_done_button
end

#I should see gas reading display with toxic gas and C/O COT C/O as gas signer
And('GasReadings verify gas table titles') do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.verify_gas_table_titles
end
#I check location in gas readings signature is present
And('GasReadings verify location in sign') do |table|
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  parms = table.hashes.first
  @gas_readings_page.verify_location_in_sign(parms['location'])
end

