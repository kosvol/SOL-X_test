# frozen_string_literal: true

And (/^I (select|delete) (.+) role from list$/) do |_condition,_total_roles|
  on(Section5Page).select_roles_and_responsibility(_total_roles) if _condition === "select"
  on(Section5Page).delete_roles_and_responsibility(_total_roles) if _condition === "delete"
end

And (/^I sign on listed role$/) do
  BrowserActions.scroll_click(on(Section5Page).sign_btn_elements.first)
  on(PinPadPage).enter_pin(9015)
  step 'I sign on canvas'
  sleep 1
end

Then (/^I should see (.+) role listed$/) do |_total_roles|
  is_equal(on(Section5Page).responsibility_box_elements.size,_total_roles)
end

And (/^I (should|should not) see (.+) role$/) do |_condition,_role|
  sleep 1
  if _condition === "should"
    is_true(on(Section5Page).is_role?(_role))
  elsif _condition === "should not"
    is_false(on(Section5Page).is_role?(_role))
  end
end

When (/^I delete the role from cross$/) do
  on(Section5Page).roles_btn_elements.first.click
end

Then (/^I should see a list of roles$/) do
  on(Section5Page).roles_and_resp_btn
  is_true(on(Section5Page).is_list_of_roles?)
end

And (/^I sign on role$/) do
  on(Section5Page).sign_btn_elements.first.click
  step "I enter pin 9015"
  step 'I sign on canvas'
  on(CommonFormsPage).set_current_time
end

Then (/^I should see signed role details$/) do
  is_true(on(Section5Page).is_role_signed_user_details?("9015"))
end

