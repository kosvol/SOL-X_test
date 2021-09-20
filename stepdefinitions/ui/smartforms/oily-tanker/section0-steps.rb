# frozen_string_literal: true

Then(/^I should see (green|red) online blob$/) do |color|
  wifi_blob_locator = "//nav[contains(@class,'NavigationBar__NavBar')]/section[contains(@class, 'NavigationBar__RightContent')]//*[local-name()='svg']"
  case color
  when 'green'
    sleep 2
    step 'I open hamburger menu'
    wifi_blob_color_code = BrowserActions.poll_ui_update_by_attribute(wifi_blob_locator, 'online', 'class')
    Log.instance.info "Wifi Blob Status: #{wifi_blob_color_code}"
    is_equal(wifi_blob_color_code.to_s, 'online')
    else
    wifi_blob_color_code = BrowserActions.poll_ui_update_by_attribute(wifi_blob_locator, '', 'class')
    Log.instance.info "Wifi Blob Status: #{wifi_blob_color_code}"
    is_equal(wifi_blob_color_code.to_s, '')
  end
end

Then('I should see a list of available forms for selections') do |table|
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  table.raw.each_with_index do |element, index|
    is_equal(element.first, on(Section0Page).list_permit_type_elements[index].text)
  end
end

And(/^I navigate to create new permit$/) do
  begin
    BrowserActions.poll_exists_and_click(on(Section0Page).click_create_permit_btn_element)
  rescue StandardError
    BrowserActions.poll_exists_and_click(on(Section0Page).uat_create_permit_btn_element)
  end
  on(Section0Page).reset_data_collector
end

Then(/^I should see smart form landing screen$/) do
  is_true(on(Section0Page).select_permit_type_element.text.include?('Select Permit Type'))
end

Then(/^I should see second level permits details$/) do
  base_permits = YAML.load_file('data/permit-types.yml')[on(Section0Page).get_section1_filled_data.first]
  is_equal(on(Section0Page).list_permit_type_elements.size, base_permits.size)
  on(Section0Page).list_permit_type_elements.each_with_index do |element, index|
    is_equal(element.text, base_permits[index])
  end
end

And(/^I navigate back to permit selection screen$/) do
  BrowserActions.poll_exists_and_click(on(Section0Page).back_btn_element)
  BrowserActions.poll_exists_and_click(on(Section0Page).close_btn_elements.first)
end

And(/^I click on (.+) filter$/) do |state|
  case state
  when 'pending approval'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements.first)
  when 'update needed'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[1])
  when 'active'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[2])
  when 'pending withdrawal'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[3])
  end
end

And(/^I navigate back to dashboard$/) do
  sleep 1
  step 'I navigate to "Settings" screen for setting'
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).smartforms_display_setting_element)
  step 'I press the "Enter Pin & Apply" button'
end
