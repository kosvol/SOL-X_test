# frozen_string_literal: true

And (/^I fill up section 5$/) do
  on(Section5Page).select_roles_and_responsibility
  BrowserActions.scroll_click(on(Section5Page).sign_btn_elements.first)
  on(PinPadPage).enter_pin(9015)
  step 'I sign on canvas'
  sleep 1
end
