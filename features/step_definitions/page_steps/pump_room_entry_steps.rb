# frozen_string_literal: true

#I (should|should not) see PRE landing screen
Then(/^Pre verify PRE landing screen is (present|not present)$/) do |condition|
  @pre_page ||= PumpRoomPage.new(@driver)
  if condition.to_s.downcase == 'present'
    @pre_page.compare_string('Section 1: Pump Room Entry Permit',
                             BASE_PRE_CRE[:heading_text].text)
  end
  @pre_page.pre_landing_false? if condition.to_s.downcase == 'not present'
end
#I should see the right order of elements
Then(/^Pre verify questions order for PRE$/) do
  @pre_page ||= PumpRoomPage.new(@driver)
  base_data = YAML.load_file('data/pre/pump-room-entries.yml')['questions']
  @pre_page.pre_questions(base_data)
end

#I (should|should not) see alert message "(.*)" 1
Then(/^PRE verify alert message "([^"]*)" doesn't show up$/) do |message|
  @pre_page.alert_not_present?(message) if condition.downcase.to_s == 'not present'
end
#I (should|should not) see alert message "(.*)" 2
Then(/^Pre verify alert message "([^"]*)"$/) do |message|
  @pre_page.alert_text_displayed?(message) if condition.downcase.to_s == 'present'
end

#'I select Permit Duration {int}'
Then('Pre select Permit Duration {int}') do |duration|
  @pre_page.select_permit_duration(duration)
end
#Button "([^"]*)" (should|should not) be disabled
And(/^Pre verify Button "([^"]*)" (enabled|disabled)$/) do |button_text, condition|
  @pre_page.element_enabled?(BASE_PRE_CRE[:button], button_text) if condition == 'enabled'
  @pre_page.element_disabled?(BASE_PRE_CRE[:button], button_text) if condition == 'disabled'
end

#I take note of start and end validity time for (.*)
And(/^Pre save current start and end validity time for (.*)$/) do |permit_type|
  @pre_cre_page ||= PRECREBase.new(@driver)
  @pre_cre_page.valid_start_end_time=(permit_type.to_s)
end

#I select current day for field "([^"]*)"
Then(/^PRE select Date of Last Calibration as current day"$/) do
  @pre_page.select_calibration_date
end

#^I click (Yes|No|N/A) to answer the question "(.*)"
Then(%r{^Pre Select (Yes|No|N/A) answer for the question "(.*)"$}) do |answer, question|
  @pre_page.select_checkbox(answer, question)
end
#I (fill up|fill up with gas readings) (PRE.|CRE.) Duration (.*). Delay to activate (.*)
Then(/^Pre fill up permit with Duration (.*) and delay to activate (.*)$/) do |duration, delay|
  @pre_page.fill_pre_form(duration)
  @pre_page.scroll_times_direction(1, 'down')
  @pre_page.activate_time_picker(delay)
end