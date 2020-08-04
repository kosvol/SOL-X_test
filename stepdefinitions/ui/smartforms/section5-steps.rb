# frozen_string_literal: true

And (/^I fill up section 5$/) do
  on(Section5Page).select_roles_and_responsibility
  on(Section5Page).sign_btn
  on(PinPadPage).enter_pin(1212)
  on(Section3DPage).sign
  sleep 1
end
