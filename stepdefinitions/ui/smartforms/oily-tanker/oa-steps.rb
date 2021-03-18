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
  sleep 1
  # on(OAPage).xxx_element.click
  # Appium::TouchAction.new($browser).swipe(start_x:0, start_y: 300, offset_x: 0, offset_y: 320, duration: 70).perform
  sleep 2
  x = %(document.evaluate("//span[contains(text(),'Request Updates')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click())
  @browser.execute_script(x)
  # on(OAPage).update_permit_span_element.click
  sleep 3
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 2
end

And (/^I approve oa permit via oa link manually$/) do
  # $browser.get("https://dev-officeportalclient-2953306c.azurewebsites.net/permit-preview/01F07VY2VJ5PJMPMDZR2BW9ZKF?formId=AUTO/PTW/2021/164&staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  sleep 5
  on(OAPage).approve_permit_btn_element.click
  on(OAPage).select_yes_on_checkbox
  on(OAPage).set_from_to_details
  on(OAPage).set_designation
  sleep 1
  on(OAPage).submit_permit_approval_btn
  # x = %(document.evaluate("//button[contains(.,'Approve This Permit to Work')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click())
  # @browser.execute_script(x)
  sleep 3
  $browser.get(EnvironmentSelector.get_environment_url)
end

And (/^I should see comment reset$/) do
  # $browser.gset("http://solas-dev-office-portal.azurewebsites.net/permit-overview?formId=SIT/PTW/2020/158&eventId=01EJ7VZKGE7G6CV4ST5Y47K4KH&staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  on(OAPage).add_comments_btn
  sleep 1
  is_true(on(OAPage).is_comment_box_reset?)
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
    on(OAPage).name_box_element.send_keys('Test Automation')
  end
  sleep(2)
end

And(/^I delete the comment$/) do
  on(OAPage).comment_input_box_element.clear()
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
  sleep(1)
end

Then(/^I should see the See More button for a long comment$/) do
  to_exists(on(OAPage).see_more_less_btn_element)
  is_true(on(OAPage).see_more_less_btn_element.text == 'See More')
end