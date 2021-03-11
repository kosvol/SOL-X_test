
And (/^I add normal gas readings$/) do
  BrowserActions.wait_until_is_visible(on(NewEntrantPage).new_entry_bn_element)
  on(NewEntrantPage).new_entry_bn_element.click
  sleep 1
  on(EntryLog).add_normal_gas_readings
  BrowserActions.wait_until_is_visible(on(EntryLog).continue_btn_element)
  on(EntryLog).continue_btn_element.click
end

And (/^I review and sign gas readings$/) do
  BrowserActions.wait_until_is_visible(on(EntryLog).review_sign_btn_element)
  on(EntryLog).review_sign_btn_element.click
  BrowserActions.wait_until_is_visible(on(SignaturePage).signing_canvas_element)
  on(SignaturePage).sign_for_gas
  on(EntryLog).enter_pin_and_sbmt_element.click
end
