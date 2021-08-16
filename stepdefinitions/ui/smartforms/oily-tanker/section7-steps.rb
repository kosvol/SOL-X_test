# frozen_string_literal: true

Given(/^I change ship local time to (.*) GMT$/) do |duration|
  content_body = JSON.parse JsonUtil.read_json('ship-local-time/change-ship-local-time')
  content_body['variables']['utcOffset'] = duration.to_i
  JsonUtil.create_request_file('ship-local-time/mod-ship-local-time', content_body)
  ServiceUtil.post_graph_ql('ship-local-time/mod-ship-local-time', '1111')
end

Then(/^I should see valid validity from 8 to 9$/) do
  sleep 1
  does_include(on(Section7Page).permit_issued_on_elements[1].text, '08:00 LT (GMT+8)')
  p ">> #{on(Section7Page).permit_valid_until_elements[2].text}"
  does_include(on(Section7Page).permit_valid_until_elements[2].text, '09:00 LT (GMT+8)')
end

Then(/^I should see valid validity date and time$/) do
  sleep 1
  does_include(on(Section7Page).permit_issued_on_elements.first.text, @@issue_time_date)
  p ">> #{on(Section7Page).permit_valid_until_elements.last.text}"
  does_include(on(Section7Page).permit_valid_until_elements.last.text, on(Section7Page).get_validity_until(8))
end

And(/^I click on permit for (.+)$/) do |status|
  on(PendingStatePage).pending_approval_status_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)].click
  sleep 1
end

Then(/^I (should|should not) see approve and request update buttons$/) do |condition|
  on(Section3APage).scroll_multiple_times(4)
  if condition === 'should'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 4)
    is_equal(on(Section7Page).non_oa_buttons_elements.first.text, 'Activate Permit To Work')
    is_equal(on(Section7Page).non_oa_buttons_elements[1].text, 'Request Updates')
    is_equal(on(Section7Page).previous_btn_elements.first.text, 'Previous')
  elsif condition === 'should not'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 5)
    # is_equal(on(Section7Page).close_btn_elements.first.text, 'Close')
    is_equal(on(Section7Page).previous_btn_elements.first.text, 'Previous')
  end
end

Then(/^I (should|should not) see submit for office approval and request update buttons$/) do |condition|
  on(Section3APage).scroll_multiple_times(3)
  if condition === 'should'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 7) # previous 5
    is_equal(on(Section7Page).submit_oa_btn_element.text, 'Submit for Office Approval')
    is_equal(on(Section7Page).update_btn_element.text, 'Updates Needed')
    is_equal(on(Section7Page).previous_btn_elements.first.text, 'Previous')
  elsif condition === 'should not'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 5) # previous 3
    is_equal(on(Section7Page).previous_btn_elements.first.text, 'Previous')
  end
end

And(/^I open a permit (.+) with (.+) rank$/) do |status, rank|
  sleep 2
  on(Section0Page).master_approval_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)].click
  step "I enter pin for rank #{rank}" if ($current_environment.include? 'sit') || ($current_environment.include? 'auto')
  step "I enter pin via service for rank #{rank}" if $current_environment === 'uat'
  BrowserActions.wait_until_is_visible(on(CommonFormsPage).form_navigation_bar_element)
end

And(/^I request for update without submitting$/) do
  begin
    on(Section7Page).request_update_btn
  rescue StandardError
    on(Section7Page).update_btn
  end
  sleep 1
  BrowserActions.enter_text(on(Section0Page).enter_comment_box_element, 'Test Automation')
end
