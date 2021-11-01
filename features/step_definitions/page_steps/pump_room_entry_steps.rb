# frozen_string_literal: true

#I (should|should not) see PRE landing screen
Then(/^PRE Page Verify PRE landing screen is (present|not present)$/) do |condition|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.pre_landing_true? if condition.to_s.downcase == 'present'
  @pre_page.pre_landing_false? if condition.to_s.downcase == 'not present'
end
#I should see the right order of elements
Then(/^PRE Page Verify questions order for PRE$/) do
  @pre_page ||= PumpRoomPage.new(@driver)
  base_data = YAML.load_file('data/pre/pump-room-entries.yml')['questions']
  @pre_page.pre_questions(base_data)
end

#I (should|should not) see alert message "(.*)"
Then(/^PRE Page Verify alert message "(.*)" is (present|not present)$/) do |message, condition|
  @pre_page.alert_present?(message) if condition.downcase.to_s == 'present'
  @pre_page.alert_not_present?(message) if condition.downcase.to_s == 'not present'
end
#'I select Permit Duration {int}'
Then('PRE Page select Permit Duration {int}') do |duration|
  @pre_page.select_permit_duration(duration)
end
#Button "([^"]*)" (should|should not) be disabled
And(/^PRE Page Verify Button "([^"]*)" (enabled|disabled)$/) do |button_text, condition|
  @pre_page.button_enabled?(button_text) if condition == 'enabled'
  @pre_page.button_disabled?(button_text) if condition == 'disabled'
end

#I select current day for field "([^"]*)"
Then(/^PRE Page select current day for field "Date of Last Calibration"$/) do
  @pre_page.click(PUMP_ROOM[:gas_last_calibration_button])
  @pre_page.select_current_day
  @pre_page.compare_string(PUMP_ROOM[:gas_last_calibration_button].text, Time.now.strftime('%d/%b/%Y'))
end
