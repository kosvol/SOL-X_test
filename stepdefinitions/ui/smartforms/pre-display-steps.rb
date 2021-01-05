And(/^Navigate to PRE Display$/) do
  BrowserActions.poll_exists_and_click(on(NavigationPage).hamburger_menu_element)
  on(NavigationPage).select_nav_category("Settings")
  step 'I press the "Pump Room Display" button'
  sleep 0.5
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
    box_text = on(PreDisplay).warning_box_element.text
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
    is_equal(on(PreDisplay).permit_status_element.text, status)
end

And(/^\(for pred\) I should see warning box "Gas reading is missing" on "Entry log"$/) do
  box_text = on(PreDisplay).info_gas_testing_is_missing_element.text
  base_data_text = YAML.load_file("data/pre/pre-display.yml")['gas_reading_is_missing']
  is_equal(box_text, base_data_text)
end

