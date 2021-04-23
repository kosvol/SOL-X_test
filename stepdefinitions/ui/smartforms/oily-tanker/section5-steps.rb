# frozen_string_literal: true

And (/^I (select|delete) (.+) role from list$/) do |_condition, _roles|
  if _condition === 'select'
    on(Section5Page).select_roles_and_responsibility(_roles)
  end
  if _condition === 'delete'
    on(Section5Page).delete_roles_and_responsibility(_roles)
  end
end

And (/^I fill up section 5$/) do
  step 'I select 1 role from list'
  step 'I fill up non crew details'
  step 'I sign on role with sponsor crew 8383 pin'
  BrowserActions.scroll_up
  on(Section5Page).roles_and_resp_btn
  on(Section5Page).roles_btn_elements[2].click
  on(Section5Page).confirm_btn_elements.last.click
  # step 'I select 1 role from list'
end

And (/^I sign on listed role$/) do
  BrowserActions.scroll_click(on(Section5Page).sign_btn_role_elements.first)
  step "I sign on canvas with valid 9015 pin"
  sleep 1
end

Then (/^I should see (.+) role listed$/) do |_total_roles|
  is_equal(on(Section5Page).responsibility_box_elements.size, _total_roles)
end

And (/^I (should|should not) see (.+) role$/) do |_condition, _role|
  sleep 1
  if _condition === 'should'
    is_true(on(Section5Page).is_role?(_role))
  elsif _condition === 'should not'
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

And (/^I sign on role with non sponsor crew (.*) pin$/) do |_pin|
  on(Section5Page).sign_btn_role_elements.first.click
  step "I enter pin #{_pin}"
end

And (/^I sign on role$/) do
  on(Section5Page).sign_btn_role_elements.first.click
  step "I sign on canvas with valid 9015 pin for fsu"
  step 'I set time'
end

And (/^I sign on next role with same user$/) do
  on(Section5Page).sign_btn_role_elements.last.click
  step "I sign on canvas with valid 9015 pin for fsu"
  step 'I set time'
end

Then (/^I should see (.*) signed role details with (.*) pin$/) do |_which_role,_pin|
  is_true(on(Section5Page).is_role_signed_user_details?(_which_role,_pin))
end

And (/^I fill up non crew details$/) do
  step 'I check non crew member checkbox'
  on(Section5Page).other_name = 'Test Automation'
  on(Section5Page).other_company = 'Test Automation Company'
end

Then (/^I should see non crew copy text$/) do
  sleep 1
  is_equal(on(Section5Page).non_crew_copy_text, 'Ship Staff to use PIN for non-crew member to enter signature')
end

And (/^I check non crew member checkbox$/) do
  on(Section5Page).non_crew_checkbox_elements.first.click
end

# Then (/^I should see sign button (disabled|enabled)$/) do |_condition|
#   if _condition === 'disabled'
#     is_disabled(on(Section5Page).sign_btn_role_elements.first)
#   end
#   if _condition === 'enabled'
#     is_enabled(on(Section5Page).sign_btn_role_elements.first)
#   end
# end

And (/^I sign on role with sponsor crew (.+) pin$/) do |_pin|
  @@entered_pin = _pin
  on(Section5Page).sign_btn_role_elements.first.click
  step "I sign on canvas with valid #{_pin} pin for fsu"
  step 'I set time'
end

Then (/^I should see non crew details$/) do
  sleep 1
  is_equal(on(Section5Page).signed_rank_and_name_elements.first.text, 'Test Automation')
  is_equal(on(Section5Page).get_non_crew_date_time_element.text, "#{on(Section5Page).get_current_date_format_with_offset} #{on(Section5Page).get_current_time_format}")
end

And (/^I should see supervise by (.+) detail and (.+) detail$/) do |_supervized, _company|
  is_equal(on(Section5Page).get_filled_crew_details_elements.first.text, _supervized)
  is_equal(on(Section5Page).get_filled_crew_details_elements.last.text, _company)
end
