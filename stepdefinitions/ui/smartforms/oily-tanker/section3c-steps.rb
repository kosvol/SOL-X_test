# frozen_string_literal: true

And(/^I uncheck dra member$/) do
  on(Section3CPage).cross_btn_elements.first.click
end

Then(/^I should see dra member prefilled$/) do
  on(Section3CPage).dra_team_name_list_elements.each do |_element|
    is_equal(_element.text, 'A/M Atif Hayat')
  end
end

And(/^I add additional dra member$/) do
  on(Section3CPage).select_dra_team_member(0)
end

Then(/^I should see list of dra member$/) do
  dra_members = ['Edit Selection', 'MAS Daniel Alcantara', 'A/M Atif Hayat']
  on(Section3CPage).dra_team_name_list_elements.each_with_index do |_element, _index|
    is_equal(_element.text, dra_members[_index])
  end
end

And(/^I remove one of the member via clicking on cross$/) do
  on(Section3CPage).cross_btn_elements.first.click
end

And(/^I remove one of the member from list$/) do
  on(Section3CPage).dra_team_btn
  on(Section3CPage).options_text_elements[1].click
  on(Section3CPage).confirm_btn_elements.first.click
end

Then(/^I should see dra member removed$/) do
  step 'I should see dra member prefilled'
end

And(/^I should see a list of crew$/) do
  on(Section3CPage).dra_team_btn
  sleep 1
  is_equal(on(Section3CPage).options_text_elements.last.text, 'OLR COT OLR')
end
