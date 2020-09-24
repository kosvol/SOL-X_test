# frozen_string_literal: true

Then('I should see a list of available forms for selections') do |_table|
  on(Section0Page).click_permit_type_ddl
  _table.raw.each_with_index do |_element,_index|
      is_equal(_element.first,on(Section0Page).list_permit_type_elements[_index].text)
  end
end

And (/^I navigate to create new permit$/) do
  on(Section0Page).click_create_permit_btn
  on(Section0Page).reset_data_collector
  sleep 1
end

Then (/^I should see smart form landing screen$/) do
    is_true(on(Section0Page).ptw_id_element.text.include?('SIT/PTW/'))
end

Then (/^I should see second level permits details$/) do
  base_permits = YAML.load_file('data/permits.yml')[CommonPage.get_permit_id]
  on(Section0Page).list_permit_type_elements.each_with_index do |_element,_index|
    is_equal(_element.text,base_permits[_index])
  end
end

And (/^I navigate back to permit selection screen$/) do
  on(Section0Page).back_btn
  sleep 1
  on(Section0Page).back_btn
end

And (/^I click on (.+) filter$/) do |state|
  sleep 2
  if state === 'pending approval'
    BrowserActions.click_element(on(Section0Page).permit_filter_elements[0])
    sleep 1
    CommonPage.set_permit_id(on(Section0Page).created_ptw_id_elements[1].text)
  elsif state === 'update needed'
    BrowserActions.click_element(on(Section0Page).permit_filter_elements[1])
  elsif state === 'active'
    BrowserActions.click_element(on(Section0Page).permit_filter_elements[2])
  elsif state === 'pending withdrawal'
    BrowserActions.click_element(on(Section0Page).permit_filter_elements[3])
  end
end
