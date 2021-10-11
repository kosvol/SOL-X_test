# frozen_string_literal: true

Then('I should see both signature canvas exists') do
  is_equal(on(SignaturePage).signature_elements.size, 2)
end

And(/^I (select|delete) (.+) role from list$/) do |condition, roles|
  on(Section5Page).sel_roles_responsibility(roles) if condition == 'select'
  on(Section5Page).del_roles_responsibilities(roles) if condition == 'delete'
end

And(/^I fill up section 5$/) do
  step 'I select 1 role from list'
  step 'I fill up non crew details'
  step 'I sign on role with sponsor crew C/O rank'
  BrowserActions.scroll_up
end

And(/^I sign on listed role$/) do
  BrowserActions.scroll_click(on(Section5Page).sign_btn_role_elements.first)
  step 'I sign with valid C/O rank'
  sleep 1
end

Then(/^I should see (.+) role listed$/) do |totalroles|
  is_equal(on(Section5Page).responsibility_box_elements.size, totalroles)
end

And(/^I (should|should not) see (.+) role$/) do |condition, role|
  sleep 1
  case condition
  when 'should'
    is_true(on(Section5Page).role?(role))
  when 'should not'
    is_false(on(Section5Page).role?(role))
  end
end

When(/^I delete the role from cross$/) do
  on(Section3CPage).cross_btn_elements.first.click
end

Then(/^I should see a list of roles$/) do
  on(Section5Page).roles_and_resp_btn
  is_true(on(Section5Page).list_of_roles?)
end

And(/^I sign on role with non sponsor crew (.*) rank$/) do |rank|
  on(Section5Page).sign_btn_role_elements.first.click
  step "I enter pin for rank #{rank}"
end

And(/^I sign on role$/) do
  on(Section5Page).sign_btn_role_elements.first.click
  step 'I sign with valid C/O rank'
  step 'I set time'
end

And(/^I sign on next role with same user$/) do
  on(Section5Page).sign_btn_role_elements.last.click
  step 'I sign with valid C/O rank'
  step 'I set time'
end

Then(/^I should see (.*) signed role details with (.*) pin$/) do |which_role, pin|
  is_true(on(Section5Page).role_sign_usr_detls?(which_role, pin))
end

And(/^I fill up non crew details$/) do
  step 'I check non crew member checkbox'
  on(Section5Page).other_name = 'Test Automation'
  on(Section5Page).other_company = 'Test Automation Company'
end

Then(/^I should see non crew copy text$/) do
  sleep 1
  is_equal(on(Section5Page).non_crew_copy_text, 'Ship Staff to use PIN for non-crew member to enter signature')
end

And(/^I check non crew member checkbox$/) do
  on(Section5Page).non_crew_checkbox_elements.first.click
end

And(/^I sign on role with sponsor crew (.+) rank$/) do |rank|
  on(Section5Page).sign_btn_role_elements.first.click
  step "I sign with valid #{rank} rank"
  step 'I set time'
end

Then(/^I should see non crew details$/) do
  sleep 1
  is_equal(on(Section5Page).signed_rank_and_name_elements.first.text, 'Test Automation')
  if on(Section5Page)
     .get_non_crew_date_time_element.text == "#{on(Section5Page)
                                                    .get_current_date_format_with_offset} #{on(Section5Page)
                                                                                              .get_current_time_format}"
    is_equal(on(Section5Page).get_non_crew_date_time_element.text,
             "#{on(Section5Page).get_current_date_format_with_offset} #{on(Section5Page).get_current_time_format}")
  else
    is_equal(on(Section5Page).get_non_crew_date_time_element.text, on(CommonFormsPage)
                                                                     .get_current_date_and_time_minus_a_min)
  end
end

And(/^I should see supervise by (.+) detail and (.+) detail$/) do |supervized, company|
  is_equal(on(Section5Page).get_filled_crew_details_elements.first.text, supervized)
  is_equal(on(Section5Page).get_filled_crew_details_elements.last.text, company)
end
