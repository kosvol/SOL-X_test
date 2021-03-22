# frozen_string_literal: true

And (/^I navigate to OA link$/) do
  sleep 1
  $browser.get(on(OAPage).navigate_to_oa_link)
  sleep 3
end

And (/^I request the permit for update via oa link manually$/) do
  # $browser.get("http://solas-dev-office-portal.azurewebsites.net/permit-preview/01EXBM6HC2FXMZ4FF72HA3VS0Z?staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  sleep 1
  on(OAPage).update_permit_btn
  sleep 1
  on(OAPage).set_designation
  sleep 1
  BrowserActions.enter_text(on(OAPage).update_comments_element,"Test Automation Update")
  sleep 2
  x = %(document.evaluate("//span[contains(text(),'Request Updates')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click())
  @browser.execute_script(x)
  sleep 3
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 2
end

And (/^I approve oa permit via oa link manually$/) do
  # $browser.get("https://dev-officeportalclient-2953306c.azurewebsites.net/permit-preview/01F1BZN40K6V6TM39QX40EQN47?staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  sleep 5
  on(OAPage).approve_permit_btn_element.click
  on(OAPage).select_yes_on_checkbox
  on(OAPage).set_from_to_details
  on(OAPage).set_designation
  sleep 1
  on(OAPage).submit_permit_approval_btn
  sleep 3
  $browser.get(EnvironmentSelector.get_environment_url)
end

And(/^I should see Comments block attributes$/) do
  to_exists(on(OAPage).comments_cross_icon_btn_element)
  to_exists(on(OAPage).comment_input_box_element)
  to_exists(on(OAPage).rank_dd_list_element)
  to_exists(on(OAPage).name_box_element)
  to_exists(on(OAPage).send_comments_btn_element)
end

And (/^I add comment on oa permit$/) do
  # $browser.get("http://solas-dev-office-portal.azurewebsites.net/permit-overview?formId=SIT/PTW/2020/158&eventId=01EJ7VZKGE7G6CV4ST5Y47K4KH&staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  # on(OAPage).add_comments_btn
  on(OAPage).set_comment
end

And(/^I click on Add Comments button$/) do
  on(OAPage).add_comments_btn
  sleep 1
end

And(/^I click on Designation drop\-down$/) do
  on(OAPage).rank_dd_list
  sleep 1
end

Then(/^I should the Designation list contains all necessary roles$/) do
  is_true(on(OAPage).is_designation_list?)
end

And(/^I select any role$/) do
  whatRole = rand(14)
  @designation = on(OAPage).designation_elements[whatRole].text
  on(OAPage).designation_elements[whatRole].click
end

Then(/^I should see the selected role in the Designation field$/) do
  is_equal(on(OAPage).rank_dd_list_element.text, @designation)
end

Then(/^I should see the Send button is (disabled|enabled)$/) do |_condition|
  case _condition
  when "enabled"
    is_enabled(on(OAPage).send_comments_btn_element)
  when "disabled"
    is_disabled(on(OAPage).send_comments_btn_element)
  end
  sleep(1)
end

And(/^I key a (comment|long comment|name)$/) do |_whatInput|
  if _whatInput == 'comment'
    on(OAPage).comment_input_box_element.send_keys(YAML.load_file("data/office-approval/comments.yml")['short'])
    elsif _whatInput == 'long comment'
    on(OAPage).comment_input_box_element.send_keys(YAML.load_file("data/office-approval/comments.yml")['long'])
    elsif _whatInput == 'name'
    on(OAPage).name_box_element.send_keys('Test Automation 2')
  end
end

And(/^I add a (short|long) comment$/) do |_whatLength|
  case _whatLength
  when 'short'
    step 'I key a comment'
  when 'long'
    step 'I key a long comment'
  end
  step 'I key a name'
  step 'I click on Send button'
end

And(/^I click on Send button$/) do
  on(OAPage).send_comments_btn
  @when = Time.now.strftime('%d/%b/%Y %H:%M')
  sleep(1)
end

Then(/^I should see the See More button for a long comment$/) do
  is_true(on(OAPage).see_more_less_btn_element.text == 'See More')
end

And(/^I should see only 240 chars are displayed$/) do
  commentText = on(OAPage).comment_text_elements.first.text.sub('... See More', '')
  is_true(commentText.length == 240)
end

And(/^close the comment block$/) do
  on(OAPage).comments_cross_icon_btn
  sleep(1)
end

Then(/^I should see comment attributes$/) do
  is_true(on(OAPage).comment_rank_elements.first.text == "Vessel Superintendent")
  is_true(on(OAPage).comment_name_elements.first.text == "Test Automation 2")
  does_include(on(OAPage).comment_date_elements.first.text, @when)
  is_true(on(OAPage).comment_text_elements.first.text == "Test Automation 2")
end

Then(/^I should see the last comment is at the top of the list$/) do
  step 'I should see comment attributes'
end

And(/^I click on Add\/Show Comments button$/) do
  on(OAPage).add_comments_btn1
  sleep 1
end

And(/^I click on (See More|See Less) button$/) do |_seeWhat|
  case _seeWhat
  when 'See More'
    on(OAPage).see_more_less_btn
  when 'See Less'
    on(OAPage).see_more_less_btn
  end
end

Then(/^I should see the full comment text$/) do
  commentText = on(OAPage).comment_text_elements.first.text.sub(' See Less', '')
  baseText = YAML.load_file("data/office-approval/comments.yml")['long']
  baseText = baseText.to_s.sub('["', '')
  baseText = baseText.to_s.sub('"]', '')
  is_equal(commentText, baseText)
end
