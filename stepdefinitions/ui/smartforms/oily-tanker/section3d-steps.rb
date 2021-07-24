# frozen_string_literal: true

And(/^I fill up section 3d$/) do
  tmp = 1
  (0..((on(Section3DPage).radio_btn_elements.size / 2) - 1)).each do |_i|
    on(Section3DPage).radio_btn_elements[[0 + tmp].sample].click
    tmp += 2
  end
  BrowserActions.enter_text(on(CommonFormsPage).enter_comment_box_element, 'Test Automation')
end

And(/^I resign with valid (.*) rank$/) do |_rank|
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).done_btn_elements.first)
  sleep 1
  step "I sign on canvas only with valid #{_rank} rank"
end

And(/^I sign (checklist|section|DRA section 3d) with (.*) as (valid|invalid) rank$/) do |_page, _rank, _condition|
  sleep 1
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).sign_btn_elements.first)
  step "I enter pin for rank #{_rank}" if _condition == 'invalid'
  step "i sign with valid #{_rank} rank" if _condition === 'valid'
  step 'I set time'
end

Then(/^I sign on canvas only with valid (.*) rank$/) do |_rank|
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).sign_btn_elements.first)
  step "I enter pin for rank #{_rank}" if $current_environment === 'sit' || $current_environment === 'auto'
  step 'I enter pin via service for rank C/O' if $current_environment === 'uat'
  on(SignaturePage).sign_for_gas
end
