# frozen_string_literal: true

And (/^I fill up section 3d$/) do
  tmp = 1
  (0..((on(Section3DPage).radio_btn_elements.size / 2) - 1)).each do |_i|
    on(Section3DPage).radio_btn_elements[[0 + tmp].sample].click
    tmp += 2
  end
  BrowserActions.enter_text(on(CommonFormsPage).enter_comment_box_element, 'Test Automation')
end

And (/^I sign DRA section 3d with (.*) as (valid|invalid) pin$/) do |_pin,_condition|
  @@entered_pin = _pin
  on(CommonFormsPage).sign_btn_elements.first.click
  step "I enter pin #{_pin}" if _condition === "invalid"
  step "I sign on canvas with valid #{@@entered_pin} pin" if _condition === "valid"
  step 'I set time'
end