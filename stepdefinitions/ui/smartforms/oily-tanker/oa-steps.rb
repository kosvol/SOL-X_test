# frozen_string_literal: true

And (/^I navigate to OA link$/) do
  $browser.get(on(OAPage).navigate_to_oa_link)
    #sleep 3
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).permit_section_header_elements[0])
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
  sleep 3
end

And(/^I should see Comments block attributes$/) do
  sleep 1
  is_true(on(OAPage).is_comment_box_reset?)
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
  whatRole = rand(12)
  @designation = on(OAPage).designation_elements[whatRole].text
  on(OAPage).designation_elements[whatRole].click
end

Then(/^I should see the selected role in the Designation field$/) do
  is_equal(on(OAPage).rank_dd_list_element.text, @designation)
end

Then(/^I should see the (Send|Request Updates) button is (disabled|enabled)$/) do |_button, _condition|
  case _button
  when "Send"
    case _condition
    when "enabled"
      is_enabled(on(OAPage).send_comments_btn_element)
    when "disabled"
      is_disabled(on(OAPage).send_comments_btn_element)
    end
  when "Request Updates"
    case _condition
    when "enabled"
      is_enabled(on(OAPage).update_permit_btn_element)
    when "disabled"
      is_disabled(on(OAPage).update_permit_btn_element)
    end
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
    step 'I scroll down to This Permit Approved On element'
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
  step 'I scroll down to This Permit Approved On element'
  to_exists(on(OAPage).approval_comments_block_element)
end

Then(/^I should see comments are displayed in chronological order$/) do
  step 'I scroll down to This Permit Approved On element'
  comments_list = Array.new
  on(OAPage).comment_date_after_term_elements.each do |comment|
    name = comment.text
    comments_list << name
  end
  order = comments_list.sort
  is_equal(comments_list, order)
  sleep(1)
end

And(/^I take note of comments counter$/) do
  sleep(5)
  counterText = on(OAPage).comment_counter_element.text
  counter = counterText.sub('Comments (', '')
  @counter = counter.sub(')', '')
end

And(/^I should see the comments counter shows the same number$/) do
  does_include(on(OAPage).approval_comments_block_element.text, @counter)
end

Then(/^I should not see the Add\/Show Comments button$/) do
  not_to_exists(on(OAPage).add_comments_btn1_element)
end

Then(/^I scroll down to This Permit Approved On element$/) do
  el = $browser.find_element(:xpath, "//div[contains(@class,'ApprovedTagWrapper')]")
  $browser.action.move_to(el).perform
  sleep(3)
end

When(/^I wait for OA event/) do
  form_id = CommonPage.get_permit_id
  docs = []
  i = 30
  while i > 0 && docs == [] do
    request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_event_id'], 'post', { selector: { formId: form_id } }.to_json.to_s)
    docs = (JSON.parse request.to_s)['docs']
    i -= 1
    sleep(20)
  end
  is_true(docs != [])
end

When (/^I wait for form status get changed to (.+) on (.+)/) do |_whatStatus, _server|
  form_id = CommonPage.get_permit_id
  status = nil
  docs = []
  i = 35
  while i > 0 && status != "#{_whatStatus}" do
    if _server == "Cloud"
      request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_form_status'], 'post', { selector: { _id: form_id } }.to_json.to_s)
    else
      request = ServiceUtil.fauxton($obj_env_yml[_server]['get_form_status'], 'post', { selector: { _id: form_id } }.to_json.to_s)
    end
    p "request >> #{request}"
    docs = (JSON.parse request.to_s)['docs']
    p "doc >> #{(JSON.parse request.to_s)['docs']}"
    if docs != []
      status = (JSON.parse request.to_s)['docs'][0]['status']
    end
    i -= 1
    sleep(20)
  end
  is_true(status == "#{_whatStatus}")
  p " status >> #{status}"
end

Then(/^I should see the View Permit Page with all attributes (.+)$/) do |_when|
  to_exists(on(OAPage).sol_logo_element)
  does_include(on(OfficePortalPage).topbar_header_element.text, @formNumber)
  does_include(on(OfficePortalPage).topbar_header_element.text, @formName)
  case _when
  when "before approval"
    sectionsList = []
    on(OfficePortalPage).permit_section_header_elements.each do |_whatSection|
      section = _whatSection.text
      sectionsList << section
    end
    sections_data = YAML.load_file("data/office-portal/permit-states-sections.yml")['pending_office_approval']
    is_enabled(on(OAPage).approve_permit_btn_element)
    is_enabled(on(OAPage).update_permit_btn_element)
    is_enabled(on(OAPage).add_comments_btn_element)
  when "after approval"
    sectionsList = []
    on(OfficePortalPage).permit_section_header_elements.each do |_whatSection|
      section = _whatSection.text
      sectionsList << section
    end
    sections_data = YAML.load_file("data/office-portal/permit-states-sections.yml")['pending_master_approval']
    is_disabled(on(OAPage).permit_has_been_btn_element)
    is_equal(on(OAPage).permit_has_been_btn_element.text, "This Permit Has Been Approved")
    is_disabled(on(OAPage).update_permit_btn_element)
    is_disabled(on(OAPage).add_comments_btn_element)
  when "after activation"
    sectionsList = []
    on(OfficePortalPage).permit_section_header_elements.each do |_whatSection|
      section = _whatSection.text
      sectionsList << section
    end
    sections_data = YAML.load_file("data/office-portal/permit-states-sections.yml")['active']
    is_disabled(on(OAPage).permit_has_been_btn_element)
    is_equal(on(OAPage).permit_has_been_btn_element.text, "This Permit Has Been Activated")
    is_disabled(on(OAPage).update_permit_btn_element)
    is_disabled(on(OAPage).add_comments_btn_element)
  end
  is_true(sectionsList == sections_data)
  p ">> #{sectionsList - sections_data}"
  not_to_exists(on(OfficePortalPage).home_btn_element)
end

And(/^I get (PTW|PRE) permit info$/) do |_permitType|
  case _permitType
  when "PTW"
    dataFileResp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
    dateFileReq = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
    @formNumber = dataFileResp['data']['createForm']['_id']
    @formName = dateFileReq['variables']['permitType']
  when "PRE"
    dataFileResp = JSON.parse JsonUtil.read_json_response('pre/mod-01.create-pre-form')
    dateFileReq = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
    @formNumber = dataFileResp['data']['createForm']['_id']
  end
end

And(/^I click on "Approve This Permit”$/) do
  on(OAPage).approve_permit_btn
  @time_now = Time.now.utc
  sleep(2)
end

Then(/^I should see the Web Confirmation page with all attributes$/) do
  to_exists(on(OAPage).sol_logo_element)
  does_include(on(OAPage).topbar_header_h3_element.text, "PTW #: #{@formNumber}")
  baseDescription = YAML.load_file("data/office-approval/page-descriptions.yml")['before_appr']
  is_equal(on(OAPage).main_description_element.text, baseDescription)
  is_equal(on(OAPage).confirmation_question_elements[0].text, "DRA & Work Plan Reviewed?\nYes\nN/A")
  is_equal(on(OAPage).confirmation_question_elements[1].text, "Safety Meeting Minutes Reviewed?\nYes\nN/A")
  is_equal(on(OAPage).confirmation_question_elements[2].text, "Any Intermediate Reporting Required?\nYes\nN/A")
  is_equal(on(OAPage).confirmation_question_elements[3].text, "Local/appropriate authority approval required?\nYes\nN/A")
  is_equal(on(OAPage).text_area_header_element.text, "Additional Instruction on safety and technical matters:")
  to_exists(on(OAPage).instruction_text_area_element)
  to_exists(on(OAPage).name_input_field_element)
  to_exists(on(OAPage).designation_dd_btn_element)
  is_disabled(on(OAPage).approve_permit_btn_element)
  is_equal(on(OAPage).bottom_hint_element.text, "If you don't intend to approve this permit, please close this window and return to the approval page.")
end

Then(/^I should see the Web Rejection page with all attributes$/) do
  to_exists(on(OAPage).sol_logo_element)
  does_include(on(OAPage).topbar_header_h3_element.text, "PTW#: #{@formNumber}")
  baseDescription = YAML.load_file("data/office-approval/page-descriptions.yml")['before_rejection']
  is_equal(on(OAPage).main_header_element.text, baseDescription)
  to_exists(on(OAPage).update_comments_element)
  to_exists(on(OAPage).name_input_field_element)
  to_exists(on(OAPage).designation_dd_btn_element)
  is_disabled(on(OAPage).update_permit_btn_element)
end

And(/^I select Issued (From|To) time as (.+):(.+)$/) do |_whatTime, _hours, _mins|
  case _whatTime
  when "From"
    on(OAPage).date_time_from_elements[1].click
  when "To"
    on(OAPage).date_time_to_elements[1].click
  end
  on(OAPage).hour_from_picker_elements[_hours.to_i].click
  on(OAPage).minute_from_picker_elements[_mins.to_i].click
  on(OAPage).dismiss_picker_element.click
  BrowserActions.js_click("//textarea[contains(@placeholder,'Optional')]")
  sleep 1
end

Then(/^I should see the correct warning message for (less|more)$/) do |_validity|
  case _validity
  when "less"
    is_equal(on(OAPage).warning_infobox_element.text, "Validity Time too short\nCheck validity time too short, permit duration can't be less than 1 hr.")
  when "more"
    is_equal(on(OAPage).warning_infobox_element.text, "Validity Time too long\nCheck validity time too long, permit duration can't be more than 8 hrs.")
  end
end

Then(/^I should see the officer name is pre\-filled$/) do
  is_equal(on(OAPage).name_input_field_element.attribute('value'), "VS Automation")
end

Then(/^I should see the Warning Screen$/) do
  to_exists(on(OAPage).sol_logo_element)
  does_include(on(OfficePortalPage).topbar_header_element.text, @formNumber)
  does_include(on(OfficePortalPage).topbar_header_element.text, @formName)
  not_to_exists(on(OfficePortalPage).home_btn_element)
  is_equal(on(OAPage).warning_link_expired_element.text, "Link has expired as this Permit to Work has been sent again for Office Approval\nA new link has been sent out via email. If it hasn't arrive yet, please wait for a few minutes.\nYour previous comments won't be lost.")
  not_to_exists(on(OAPage).approve_permit_btn_element)
end

And(/^I submit permit via service to pending master review state$/) do
  on(BypassPage).set_oa_permit_to_state('PENDING_MASTER_REVIEW')
end

And(/^I navigate to OA link as Master$/) do
  form_id = CommonPage.get_permit_id
  request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_event_id'], 'post', { selector: { formId: form_id } }.to_json.to_s)
  event_id = (JSON.parse request.to_s)['docs'][0]['_id']
  $browser.get("https://office.dev.safevue.ai/permit-preview/#{event_id}")
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).permit_section_header_elements[0])
end


Then(/^I should see correct Section 7 details (before|after) Office Approval$/) do |_when|
  case _when
  when "before"
    is_equal(on(Section7Page).oa_description_elements.text, YAML.load_file("data/office-approval/page-descriptions.yml")['before_appr_section7'])
  when "after"
    time_from = Time.new(@time_now.year, @time_now.mon, @time_now.day, 0, 0, 0, 0)
    time_to = Time.new(@time_now.year, @time_now.mon, @time_now.day, 8, 0, 0, 0)
    time_offset = on(CommonFormsPage).get_current_time_offset
    if time_offset.to_s[0] != "-"
      time_ship_from = (time_from + (60*60*time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT+#{time_offset})")
      time_ship_to = (time_to + (60*60*time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT+#{time_offset})")
    else
      time_ship_from = (time_from + (60*60*time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT#{time_offset})")
      time_ship_to = (time_to + (60*60*time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT#{time_offset})")
    end
    p "#{time_ship_from}"
    p "#{time_ship_to}"
    is_equal(on(Section7Page).oa_description_element.text, YAML.load_file("data/office-approval/page-descriptions.yml")['after_appr_section7'])
    is_equal(on(Section7Page).additional_instruction_element.text, "Test Automation")
    is_equal(on(Section7Page).issued_from_date_element.text, "#{time_ship_from}")
    is_equal(on(Section7Page).issued_to_date_element.text, "#{time_ship_to}")
    is_equal(on(Section7Page).approver_name_element.text, "VS Automation")
    is_equal(on(Section7Page).approver_designation_element.text, "VS")
    to_exists(on(Section7Page).activate_permit_btn_element)
  end
  to_exists(on(CommonFormsPage).previous_btn_elements.first)
  to_exists(on(CommonFormsPage).close_btn_elements.first)
  not_to_exists(on(Section7Page).update_btn_element)
  not_to_exists(on(CommonFormsPage).request_update_btn_element)
end

And(/^I leave additional instructions$/) do
  on(OAPage).instruction_text_area_element.send_keys("Test Automation")
end

And(/^I answer all questions on the page$/) do
  on(OAPage).select_yes_on_checkbox
end

And(/^I select the approver designation$/) do
  on(OAPage).set_designation
end

And(/^I click on "Request Updates"$/) do
  on(OAPage).update_permit_btn
end

And(/^I enter (comment|name)$/) do |_input|
  case _input
  when "comment"
    on(OAPage).update_comments_element.send_keys('Test Automation')
  when "name"
    on(OAPage).name_input_field_element.send_keys('Test Automation 2')
  end
  sleep(1)
end

And(/^I remove (comment|name)$/) do |_input|
  case _input
  when "comment"
    on(OAPage).update_comments_element.click
    on(OAPage).update_comments_element.send_keys("\ue03D" + "a")
    on(OAPage).update_comments_element.send_keys("\ue017")
  when "name"
    on(OAPage).name_input_field_element.click
    on(OAPage).name_input_field_element.send_keys("\ue03D" + "a")
    on(OAPage).name_input_field_element.send_keys("\ue017")
  end
end