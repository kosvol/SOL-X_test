# frozen_string_literal: true

Then (/^I should see the newly created permit details listed on Created Permits to Work$/) do
  step 'I get ship-local-time/base-get-current-time request payload'
  step 'I hit graphql'
  # data collector; will evolve
  created_permit_data = on(SmartFormsPermissionPage).set_section1_filled_data
  is_equal(created_permit_data[2], on(CreatedPermitToWorkPage).ptw_id_elements.first.text)
  is_equal(created_permit_data[3], on(CreatedPermitToWorkPage).created_by_elements.first.text)
  is_equal(created_permit_data[4], on(CreatedPermitToWorkPage).created_date_time_elements.first.text)
end

And (/^I want to edit the newly created permit$/) do
  on(CreatedPermitToWorkPage).edit_permit_btn_elements[0].click
end

Then (/^I should see correct permit details$/) do
  is_equal(on(SmartFormsPermissionPage).permit_type, on(SmartFormsPermissionPage).get_section1_filled_data[1])
  is_equal(on(SmartFormsPermissionPage).form_number, on(SmartFormsPermissionPage).ptw_id_element.text)
  is_equal(on(SmartFormsPermissionPage).vessel_short_name, 'SIT')
end

And (/^I edit past created permit$/) do
  on(CreatedPermitToWorkPage).edit_permit_btn_elements[1].click
end

Then (/^I should see permit id populated$/) do
  is_true(!is_equal(on(SmartFormsPermissionPage).form_number, ''))
end
