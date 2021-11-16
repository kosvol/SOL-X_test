#I add (all|only normal) gas readings with (.*) rank 1
And(/^GasReadings fill equipment fields$/) do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.fill_gas_equipment_fields
end

#I add (all|only normal) gas readings with (.*) rank 2
And(/^GasReadings click add gas readings$/) do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  click(@gas_readings_page.GAS_READINGS[:add_gas_btn])
end

#I add (all|only normal) gas readings with (.*) rank 3
And(/^GasReadings add normal gas readings$/) do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.normal_gas_readings('1', '2', '3', '4')
end

#I add (all|only normal) gas readings with (.*) rank 4
And(/^GasReadings add toxic gas readings$/) do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @gas_readings_page.toxic_gas_readings('Test', '20', '1.5', 'cc')
end

#I add (all|only normal) gas readings with (.*) rank 5
And(/^GasReadings click Review & Sign button$/) do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  click(@gas_readings_page.GAS_READINGS[:review_sign_btn])
end

#I add (all|only normal) gas readings with (.*) rank 6
And(/^GasReadings click Enter pin and Submit button$/) do
  @gas_readings_page ||= GasReadingsPage.new(@driver)
  @driver.find_element(:css, @gas_readings_page.GAS_READINGS[:enter_pin_and_submit_btn]).click
end

