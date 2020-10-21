# frozen_string_literal: true

And (/^I (select|delete) (.+) role from list$/) do |_condition,_roles|
  on(Section5Page).select_roles_and_responsibility(_roles) if _condition === "select"
  on(Section5Page).delete_roles_and_responsibility(_roles) if _condition === "delete"
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
  step 'I set time'
end

And (/^I sign on both roles with same user$/) do
  step 'I sign on role'
  on(Section5Page).sign_btn_elements.last.click
  step "I enter pin 9015"
  on(Section3DPage).sign_for_gas
  sleep 1
  on(Section3DPage).done_btn_elements.last.click
end

Then (/^I should see signed role details$/) do
  is_true(on(Section5Page).is_role_signed_user_details?("9015"))
end

And (/^I fill up non crew details$/) do
  step 'I check non crew member checkbox'
  on(Section5Page).other_name="Test Automation"
  on(Section5Page).other_company="Test Automation Company"
end

Then (/^I should see non crew copy text$/) do
  sleep 1
  is_equal(on(Section5Page).non_crew_copy_text,'Ship Staff to use PIN for non-crew member to enter signature')
end

And (/^I check non crew member checkbox$/) do
  on(Section5Page).non_crew_checkbox_elements.first.click
end

Then (/^I should see sign button (disabled|enabled)$/) do |_condition|
  is_disabled(on(Section5Page).sign_btn_elements.first) if _condition === "disabled"
  is_enabled(on(Section5Page).sign_btn_elements.first) if _condition === "enabled"
end

And (/^I sign on role with sponsor crew (.+) pin$/) do |_pin|
  on(Section5Page).sign_btn_elements.first.click
  step "I enter pin #{_pin}"
  step 'I sign on canvas'
  step 'I set time'
end

Then (/^I should see non crew details$/) do
  is_equal(on(Section5Page).signed_details_elements[1].text,"Test Automation")
  is_equal(on(Section5Page).signed_details_elements[2].text,"#{on(Section5Page).get_current_date_format_with_offset} #{on(Section5Page).get_current_time_format}")
end

And (/^I should see supervise by (.+) detail and (.+) detail$/) do |_supervized,_company|
  is_equal(on(Section5Page).signed_details_elements[0].text,_supervized)
  is_equal(on(Section5Page).signed_details_elements.last.text,_company)
end