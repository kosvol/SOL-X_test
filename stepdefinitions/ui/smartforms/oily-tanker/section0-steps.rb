# frozen_string_literal: true

Then (/^I should see (green|red) online blob$/) do |_color|
  p "#{@browser.find_element(:xpath, "//nav[contains(@class,'NavigationBar__NavBar')]/section[contains(@class, 'NavigationBar__RightContent')]/div[1]").css_value('background-color')}"
  wifi_blob_color_code = @browser.find_element(:xpath, "//nav[contains(@class,'NavigationBar__NavBar')]/section[contains(@class, 'NavigationBar__RightContent')]/div[1]").css_value('background-color')
  if _color === "green"
    is_equal(wifi_blob_color_code,"rgba(118, 210, 117, 1)")
  elsif _color === "red"
    is_equal(wifi_blob_color_code,"rgba(255, 125, 119, 1)")
  end
  
end

Then('I should see a list of available forms for selections') do |_table|
  # on(Section0Page).click_permit_type_ddl
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  _table.raw.each_with_index do |_element, _index|
    is_equal(_element.first, on(Section0Page).list_permit_type_elements[_index].text)
  end
end

And (/^I navigate to create new permit$/) do
  # on(Section0Page).click_create_permit_btn_element.click
  BrowserActions.poll_exists_and_click(on(Section0Page).click_create_permit_btn_element)
  on(Section0Page).reset_data_collector
end

Then (/^I should see smart form landing screen$/) do
  is_true(on(Section0Page).select_permit_type_element.text.include?('Select Permit Type'))
end

Then (/^I should see second level permits details$/) do
  base_permits = YAML.load_file('data/permits.yml')[CommonPage.get_permit_id]
  is_equal(on(Section0Page).list_permit_type_elements.size, base_permits.size)
  on(Section0Page).list_permit_type_elements.each_with_index do |_element, _index|
    is_equal(_element.text, base_permits[_index])
  end
end

And (/^I navigate back to permit selection screen$/) do
  on(Section0Page).back_btn
  BrowserActions.poll_exists_and_click(on(Section0Page).close_btn_elements.first)
end

And (/^I click on (.+) filter$/) do |state|
  if state === 'pending approval'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements.first)
  elsif state === 'update needed'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[1])
  elsif state === 'active'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[2])
  elsif state === 'pending withdrawal'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[3])
  end
end

And (/^I navigate back to dashboard$/) do
  sleep 1
  step 'I navigate to "Settings" screen for setting'
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).smartforms_display_setting_element)
  step 'I press the "Enter Pin & Apply" button'
end
