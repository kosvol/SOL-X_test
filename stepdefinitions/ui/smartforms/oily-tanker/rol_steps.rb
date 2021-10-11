# frozen_string_literal: true

And(/^I should see rol info box$/) do
  is_equal(on(ROLPage).foot_note_element.text,
           "1. Deck officer shall be the Responsible Officer to supervise the task and be responsible for safety.\n2. This permit shall be issued for one side (port/Stbd) boarding arrangement only. Its not valid for both side.\n3. This permit shall be issued while rigging ship's gangway/MOT if working overside by personnel is involved.")
end

And(/^I fill rol permit$/) do
  step 'I add a new hazard'
  on(ROLPage).fill_rol_forms
  step 'I sign section with C/O as valid rank'
  step 'I should see signed details'
  step 'I press next for 1 times'
  sleep 1
  on(ROLPage).fill_rol_checklist
end

And(/^I open up active rol permit$/) do
  sleep 1
  on(ROLPage).view_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)].click
end

Then(/^I should see view and termination buttons$/) do
  is_equal(on(ActiveStatePage).view_btn_elements.first.text, 'View')
  is_equal(on(ActiveStatePage).terminate_permit_btn_elements.first.text, 'View / Terminate')
end

And(/^I request update for permit$/) do
  step 'I request for update without submitting'
  sleep 1
  on(Section0Page).submit_update_btn_elements.last.click
end

Then(/^I should not see extra buttons$/) do
  step 'I update permit with C/O rank'
  sleep 1
  is_equal(on(PendingStatePage).previous_btn_elements.size, 0)
  is_equal(on(NavigationPage).save_and_next_btn_elements.size, 1)
end

Then(/^I should not see extra previous and close button$/) do
  on(Section3APage).scroll_multiple_times_with_direction(16, 'down')
  is_equal(on(PendingStatePage).previous_btn_elements.size, 1)
  is_equal(on(CommonFormsPage).close_btn_elements.size, 1)
end

Then(/^I should not see extra previous and save button$/) do
  on(Section3APage).scroll_multiple_times_with_direction(7, 'down')
  is_equal(on(PendingStatePage).previous_btn_elements.size, 1)
  is_equal(on(CommonFormsPage).close_btn_elements.size, 0)
  is_equal(on(CommonFormsPage).save_btn_elements.size, 0)
end

Then(/^I (open|edit) rol permit with rank (.+)$/) do |_condition, _rank|
  if _condition == 'open'
    on(ActiveStatePage)
      .view_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)]
      .click
  else
    on(PendingStatePage)
      .edit_update_btn_elements[on(CreatedPermitToWorkPage)
                                .get_permit_index(CommonPage.get_permit_id)].click
  end
  step "I enter pin for rank #{_rank}"
end

Then(/^I should not see permit duration selectable$/) do
  sleep 1
  on(Section3APage).scroll_multiple_times_with_direction(14, 'down')
  not_to_exists(on(ROLPage).rol_duration_element)
end

When(/^I put the permit to termination state/) do
  step 'I open rol permit with rank C/O'
  step 'I submit permit for termination'
  step 'I sign with valid C/O rank'
  sleep 1
  step 'I click on back to home'
end

When(/^I put the permit to pending termination update status$/) do
  on(PendingWithdrawalPage).review_n_withdraw_elements.first.click
  step 'I enter pin for rank MAS'
  on(ROLPage).request_update_btn
  sleep 2
  BrowserActions.enter_text(on(Section0Page).enter_comment_box_element, 'Test Automation')
  on(Section0Page).submit_update_btn_elements.first.click
end