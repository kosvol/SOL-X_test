# frozen_string_literal: true

And (/^I link wearable to a (RA|competent person|issuing authority) (.+) and link to zoneid (.+) and mac (.+)$/) do |_condition, _user, zoneid, mac|
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  WearablePage.set_list_of_crews_id(_user)
  step 'I get wearable-simulator/mod-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I get wearable-simulator/mod-update-wearable-location-by-zone request payload'
  step "I manipulate wearable requeset payload with #{zoneid} and #{mac}"
  step 'I hit graphql'
  sleep 4
end

Then (/^I sign EIC as (issuing authority|non issuing authority|competent person|non competent person) with pin (.+)$/) do |_condition, _pin|
  on(Section8Page).sign_eic_or_issuer(_condition)

  @@entered_pin = _pin.to_i
  on(PinPadPage).enter_pin(@@entered_pin)
  if _condition === 'issuing authority' || _condition === 'competent person'
    step 'I sign on canvas'
  end
  step 'I set time'
end

When (/^I select yes to EIC$/) do
  sleep 2
  on(Section4BPage).yes_no_btn_elements[0].click
end

When (/^I select yes to EIC certification$/) do
  on(Section4BPage).yes_no_btn_elements[0].click
  step 'I set time'
  on(Section4BPage).create_eic_btn
  sleep 1
end

And (/^I sign EIC section 4b with (RA|non RA) pin (.+)$/) do |_condition, _pin|
  on(Section4BPage).yes_no_btn_elements[0].click
  BrowserActions.scroll_click(on(Section4APage).sign_btn_elements.first)
  @@entered_pin = _pin.to_i
  on(PinPadPage).enter_pin(@@entered_pin)
  step 'I sign on canvas' if _condition === 'RA'
end

And (/^I should see location (.+) stamp$/) do |_location|
  is_equal(on(Section4BPage).location_stamp_element.text, _location)
end

And (/^I should see signature$/) do
  to_exists(on(Section4BPage).signature_element)
end

And (/^I should see (.+) rank and name$/) do |_rank|
  is_equal(on(Section4BPage).eic_signer_name_elements.first.text, _rank)
end

Then (/^I should see EIC permit number, date and time populated$/) do
  is_true(on(Section4BPage).is_eic_details_prepopulated?)
end
