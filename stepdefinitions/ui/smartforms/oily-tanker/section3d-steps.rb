# frozen_string_literal: true

# And (/^I sign DRA section 3d with (RA|non RA) pin (.+)$/) do |_condition, _pin|
#   step 'I set time'
#   BrowserActions.scroll_click(on(Section4APage).sign_btn_elements.first)
#   # @@entered_pin = _pin.to_i
#   # on(PinPadPage).enter_pin(@@entered_pin)
#   # sleep 1
#   step "I enter pin #{_pin}"
#   on(SignaturePage).sign_and_done if _condition === 'RA'
# end

And (/^I fill up section 3d$/) do
  tmp = 0
  (0..((on(Section3DPage).radio_btn_elements.size / 2) - 1)).each do |_i|
    on(Section3DPage).radio_btn_elements[[0 + tmp].sample].click
    tmp += 2
  end
  # step 'I sign DRA section 3d with RA pin 9015'
end
