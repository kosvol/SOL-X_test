# frozen_string_literal: true

And (/^I navigate to OA link$/) do
  on(OAPage).navigate_to_oa_link
end

And (/^I request the permit for update via oa link manually$/) do
  # $browser.get('http://solas-dev-office-portal.azurewebsites.net/permit-preview/01ES5NYNPXEPZY4PNE187C5HBY?formId=SIT/PTW/2020/161&staffId=410ab5c6feb3d2f1b030b9d9ce036138')
  sleep 1
  on(OAPage).update_permit_btn
  sleep 1
  on(OAPage).update_comments_element.send_keys("Test Automation Update")
  on(OAPage).set_designation
  sleep 1
  on(OAPage).update_permit_btn
  sleep 1
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
