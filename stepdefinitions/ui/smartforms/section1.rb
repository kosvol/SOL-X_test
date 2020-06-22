# frozen_string_literal: true

And (/^I select a any permits$/) do
  on(SmartFormsPermissionPage).select_permit
end

Then (/^I should see permit details are pre-filled$/) do
  is_equal(on(SmartFormsPermissionPage).permit_type, on(SmartFormsPermissionPage).permit_type)
  is_equal(on(SmartFormsPermissionPage).form_number, on(SmartFormsPermissionPage).ptw_id_element.text)
  is_equal(on(SmartFormsPermissionPage).vessel_short_name, 'SIT')
end

Then (/^I should see a list of sea states$/) do |_table|
  is_true(on(Section1Page).is_sea_states?(_table.raw))
end

Then (/^I should see a list of wind forces$/) do |_table|
  is_true(on(Section1Page).is_wind_forces?(_table.raw))
end
