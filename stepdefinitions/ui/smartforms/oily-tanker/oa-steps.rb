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
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  end
end

And (/^I approve oa permit via oa link manually with from 0 hour to 01 hour$/) do
  on(OAPage).sol_6553
end

And (/^I approve oa permit via oa link manually$/) do
  # $browser.get("https://office.dev.safevue.ai/permit-preview/01F23C5B44MVT2A3WRFABN85NB?formId=AUTO/PTW/2021/191&staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  sleep 5
  on(OAPage).approve_permit_btn_element.click
  on(OAPage).select_yes_on_checkbox
  on(OAPage).set_from_to_details
  on(OAPage).set_designation
  sleep 2
  BrowserActions.js_click("//button[contains(.,'Approve This Permit to Work')]")
  sleep 2
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 1
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  end
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

Then(/^I should see the Designation list contains all necessary roles$/) do
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

Then(/^I should see comment attributes (before|after) termination$/) do |_seeWhen|
  is_true(on(OAPage).comment_rank_elements.first.text == "Vessel Superintendent")
  is_true(on(OAPage).comment_name_elements.first.text == "Test Automation 2")
  case _seeWhen
  when 'before'
    does_include(on(OAPage).comment_date_elements.first.text, @when)
    is_true(on(OAPage).comment_text_elements.first.text == "Test Automation 2")
  when 'after'
    does_include(on(OAPage).comment_date_after_term_elements.first.text, @when)
    is_true(on(OAPage).comment_text_after_term_elements.first.text == "Test Automation 2")
  end
end

Then(/^I should see the last comment is at the top of the list$/) do
  step 'I should see comment attributes before termination'
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

Then(/^I should see the full comment text (before|after) termination$/) do |_seeWhen|
  case _seeWhen
  when 'before'
    commentText = on(OAPage).comment_text_elements.first.text.sub(' See Less', '')
  when 'after'
    commentText = on(OAPage).comment_text_after_term_elements.first.text
  end
  baseText = YAML.load_file("data/office-approval/comments.yml")['long']
  baseText = baseText.to_s.sub('["', '')
  baseText = baseText.to_s.sub('"]', '')
  is_equal(commentText, baseText)
end


And(/^I submit permit via service to pending office approval state$/) do
  on(BypassPage).set_oa_permit_to_state('PENDING_MASTER_REVIEW')
  on(BypassPage).set_oa_permit_to_pending_office_appr
end

And(/^I should see the correct notification at the bottom after (approval|activation)$/) do |_whichState|
  case _whichState
  when 'approval'
    is_equal(on(OAPage).comment_bottom_notification, "You can't add comments to approved Permits")
  when 'activation'
    is_equal(on(OAPage).comment_bottom_notification, "You can't add comments to activated permits")
  end
  sleep(1)
end

And(/^I should not see active fields and buttons$/) do
  not_to_exists(on(OAPage).comment_input_box_element)
  not_to_exists(on(OAPage).send_comments_btn_element)
end

And(/^I submit permit via service to closed state$/) do
  on(BypassPage).set_oa_permit_to_state('ACTIVE')
  on(BypassPage).set_oa_permit_to_state('PENDING_TERMINATION')
  on(BypassPage).set_oa_permit_to_state('CLOSED')
end

Then(/^I should see the Approval comments block at the bottom of the form$/) do
  to_exists(on(OAPage).approval_comments_block_element)
end

Then(/^I should see comments are displayed in chronological order$/) do
  comments_list = Array.new
  on(OAPage).comment_date_after_term_elements.each do |comment|
    name = comment.text
    comments_list << name
  end
  puts comments_list
  order = comments_list.sort
  puts order
  is_equal(comments_list, order)
  sleep(1)
end

And(/^I take note of comments counter$/) do
  sleep(5)
  counterText = on(OAPage).comment_counter_element.text
  counter = counterText.sub('Comments (', '')
  @counter = counter.sub(')', '')
  puts @counter
  sleep(2)
end

And(/^I should see the comments counter shows the same number$/) do
  does_include(on(OAPage).approval_comments_block_element.text, @counter)
end

Then(/^I should not see the Add\/Show Comments button$/) do
  not_to_exists(on(OAPage).add_comments_btn1_element)
end