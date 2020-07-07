# frozen_string_literal: true

And (/^I sign DRA section 3d with RA pin (.+)$/) do |_pin|
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  on(Section4APage).enter_pin_btn
  @@entered_pin = _pin
  on(PinPadPage).enter_pin(@@entered_pin)
  sleep 1
  on(Section3DPage).sign
end
