# frozen_string_literal: true

Then (/^I should see Note from (.*)$/) do |_requested_from|
  p ">> #{on(PendingStatePage).action_required_note_elements.first.text}"
  if _requested_from === "Office"
    is_equal(on(PendingStatePage).action_required_note_elements.first.text,"See Notes from Office")
  elsif _requested_from === "Master"
    is_equal(on(PendingStatePage).action_required_note_elements.first.text,"See Notes from Master")
  end
end

Then (/^I should see correct OA submission text$/) do
  on(PendingStatePage).submit_oa_btn
  sleep 2
  is_equal(on(Section3APage).total_p_elements.first.text,"The relevant authority will review this permit.\n\nOnce this permit is approved, you will receive a confirmation via email and will be able to find it under \"Pending Approval\" on the dashboard.")
end

Then (/^I should not be able to edit (.*) DRA$/) do |_permit|
  sleep 1
  step 'I click on View Edit Hazard'
  sleep 1
  on(Section3APage).scroll_multiple_times(2)
  on(Section3APage).delete_btn_elements.each do |_elem|
    is_disabled(_elem)
  end
  is_equal(on(Section3APage).total_p_elements.size,14) if _permit === 'Enclosed Spaces Entry'
  is_equal(on(Section3APage).total_p_elements.size,4) if _permit === 'Use of non-intrinsically safe Camera'
  on(Section3APage).scroll_multiple_times(2)
  on(CommonFormsPage).close_btn_elements.first.click
end

Then (/^I should not be able to edit EIC certification$/) do
  sleep 1
  BrowserActions.poll_exists_and_click(on(Section4BPage).view_eic_btn_element)
  on(Section3APage).scroll_multiple_times(5)
  is_equal(on(Section3APage).total_p_elements.size,27)
  # on(CommonFormsPage).close_btn_elements.first.click
end

Then (/^I should be navigated back to (.*) screen$/) do |which_screen|
  if which_screen === "pending approval"
    is_equal(on(Section0Page).ptw_id_element.text,"Pending Approval Permits to Work")
  elsif which_screen === "active"
    is_equal(on(Section0Page).ptw_id_element.text,"Active Permits to Work")
  end
end

Then (/^I should see (.+) button$/) do |state|
  if state === 'Office Approval'
    is_equal(on(PendingStatePage).office_approval_btn_elements.first.text, 'Office Approval')
  elsif state === 'Master Approval'
    is_equal(on(PendingStatePage).master_approval_btn_elements.first.text, 'Master Approval')
  elsif state === 'Master Review'
    is_equal(on(PendingStatePage).master_review_btn_elements.first.text, 'Master Review')
  elsif state === 'View EIC certification'
    is_equal(on(Section4BPage).view_eic_btn_element.text, 'View/Edit Energy Isolation Certificate')
  elsif state === 'close'
    is_equal(on(Section7Page).close_btn_elements.first.text, 'Close')
  end
end

Then (/^I should see the newly pending approval permit details listed on Pending Approval filter$/) do
  step 'I set time'
  @@pending_approval_permit_data = on(PendingStatePage).set_section1_filled_data
  p ">> #{@@pending_approval_permit_data}"
  does_include(on(CreatedPermitToWorkPage).ptw_id_elements.first.text, "#{$current_environment.upcase}/PTW/#{BrowserActions.get_year}/")
  is_equal(@@pending_approval_permit_data[2], on(CreatedPermitToWorkPage).created_by_elements.first.text)
  p "base >> #{@@pending_approval_permit_data[3]}"
  if @@pending_approval_permit_data[3] === on(CreatedPermitToWorkPage).created_date_time_elements.first.text
    is_equal(@@pending_approval_permit_data[3], on(CreatedPermitToWorkPage).created_date_time_elements.first.text)
  else
    is_equal(on(CommonFormsPage).get_current_date_and_time_minus_a_min, on(CreatedPermitToWorkPage).created_date_time_elements.first.text)
  end
end

And (/^I set oa permit to office (approval|review) state manually$/) do |_condition|
  on(PendingStatePage).master_review_btn_elements.first.click if _condition === "approval"
  on(PendingStatePage).master_approval_btn_elements.first.click if _condition === "review"
  step 'I enter pin for rank MAS'
  step 'I navigate to section 6' if _condition === "approval"
  step 'I navigate to section 7' if _condition === "review"
  on(PendingStatePage).submit_oa_btn
  sleep 1
  step 'I click on back to home'
  sleep 1
end

And (/^Master request for oa permit update$/) do
  on(PendingStatePage).master_approval_btn_elements.first.click
  step 'I enter pin for rank MAS'
  step 'I press next for 11 times'
  on(PendingStatePage).set_update_comment
  step 'I click on back to home'
end

Then (/^I should be able to open permit as master without seeing blank screen$/) do
  on(PendingStatePage).master_approval_btn_elements.first.click
  step 'I enter pin for rank MAS'
  is_equal(on(Section1Page).generic_data_elements[0].text, 'SOLX Automation Test')
end

And (/^I reapprove the updated permit$/) do
  step 'I click on update needed filter'
  BrowserActions.click_element(on(PendingStatePage).edit_update_btn_elements.first)
  step 'I enter pin for rank A/M'
  step 'I navigate to section 6'
  BrowserActions.click_element(on(PendingStatePage).submit_master_review_btn_elements.first)
  step "I sign on canvas with valid 9015 pin"
  step 'I click on back to home'
end
