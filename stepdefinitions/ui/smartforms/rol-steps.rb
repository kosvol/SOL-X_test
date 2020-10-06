Then (/^I should see view and termination buttons$/) do
  is_equal(on(ActiveStatePage).view_btn_elements[0].text,"View")
  is_equal(on(ActiveStatePage).submit_termination_btn1_elements[0].text,"Submit for Termination")
end

And (/^I request update for permit$/) do
  step 'I press next for 1 times'
  begin
    on(Section7Page).update_btn
  rescue 
    on(Section7Page).request_update_btn
  end
  sleep 1
  BrowserActions.enter_text(on(Section0Page).enter_comment_box_element,"Test Automation")
  on(Section0Page).submit_update_btn_elements.first.click
end

Then (/^I should not see extra buttons$/) do
  on(PendingStatePage).edit_update_btn_elements.first.click
  step 'I enter pin 9015'
  step 'I press next for 1 times'
  sleep 1
  is_equal(on(PendingStatePage).submit_for_master_approval_btn_elements.size,1)
  is_equal(on(PendingStatePage).previous_btn_elements.size,1)
  is_equal(on(PendingStatePage).save_and_close_btn_elements.size,1)
end

Then (/^I should not see extra previous and close button$/) do
  on(Section3APage).scroll_multiple_times(7)
  is_equal(on(PendingStatePage).previous_btn_elements.size,1)
  is_equal(on(PendingStatePage).close_btn_elements.size,1)
end

Then (/^I (open|edit) rol permit with rank (.+) and (.+) pin$/) do |_condition,_rank,_pin|
  _condition === "open" ? on(ActiveStatePage).view_btn_elements.first.click : on(PendingStatePage).edit_update_btn_elements.first.click
  step "I enter pin #{_pin}"
end

Then (/^I should not see permit duration selectable$/) do
  sleep 1
  on(Section3APage).scroll_multiple_times(14)
  not_to_exists(on(ROLPage).rol_duration_element)
end

When (/^I put the permit to termination state/) do
  step 'I click on back arrow'
  step 'I click on active filter'
  step "I open rol permit with rank A/M and 9015 pin"
  step 'I press next for 2 times'
  on(Section0Page).submit_termination_btn_elements.first.click
  step "I enter pin 9015"
  step 'I sign on canvas'
  sleep 1
  step 'I click on back to home'
end

And (/^I review termination permit with (.+) pin$/) do |_pin|
  step 'I click on pending withdrawal filter'
  on(Section0Page).review_and_terminate_btn_elements.first.click
  step "I enter pin #{_pin}"
end

When (/^I put the permit to pending termination update status$/) do
  step 'I click on back arrow'
  step 'I click on pending withdrawal filter'
  on(Section0Page).review_and_terminate_btn_elements.first.click
  step "I enter pin 1111"
  on(ROLPage).request_update_btn
  sleep 2
  BrowserActions.enter_text(on(Section0Page).enter_comment_box_element,"Test Automation")
  on(Section0Page).submit_update_btn_elements.first.click
end