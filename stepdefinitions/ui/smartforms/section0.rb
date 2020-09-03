# frozen_string_literal: true

Then('I should see a list of available forms for selections') do |_table|
  on(Section0Page).click_permit_type_ddl
  is_true(on(Section0Page).is_level_1_permit?(_table.raw))
end

And (/^I navigate to create new permit$/) do
  on(Section0Page).click_create_permit_btn
  on(Section0Page).set_current_time
  on(Section0Page).reset_data_collector
  sleep 1
end

Then (/^I (should|should not) see smart form landing screen$/) do |_condition|
  if _condition === 'should'
    is_true(on(Section0Page).ptw_id_element.text.include?('SIT/PTW/'))
  end
  if _condition === 'should not'

  end
end

And (/^I tear down created form$/) do
  begin
    SmartFormDBPage.tear_down_ptw_form(on(Section1Page).get_section1_filled_data[1])
  rescue StandardError
    SmartFormDBPage.tear_down_ptw_form(on(Section0Page).ptw_id_element.text)
  end
end

When (/^I select (.+) permit$/) do |_permit|
  # sleep 1
  on(Section0Page).click_permit_type_ddl
  sleep 1
  on(Section0Page).select_permit(_permit)
end

When (/^I select (.+) permit for level 2$/) do |_permit|
  sleep 1
  on(Section0Page).select_permit(_permit)
  sleep 1
  on(Section0Page).save_btn
  sleep 1
  on(Section0Page).set_selected_level2_permit(_permit)
end

Then (/^I should see second level permits details$/) do
  is_true(on(Section0Page).is_level_2_permits?)
end

And (/^I navigate to level 2 permits$/) do
  step "I select #{['Cold Work', 'Critical Equipment Maintenance', 'Hot Work', 'Rotational Portable Power Tools', 'Underwater Operations'].sample} permit"
end

And (/^I navigate back to permit selection screen$/) do
  on(Section0Page).back_btn
  sleep 1
  on(Section0Page).back_btn
end

And (/^I click on back to home$/) do
  sleep 2
  on(Section6Page).back_to_home_btn
end

And (/^I click on (.+) filter$/) do |state|
  sleep 1
  if state === 'pending approval'
    on(Section0Page).permit_filter_elements[0].click
  elsif state === 'update needed'
    on(Section0Page).permit_filter_elements[1].click
  elsif state === 'active'
    on(Section0Page).permit_filter_elements[2].click
  elsif state === 'pending withdrawal'
    on(Section0Page).permit_filter_elements[3].click
  end
end
