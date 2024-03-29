# frozen_string_literal: true

Then(/^I should see new PRE permit number$/) do
  p "base: #{on(CommonFormsPage).generic_data_elements[2].text}"
  p "exact: #{CommonPage.return_permit_id}"
  is_equal(on(CommonFormsPage).generic_data_elements[2].text, CommonPage.return_permit_id)
end

Then(/^I should see (no new|only) entry log message$/) do |condition|
  case condition
  when 'no new'
    sleep 3
    BrowserActions.wait_until_is_visible(on(PumpRoomEntry).entry_log_btn_element)
    on(PumpRoomEntry).entry_log_btn_element.click
    sleep 1
    is_equal(on(PreDisplay).info_gas_testing_is_missing_elements[2]
                           .text, 'No Entry Yet')
    is_equal(on(PreDisplay).info_gas_testing_is_missing_elements[3]
                           .text, 'Press on “New Entry” button on the “Home” page to record a new entry.')
  when 'only'
    sleep 3
    on(PumpRoomEntry).entry_log_btn_element.click
    sleep 1
    is_enabled(on(PumpRoomEntry).entry_log_table_elements.first)
  else
    raise 'wrong condition'
  end
end

And(/^I navigate to (PRE|CRE) Display$/) do |type|
  step 'I navigate to "Settings" screen for setting'
  # on(PumpRoomEntry).pump_room_display_setting_element.click
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).pump_room_display_setting_element) if type == 'PRE'
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).compressor_room_display_setting_element) if type == 'CRE'
  BrowserActions.wait_until_is_visible(on(PumpRoomEntry).enter_pin_and_apply_element)
  step 'I press the "Enter Pin & Apply" button'
end

And(/^I navigate to (PRE|CRE) Display until see active permit$/) do |type|
  i = 0
  until on(PreDisplay).background_color? == 'rgba(67, 160, 71, 1)'
    step 'I navigate to "Settings" screen for setting'
    BrowserActions.poll_exists_and_click(on(PumpRoomEntry).pump_room_display_setting_element) if type == 'PRE'
    BrowserActions.poll_exists_and_click(on(PumpRoomEntry).compressor_room_display_setting_element) if type == 'CRE'
    step 'I press the "Enter Pin & Apply" button'
    step 'I enter pin via service for rank C/O'
    sleep(5)
    i += 1
    break if i == 12
  end
end

And(/^I wait on (PRE|CRE) Display until see (red|green) background$/) do |_type, color|
  i = 0
  colors_hash = { 'red' => 'rgba(216, 75, 75, 1)',
                  'green' => 'rgba(67, 160, 71, 1)' }
  until on(PreDisplay).background_color? == colors_hash[color]
    sleep(5)
    i += 1
    break if i == 12
  end
end

And(/^\(for pred\) I should see the (disabled|enabled) "([^"]*)" button$/) do |condition, button|
  is_true(on(PreDisplay).element_disabled_by_att?(button)) if condition == 'disabled'

  is_false(on(PreDisplay).element_disabled_by_att?(button)) if condition == 'enabled'
end

And(/^\(for pred\) I should see (info|warning) box for (activated|deactivated) status$/) do |which_box, status|
  if which_box == 'warning'
    begin
      box_text = on(PreDisplay).warning_box_element.text
    rescue StandardError
      begin
        box_text = on(PreDisplay).warning_box_alert_wiper_element.text
      rescue StandardError
        box_text = on(PreDisplay).entry_disclaimer_element.text
      end
    end
    base_data_text = YAML.load_file('data/pre/pre-display.yml')['warning_box'][status]
    is_equal(box_text, base_data_text)
  end
end

Then(/^I should see (green|red) background color$/) do |condition|
  background_color = on(PreDisplay).background_color?
  case condition
  when 'green'
    green = 'rgba(67, 160, 71, 1)'
    is_equal(background_color, green)
  else
    red = 'rgba(216, 75, 75, 1)'
    is_equal(background_color, red)
  end
end

And(/^I should see (Permit Activated|Permit Terminated) (PRE|CRE) status on screen$/) do |status, _type|
  sleep 2
  BrowserActions.wait_until_is_visible(on(PreDisplay).permit_status_element)
  BrowserActions.wait_until_is_visible(on(PreDisplay).new_entry_log_element) if status == 'Permit Activated'
  4.times { is_equal(on(PreDisplay).permit_status_element.text, status) }
end

And(/^\(for pred\) I should see warning box "Gas reading is missing" on "Entry log"$/) do
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entry_log_btn_element)
  sleep 2
  is_equal(on(PreDisplay).info_gas_testing_is_missing_elements.first.text,
           "Please Terminate This Permit and\nCreate A New Permit")
  is_equal(on(PreDisplay).info_gas_testing_is_missing_elements.last.text,
           'Initial gas reading for this permit is missing.')
end

And(/^I take note of PRE permit creator name and activate the the current PRE form$/) do
  step 'I open the current PRE with status Pending approval. Rank: C/O'
  sleep 1
  step 'I press the "Approve for Activation" button'
  step 'I sign with valid C/O rank'
  step "I should see the page 'Permit Successfully Scheduled for Activation'"
  sleep 1
  step 'I press the "Back to Home" button'
end

Then(/^I should see the PRE permit creator name on PRED$/) do
  sleep 5
  is_equal(on(PreDisplay).pre_creator_display_element.text, '3/O COT 3/O')
end

Then(/^I check "Responsible Officer Signature" is present$/) do
  sleep 5
  BrowserActions.wait_until_is_visible(on(PumpRoomEntry).resp_off_signature_element)
  is_equal(on(PumpRoomEntry).resp_off_signature_element.text, 'Responsible Officer Signature:')
  is_equal(on(PumpRoomEntry).resp_off_signature_rank_elements[0].text, 'Rank/Name')
  on(PumpRoomEntry).get_element_by_value('C/O COT C/O', 0)
  on(PumpRoomEntry).get_element_by_value('3 Cargo Tank Vent', 0)
end

Then(/^I check location in gas readings signature is present$/) do
  sleep 2
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).show_signature_display_element)
  on(PumpRoomEntry).get_element_by_value('C/O COT C/O', 0)
  is_not_equal(on(PreDisplay).sign_component_text?, '')
end

Then(/^I should see (Home|Entry Log|Permit) tab$/) do |condition|
  sleep 1
  if condition == 'Entry Log'
    is_enabled(on(PumpRoomEntry).entry_log_table_elements.first)

    raise('Entry log is exist') unless on(PreDisplay).no_entry_yet_element.empty?
  end
end
