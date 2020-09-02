# frozen_string_literal: true

Then (/^I should see the newly created permit details listed on Created Permits to Work$/) do
  @@created_permit_data = on(Section1Page).set_section1_filled_data
  is_equal(@@created_permit_data[1], on(CreatedPermitToWorkPage).ptw_id_elements.first.text)
  is_equal(@@created_permit_data[4], on(CreatedPermitToWorkPage).created_by_elements.first.text)
  is_equal(@@created_permit_data[5], on(CreatedPermitToWorkPage).created_date_time_elements.first.text)
end

And (/^I want to edit the newly created permit$/) do
  on(CreatedPermitToWorkPage).edit_permit_btn_elements[0].click
end

Then (/^I should see correct permit details$/) do
  is_equal(on(SmartFormsPermissionPage).generic_data_elements[2].text, on(Section1Page).get_section1_filled_data[2])
  is_equal(on(SmartFormsPermissionPage).generic_data_elements[1].text, on(SmartFormsPermissionPage).ptw_id_element.text)
  is_equal(on(SmartFormsPermissionPage).generic_data_elements[0].text, 'SIT')
end

And (/^I should see form is at reading mode for (.+) rank and (.+) pin$/) do |_rank, _pin|
  sleep 1
  on(CreatedPermitToWorkPage).select_created_permit_with_param(on(CreatedPermitToWorkPage).get_section1_filled_data[1]).click
  step "I enter pin #{_pin}"
end

Then (/^I should see permit id populated$/) do
  is_true(does_include(on(SmartFormsPermissionPage).form_number, 'SIT/PTW/'))
end

And (/^I edit ptw with rank (.+) and (.+) pin$/) do |_rank, _pin|
  on(CreatedPermitToWorkPage).edit_permit_btn_elements.first.click
  step "I enter pin #{_pin}"
end

Then (/^I should see checklist section with fields enabled$/) do
  # step 'I press next from section 1'
  step 'I press next for 6 times'
  is_false(on(Section4APage).is_checklist_fields_disabled?)
  step 'I press next for 1 times'
  is_false(on(Section4APage).is_checklist_fields_disabled?)
  is_enabled(on(Section4APage).enter_pin_btn_element)
end

And (/^I should see eic selection fields enabled$/) do
  step 'I press next for 1 times'
  is_enabled(on(Section4BPage).yes_no_btn_elements[0])
  is_enabled(on(Section4BPage).yes_no_btn_elements[1])
end

And (/^I should see gas reading section with fields enabled$/) do
  step 'I press next for 2 times'
  is_enabled(on(Section6Page).gas_yes_no_elements[0])
  is_enabled(on(Section6Page).gas_yes_no_elements[1])
end

Then (/^I should see gas reader section with fields enabled$/) do
  # step 'I press next from section 1'
  step 'I press next for 10 times'
  is_false(on(Section4APage).is_checklist_fields_disabled?)
end

Then (/^I should see EIC section with fields enabled$/) do
  # step 'I press next from section 1'
  step 'I press next for 9 times'
  is_false(on(Section4APage).is_checklist_fields_disabled?)
end

Then (/^I should see all section fields enabled$/) do
  is_false(on(Section1Page).is_fields_enabled?)
  # step 'I press next from section 1'
end

Then (/^I should see all section fields disabled$/) do
  is_true(!on(Section1Page).is_fields_enabled?)
  # step 'I press next from section 1'
end

Then (/^I should see deleted permit deleted$/) do
  is_true(on(CreatedPermitToWorkPage).is_created_permit_deleted?)
end

And (/^I delete the permit created$/) do
  on(CreatedPermitToWorkPage).delete_created_permit.click
  step 'I enter pin 1111'
end

Then (/^I should see the total permits in CREATED state match backend results$/) do
  sleep 1
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  sleep 1
  step 'I get forms-filter/get-created-permits request payload'
  step 'I hit graphql'
  is_equal(ServiceUtil.get_response_body['data']['form']['edges'].to_a.size, on(CreatedPermitToWorkPage).parent_container_elements.size)
end
