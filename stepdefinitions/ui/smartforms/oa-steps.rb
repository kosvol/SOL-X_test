And (/^I navigate to OA link$/) do
  on(OAPage).navigate_to_oa_link
end

And (/^I approve oa permit via oa link manually$/) do
  # $browser.get("http://office-approval.dev.solas.magellanx.io/approve-page/01EJ7WE70DY9C3FCCEM7S80FR7?staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  sleep 1
  BrowserActions.scroll_click(on(OAPage).approve_permit_btn_element)
  on(OAPage).set_to_time
  on(OAPage).set_to_date_plus_one_day(on(OAPage).issue_to_date_btn_element.text)
  BrowserActions.scroll_click(on(OAPage).submit_permit_approval_btn_element)
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