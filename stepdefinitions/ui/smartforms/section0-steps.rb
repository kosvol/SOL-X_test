# frozen_string_literal: true

Then('I should see a list of available forms for selections') do |_table|
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  _table.raw.each_with_index do |_element, _index|
    is_equal(_element.first, on(Section0Page).list_permit_type_elements[_index].text)
  end
end

And (/^I navigate to create new permit$/) do
  BrowserActions.poll_exists_and_click(on(Section0Page).click_create_permit_btn_element)
  on(Section0Page).reset_data_collector
end

Then (/^I should see smart form landing screen$/) do
  is_true(on(Section0Page).select_permit_type_element.text.include?('Select Permit Type'))
end

Then (/^I should see second level permits details$/) do
  base_permits = YAML.load_file('data/permits.yml')[CommonPage.get_permit_id]
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
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[0])
    # this is use to pick up correct permit id due to temp id usage during creation
    begin
      CommonPage.set_permit_id(on(Section0Page).created_ptw_id_elements[1].text)
    rescue StandardError
    end
  elsif state === 'update needed'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[1])
  elsif state === 'active'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[2])
  elsif state === 'pending withdrawal'
    BrowserActions.poll_exists_and_click(on(Section0Page).permit_filter_elements[3])
  end
end
