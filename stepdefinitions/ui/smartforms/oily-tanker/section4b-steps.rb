# frozen_string_literal: true

Then (/^I should not see comment box exists$/) do
  not_to_exists(on(PendingStatePage).update_comment_box_element)
end

Then (/^I should see description of work pre-populated$/) do
  is_equal(on(Section4BPage).description_of_work,"Test Automation")
end

Then (/^I should see wifi inconsistent popup display for (.*)$/) do |which_category|
  if which_category === "EIC"
    is_equal(on(Section4BPage).wifi_popup_elements[1].text,"Inconsistent Wi-Fi")
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,"Due to a Wi-Fi issue, you are doing this Energy Isolation Certificate in Offline Mode.\nTo ensure you will be able to receive approval, try moving to a location with a better Wi-Fi signal.")
  elsif which_category === "section 6"
    is_equal(on(Section4BPage).wifi_popup_elements[1].text,"Inconsistent Wi-Fi")
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,"Due to a Wi-Fi issue, you are doing this Section 6: Gas Testing/Equipment in Offline Mode.\nTo ensure you will be able to receive approval, try moving to a location with a better Wi-Fi signal.")
  elsif which_category === "smartform"
    on(Section0Page).back_arrow_element.click
    sleep 3
    is_equal(on(CommonFormsPage).wifi_popup_smartform_elements[0].text,"Permit Update in Progress\nIf the update is taking too long, move to a location with better WiFi.")
  elsif which_category === "section 8"
    is_equal(on(Section4BPage).wifi_popup_elements[1].text,"Inconsistent Wi-Fi")
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,"Due to a Wi-Fi issue, you are doing this Section 8: Task Status & EIC Normalisation in Offline Mode.\nTo ensure you will be able to receive approval, try moving to a location with a better Wi-Fi signal.")
  end
end

Then (/^I should see wifi restore popup display for (.*)$/) do |which_category|
  step 'I turn on wifi'
  BrowserActions.wait_until_is_visible(on(CommonFormsPage).wifi_restore_popup_element)
  if which_category === "EIC"
    is_equal(on(Section4BPage).wifi_popup_elements[1].text,"Wi-Fi restored")
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,"You are Online Now\nNow you can submit Energy Isolation Certificate so other crew members will be able to access it in other devices.")
  elsif which_category === "section 6"
    is_equal(on(Section4BPage).wifi_popup_elements[1].text,"Wi-Fi restored")
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,"You are Online Now\nNow you can submit Section 6: Gas Testing/Equipment so other crew members will be able to access it in other devices.")
  end
end

And (/^I link wearable to a (RA|competent person|issuing authority) (.*) and link to zoneid (.*) and mac (.*)$/) do |_condition, _user, zoneid, mac|
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
  on(Section4BPage).sign_eic_or_issuer(_condition)
  if _condition === 'issuing authority' || _condition === 'competent person'
    step "I sign on canvas with valid #{_pin} pin"
  elsif _condition === 'non issuing authority' || _condition === 'non competent person'
    step "I enter pin #{_pin}"
  end
end

And (/^I click on sign button for (issuing authority|non issuing authority|competent person|non competent person)$/) do |_condition|
  on(Section4BPage).sign_eic_or_issuer(_condition)
end

When (/^I select yes to EIC$/) do
  sleep 2
  on(Section4BPage).yes_no_btn_elements[0].click
end

And (/^I click on (.*) EIC certification button$/) do |_which_type|
  sleep 2
  if _which_type === "create"
    on(Section4BPage).create_eic_btn
  elsif _which_type === "view"
    on(Section4BPage).view_eic_btn
  end
end

And (/^I sign EIC section 4b with (RA|non RA) pin (.+)$/) do |_condition, _pin|
  # sleep 1
  BrowserActions.wait_until_is_visible(on(Section4APage).sign_btn_elements.first)
  BrowserActions.scroll_click(on(Section4APage).sign_btn_elements.first)
  step "I enter pin #{_pin}"
  on(SignaturePage).sign_and_done if _condition === 'RA'
end

And (/^I should see location (.+) stamp$/) do |_location|
  is_equal(on(Section8Page).rank_name_and_date_elements.last.text, "Location Stamp:\n#{_location}")
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

And (/^I fill up EIC certificate$/) do
  step 'I click on create EIC certification button'
  sleep 2
  on(Section3DPage).radio_btn_elements[0].click
  on(Section4BPage).fill_textarea(on(Section4APage).textarea_elements,'Test automation')
  # tmp = 0
  on(Section3DPage).radio_btn_elements[2].click #select LOTO
  sleep 1
  on(Section3DPage).radio_btn_elements[4].click
  on(Section3DPage).radio_btn_elements[4].click
  on(Section3DPage).radio_btn_elements[6].click
  on(Section3DPage).radio_btn_elements[8].click #select Electrical Isolation
  sleep 1
  on(Section3DPage).radio_btn_elements[10].click
  on(Section3DPage).radio_btn_elements[10].click
  on(Section3DPage).radio_btn_elements[12].click
  on(Section3DPage).radio_btn_elements[14].click #select Physical Isolation
  sleep 1
  on(Section3DPage).radio_btn_elements[16].click
  on(Section3DPage).radio_btn_elements[16].click
  on(Section3DPage).radio_btn_elements[18].click
  on(Section3DPage).radio_btn_elements[20].click
  on(Section3DPage).radio_btn_elements[22].click
  on(Section3DPage).radio_btn_elements[24].click
  on(Section3DPage).radio_btn_elements[26].click #select Confirmation and Acceptance
  sleep 1
  on(Section3DPage).radio_btn_elements[28].click
  on(Section3DPage).radio_btn_elements[28].click
  on(Section3DPage).radio_btn_elements[30].click
  on(Section3DPage).radio_btn_elements[32].click
  on(Section3DPage).radio_btn_elements[34].click
  on(Section4BPage).loto = '1234'
  # sign
  step 'I sign EIC as competent person with pin 8383'
  sleep 1
  step 'I sign EIC as issuing authority with pin 8248'
  sleep 2
  on(Section4BPage).save_eic
  sleep 1
  step 'I sign EIC section 4b with RA pin 9015'
end

Then (/^I should see these sub questions$/) do |_table|
  on(Section4BPage).loto_rdo_element.click
  on(Section4BPage).electrical_rdo_element.click
  on(Section4BPage).phy_rdo_element.click
  _table.raw.each do |_element|
    step "I should see the text '#{_element.first}'"
  end
end
