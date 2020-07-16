# frozen_string_literal: true

Then (/^I should see the newly created permit details listed on Created Permits to Work$/) do
  # data collector; will evolve
  created_permit_data = on(SmartFormsPermissionPage).set_section1_filled_data
  is_equal(created_permit_data[1], on(CreatedPermitToWorkPage).ptw_id_elements.first.text)
  is_equal(created_permit_data[4], on(CreatedPermitToWorkPage).created_by_elements.first.text)
  is_equal(created_permit_data[5], on(CreatedPermitToWorkPage).created_date_time_elements.first.text)
end

And (/^I want to edit the newly created permit$/) do
  on(CreatedPermitToWorkPage).edit_permit_btn_elements[0].click
end

Then (/^I should see correct permit details$/) do
  is_equal(on(SmartFormsPermissionPage).permit_type, on(SmartFormsPermissionPage).get_section1_filled_data[2])
  is_equal(on(SmartFormsPermissionPage).form_number, on(SmartFormsPermissionPage).ptw_id_element.text)
  is_equal(on(SmartFormsPermissionPage).vessel_short_name, 'SIT')
end

And (/^I edit past created permit$/) do
  on(CreatedPermitToWorkPage).edit_permit_btn_elements[1].click
end

Then (/^I should see permit id populated$/) do
  is_true(does_include(on(SmartFormsPermissionPage).form_number, 'SIT/PTW/'))
end

And (/^I edit ptw with rank (.+) and (.+) pin$/) do |_rank, _pin|
  on(CreatedPermitToWorkPage).edit_permit_btn_elements.first.click
  step "I enter RA pin #{_pin}"
end

Then (/^I should see checklist section with fields enabled$/) do
  on(Section1Page).next_btn_elements.first.click
  step 'I press next for 5 times'
  is_true(!on(Section4APage).is_checklist_fields_disabled?)
  step 'I press next for 1 times'
  is_true(!on(Section4APage).is_checklist_fields_disabled?)
  is_enabled(on(Section4APage).enter_pin_btn_element)
end

Then (/^I should see gas reader section with fields enabled$/) do
  on(Section1Page).next_btn_elements.first.click
  step 'I press next for 9 times'
  is_true(!on(Section4APage).is_checklist_fields_disabled?)
end

Then (/^I should see EIC section with fields enabled$/) do
  on(Section1Page).next_btn_elements.first.click
  step 'I press next for 7 times'
  is_true(!on(Section4APage).is_checklist_fields_disabled?)
end
