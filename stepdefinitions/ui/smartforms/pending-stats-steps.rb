# frozen_string_literal: true

Then (/^I should see (.+) button$/) do |state|
  if state === 'Office Approval'
    is_equal(on(PendingStatePage).get_button_text, 'Office Approval')
  elsif state === 'Master Approval'
    is_equal(on(PendingStatePage).get_button_text, 'Master Approval')
  elsif state === 'Master Review'
    is_equal(on(PendingStatePage).get_button_text, 'Master Review')
  end
end

Then (/^I should see the newly pending approval permit details listed on Pending Approval filter$/) do
  @@pending_approval_permit_data = on(PendingStatePage).set_section1_filled_data
  p ">> #{@@pending_approval_permit_data}"
  # does_include(on(CreatedPermitToWorkPage).ptw_id_elements.first.text, "SIT/PTW/#{BrowserActions.get_year}/")
  is_equal(@@pending_approval_permit_data[1], on(CreatedPermitToWorkPage).ptw_id_elements.first.text)
  is_equal(@@pending_approval_permit_data[2], on(CreatedPermitToWorkPage).created_by_elements.first.text)
  is_equal(@@pending_approval_permit_data[3], on(CreatedPermitToWorkPage).created_date_time_elements.first.text)
end

And (/^I set oa permit to office approval state manually$/) do
  on(PendingStatePage).master_review_btn_elements.first.click
  step 'I enter pin 1111'
  step 'I press next for 10 times'
  on(PendingStatePage).submit_for_oa_btn
  step 'I click on back to home'
end
