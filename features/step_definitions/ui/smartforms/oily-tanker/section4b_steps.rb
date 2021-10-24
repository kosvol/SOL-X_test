# frozen_string_literal: true

Then(/^I (should not|should) see comment box exists$/) do |condition|
  not_to_exists(on(PendingStatePage).update_comment_box_element) if condition == 'should not'
  to_exists(on(PendingStatePage).update_comment_box_element) if condition == 'should'
end

Then(/^I should see description of work pre-populated$/) do
  is_equal(on(Section4BPage).description_of_work, 'Test Automation')
end

Then(/^I should see wifi inconsistent popup display for (.*)$/) do |which_category|
  case which_category
  when 'EIC'
    is_equal(on(Section4BPage).wifi_popup_elements[1].text, 'Inconsistent Wi-Fi')
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,
             "Due to a Wi-Fi issue, you are doing this Energy Isolation Certificate in Offline Mode.\nTo ensure you will be able to receive approval, try moving to a location with a better Wi-Fi signal.")
  when 'section 6'
    is_equal(on(Section4BPage).wifi_popup_elements[1].text, 'Inconsistent Wi-Fi')
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,
             "Due to a Wi-Fi issue, you are doing this Section 6: Gas Testing/Equipment in Offline Mode.\nTo ensure you will be able to receive approval, try moving to a location with a better Wi-Fi signal.")
  when 'smartform'
    on(Section0Page).back_arrow_element.click
    sleep 3
    is_equal(on(CommonFormsPage).wifi_popup_smartform_elements[0].text,
             "Permit Update in Progress\nIf the update is taking too long, move to a location with better WiFi.")
  when 'section 8'
    is_equal(on(Section4BPage).wifi_popup_elements[1].text, 'Inconsistent Wi-Fi')
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,
             "Due to a Wi-Fi issue, you are doing this Section 8: Task Status & EIC Normalisation in Offline Mode.\nTo ensure you will be able to receive approval, try moving to a location with a better Wi-Fi signal.")
  else
    raise "Wrong category >>>> #{which_category}"
  end
end

Then(/^I should see wifi restore popup display for (.*)$/) do |which_category|
  step 'I turn on wifi'
  BrowserActions.wait_until_is_visible(on(CommonFormsPage).wifi_restore_popup_element)
  case which_category
  when 'EIC'
    is_equal(on(Section4BPage).wifi_popup_elements[1].text, 'Wi-Fi restored')
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,
             "You are Online Now\nNow you can submit Energy Isolation Certificate so other crew members will be able to access it in other devices.")
  when 'section 6'
    is_equal(on(Section4BPage).wifi_popup_elements[1].text, 'Wi-Fi restored')
    is_equal(on(Section4BPage).wifi_popup_elements[2].text,
             "You are Online Now\nNow you can submit Section 6: Gas Testing/Equipment so other crew members will be able to access it in other devices.")
  else
    raise "Wrong category >>> #{which_category}"
  end
end

And(/^I link wearable to a (RA|competent person|issuing authority) (.*) and link to zoneid (.*) and mac (.*)$/) do
|_condition, user, zoneid, mac|
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  WearablePage.fill_list_of_crews_id(user)
  step 'I get wearable-simulator/mod-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I get wearable-simulator/mod-update-wearable-location-by-zone request payload'
  step "I manipulate wearable requeset payload with #{zoneid} and #{mac}"
  step 'I hit graphql'
  sleep 4
end

And(/^I sign EIC as (issuing authority|non issuing authority|competent person|non competent person) with rank (.+)$/) do
|condition, rank|
  on(Section4BPage).sign_eic_or_issuer(condition)
  case condition
  when 'issuing authority', 'competent person'
    step "I sign with valid #{rank} rank"
  when 'non issuing authority', 'non competent person'
    step "I enter pin for rank #{rank}"
  else
    raise "Wrong condition >>> #{condition}"
  end
end

And(/^I click on sign button for (issuing authority|non issuing authority|competent person|non competent person)$/) do
|condition|
  on(Section4BPage).sign_eic_or_issuer(condition)
end

When(/^I select yes to EIC$/) do
  sleep 2
  on(Section4BPage).yes_no_btn_elements[0].click
end

And(/^I click on (.*) EIC certification button$/) do |which_type|
  sleep 2
  case which_type
  when 'create'
    on(Section4BPage).create_eic_btn
  when 'view'
    on(Section4BPage).view_eic_btn
  else
    raise "Wrong type >>> #{which_type}"
  end
end

And(/^I sign EIC section 4b with (RA|non RA) rank (.+)$/) do |condition, rank|
  BrowserActions.wait_until_is_visible(on(Section4APage).sign_btn_elements.first)
  BrowserActions.scroll_click(on(Section4APage).sign_btn_elements.first)
  step "I enter pin for rank #{rank}"
  on(SignaturePage).sign_and_done if condition == 'RA'
end

And(/^I should see location (.+) stamp$/) do |location|
  if (on(Section8Page).rank_name_and_date_elements[0]
                      .text.include? 'Rank/Name') && (on(Section8Page)
                                                        .rank_name_and_date_elements.last.text.include? 'Rank/Name')
    is_equal(on(Section8Page).rank_name_and_date_elements[2].text, "Location Stamp:\n#{location}")
  elsif (on(Section8Page).rank_name_and_date_elements[0]
                         .text.include? 'Rank/Name') && (on(Section8Page)
                                                           .rank_name_and_date_elements[1].text.include? 'Rank/Name')
    is_equal(on(Section8Page).rank_name_and_date_elements.last.text, "Location Stamp:\n#{location}")
  end
end

And(/^I should see (.+) rank and name$/) do |rank|
  is_equal(on(Section4BPage).eic_signer_name_elements.first.text, rank)
end

Then(/^I should see EIC permit number, date and time populated$/) do
  is_true(on(Section4BPage).eic_prepopulated?)
end

And(/^I fill up EIC certificate$/) do
  step 'I click on create EIC certification button'
  sleep 2
  on(Section3DPage).radio_btn_elements[0].click
  on(Section4BPage).fill_textarea(on(Section4APage).textarea_elements, 'Test automation')
  on(Section3DPage).radio_btn_elements[2].click # select LOTO
  sleep 1
  on(Section3DPage).radio_btn_elements[4].click
  on(Section3DPage).radio_btn_elements[4].click
  on(Section3DPage).radio_btn_elements[6].click
  on(Section3DPage).radio_btn_elements[8].click # select Electrical Isolation
  sleep 1
  on(Section3DPage).radio_btn_elements[10].click
  on(Section3DPage).radio_btn_elements[10].click
  on(Section3DPage).radio_btn_elements[12].click
  on(Section3DPage).radio_btn_elements[14].click # select Physical Isolation
  sleep 1
  on(Section3DPage).radio_btn_elements[16].click
  on(Section3DPage).radio_btn_elements[16].click
  on(Section3DPage).radio_btn_elements[18].click
  on(Section3DPage).radio_btn_elements[20].click
  on(Section3DPage).radio_btn_elements[22].click
  on(Section3DPage).radio_btn_elements[24].click
  on(Section3DPage).radio_btn_elements[26].click # select Confirmation and Acceptance
  sleep 1
  on(Section3DPage).radio_btn_elements[28].click
  on(Section3DPage).radio_btn_elements[28].click
  on(Section3DPage).radio_btn_elements[30].click
  on(Section3DPage).radio_btn_elements[32].click
  on(Section3DPage).radio_btn_elements[34].click
  on(Section4BPage).loto = '1234'
  # sign
  step 'I sign EIC as competent person with rank C/O'
  sleep 1
  on(Section4BPage).save_eic
  sleep 1
  step 'I sign EIC section 4b with RA rank C/O'
end

Then(/^I should see these sub questions$/) do |table|
  on(Section4BPage).loto_rdo_element.click
  on(Section4BPage).electrical_rdo_element.click
  on(Section4BPage).phy_rdo_element.click
  table.raw.each do |element|
    step "I should see the text '#{element.first}'"
  end
end
