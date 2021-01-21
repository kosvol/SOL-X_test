And(/^I navigate to PRE Display$/) do
  step 'I navigate to "Settings" screen for setting'
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).pump_room_display_setting_element)
  step 'I press the "Enter Pin & Apply" button'
end

And(/^\(for pred\) I should see the (disabled|enabled) "([^"]*)" button$/) do |_condition, button|
  if _condition === 'disabled'
    is_true(on(PreDisplay).is_element_disabled_by_att?(button))
  end

  if _condition === 'enabled'
    is_false(on(PreDisplay).is_element_disabled_by_att?(button))
  end
end

And (/^\(for pred\) I should see (info|warning) box for (activated|deactivated) status$/) do |which_box, status|
  if which_box === "warning"
    begin
      box_text = on(PreDisplay).warning_box_element.text
    rescue StandardError
      box_text = @browser.find_element(:xpath, "//div[starts-with(@class,'WarningBox')]").text
    end
    base_data_text = YAML.load_file("data/pre/pre-display.yml")['warning_box'][status]
    is_equal(box_text, base_data_text)
  end
end

Then (/^I should see (green|red) background color$/) do |condition|
  background_color = @browser.find_element(:xpath, "//*[@id='root']/main").css_value('background-color')
  if condition == "green"
    green = "rgba(67, 160, 71, 1)"
    is_equal(background_color, green)

  elsif condition == "red"
    red = "rgba(216, 75, 75, 1)"
    is_equal(background_color, red)
  end
end

And(/^I should see (Permit Activated|Permit Terminated) PRE status on screen$/) do |status|
  sleep 2
  is_equal(on(PreDisplay).permit_status_element.text, status)
end

And(/^\(for pred\) I should see warning box "Gas reading is missing" on "Entry log"$/) do
  on(PumpRoomEntry).entry_log_btn_element.click
  sleep 2
  is_equal(on(PreDisplay).info_gas_testing_is_missing_elements.first.text,"Please Terminate This Permit and\nCreate A New Permit")
  is_equal(on(PreDisplay).info_gas_testing_is_missing_elements.last.text,"Initial gas reading for this permit is missing.")
end

And(/^I take note of PRE permit creator name and activate the the current PRE form$/) do
  step 'I open the current PRE with status Pending approval. Pin: 8383'
  # @preCreatorName = on(PumpRoomEntry).pre_creator_form_element.text
  # p "PRE Creator>> #{@preCreatorName}"
  sleep 1
  step 'I press the "Approve for Activation" button'
  step "I sign on canvas with valid 8383 pin"
  step "I should see the page 'Permit Successfully Scheduled for Activation'"
  sleep 1
  step 'I press the "Back to Home" button'
end

Then(/^I should see the PRE permit creator name on PRED$/) do
  sleep 2
  is_equal(on(PreDisplay).pre_creator_display_element.text, "3/O Tim Kinzer")
end