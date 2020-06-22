# frozen_string_literal: true

Then('I should see a list of available forms for selections') do |_table|
  on(SmartFormsPermissionPage).click_permit_type_ddl
  is_true(on(SmartFormsPermissionPage).is_level_1_permit?(_table.raw))
end

And (/^I navigate to create new permit to work$/) do
  on(SmartFormsPermissionPage).click_create_permit_btn
end

And ('I enter RA pin {int}') do |_pin|
  on(PinPadPage).enter_pin(_pin)
end

Then (/^I (should|should not) see smart form landing screen$/) do |_condition|
  if _condition === 'should'
    is_true(on(SmartFormsPermissionPage).ptw_id_element.text.include?('SIT/PTW/'))
  end
  if _condition === 'should not'
    # is_true(on(SmartFormsPermissionPage).ptw_id_element.text.include?('SIT/PTW/'))
  end
end

And (/^I tear down created form$/) do
  SmartFormDBPage.tear_down_ptw_form(on(SmartFormsPermissionPage).ptw_id_element.text)
end

When (/^I select (.+) permit$/) do |_permit|
  on(SmartFormsPermissionPage).click_permit_type_ddl
  on(SmartFormsPermissionPage).select_level_1_permit(_permit)
end

Then (/^I should see second level permits details$/) do
  is_true(on(SmartFormsPermissionPage).is_level_2_permits?)
end

And (/^I navigate to level 2 permits$/) do
  step "I select #{['Cold Work', 'Critical Equipment Maintenance', 'Hotwork', 'Rotational Portable Power Tool', 'Underwater Operations'].sample} permit"
end

And (/^I navigate back to SmartForms screen$/) do
  on(SmartFormsPermissionPage).back_btn
  sleep 1
  on(SmartFormsPermissionPage).back_btn
end
