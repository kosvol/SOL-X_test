# frozen_string_literal: true

And (/^I sign DRA section 3d with (RA|non RA) pin {int}$/) do |_condition, _pin|
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  on(Section4APage).enter_pin_btn
  @@entered_pin = _pin.to_i
  on(PinPadPage).enter_pin(@@entered_pin)
  sleep 1
  on(Section3DPage).sign if _condition === 'RA'
end

And (/^I fill up section 3d$/) do
  tmp = 0
  (0..((on(Section3DPage).radio_btn_elements.size / 2) - 1)).each do |_i|
    on(Section3DPage).radio_btn_elements[[0 + tmp].sample].click
    # on(Section3DPage).radio_btn_elements[[0 + tmp, 1 + tmp].sample].click
    tmp += 2
  end
end

# And ('I sign DRA section 3d with non RA pin {int}') do |_pin|
#   BrowserActions.scroll_down
#   BrowserActions.scroll_down
#   on(Section4APage).enter_pin_btn
#   @@entered_pin = _pin
#   on(PinPadPage).enter_pin(@@entered_pin)
# end
