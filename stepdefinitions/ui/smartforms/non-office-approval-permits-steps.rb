# frozen_string_literal: true

And (/^I select a any permits$/) do
  on(SmartFormsPermissionPage).select_permit
end

Then (/^I should see permit details are pre-filled$/) do
  is_equal(on(SmartFormsPermissionPage).ptw_id_element.text, on(SmartFormsPermissionPage).permit_type)
end
