# frozen_string_literal: true

And (/^I navigate to OA link$/) do
  sleep 1
  on(OAPage).navigate_to_oa_link
end

And (/^I request the permit for update via oa link manually$/) do
  # $browser.get('http://solas-dev-office-portal.azurewebsites.net/permit-preview/01ESNCV64360TJGE4H1BX7GRFQ?formId=SIT/PTW/2020/046&staffId=410ab5c6feb3d2f1b030b9d9ce036138')
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
  # $browser.get('http://solas-dev-office-portal.azurewebsites.net/permit-preview/01ES5NYNPXEPZY4PNE187C5HBY?formId=SIT/PTW/2020/161&staffId=410ab5c6feb3d2f1b030b9d9ce036138')
  sleep 2
  on(OAPage).approve_permit_btn_element.click
  on(OAPage).select_yes_on_checkbox
  on(OAPage).set_from_to_details
  on(OAPage).set_designation
  sleep 1
  on(OAPage).submit_permit_approval_btn
  # x = %(document.evaluate("//button[contains(.,'Approve This Permit to Work')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click())
  # @browser.execute_script(x)
  sleep 1
  $browser.get(EnvironmentSelector.get_environment_url)
end

And (/^I should see comment reset$/) do
  # $browser.gset("http://solas-dev-office-portal.azurewebsites.net/permit-overview?formId=SIT/PTW/2020/158&eventId=01EJ7VZKGE7G6CV4ST5Y47K4KH&staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  on(OAPage).add_comments_btn
  sleep 1
  is_true(on(OAPage).is_comment_box_reset?)
end

And (/^I add comment on oa permit$/) do
  # $browser.get("http://solas-dev-office-portal.azurewebsites.net/permit-overview?formId=SIT/PTW/2020/158&eventId=01EJ7VZKGE7G6CV4ST5Y47K4KH&staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  # on(OAPage).add_comments_btn
  on(OAPage).set_comment
end
