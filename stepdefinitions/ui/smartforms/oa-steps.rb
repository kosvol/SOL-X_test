And (/^I navigate to OA link$/) do
  on(OAPage).navigate_to_oa_link
end

And (/^I approve oa permit via oa link manually$/) do
  # $browser.get("https://u14460212.ct.sendgrid.net/ls/click?upn=rPVpQr-2FrVYfYuCV4Rp4on7BQ9pZHY5S6i-2FiC0AyxtY3UrxOzCfabwxPYYXxlC7SANDga-2F60n7SQUxGsAx4sbumIsoJ82Vy-2FnoRV2vSG-2Bm3S0P3dDtscXaUgDByErDej3E6r-2FT0jAFfDTX5-2Bzd8dVKW58tIZKCnHXENjuJWlNPBXAzgDzK181LfYX-2F9qdWPUhaRY2VfPWcqot1FapxmN1vMcXFpyCyOdvhYdGdJwbgAw-3D-KZ6_KoIoLgGO29ed8y7b48-2Fkwbr6ARiKhv1fxlAL1AD10Dpu8DHtlYhSXkjdyHtv93rm-2BE-2BkuZ7MaIkA0E3-2BlT4WHLqYDQuaxzopCXvvfWCpC6M5z-2BUfISBmnCTXfmMOu-2F13waWtzt6dB-2FE5FmUL1-2BYqAM2OB8hw70pAf2kS5Aw7ADQbsAQ1jymGrVGMOpBcalnwoQl78N80WO9oL-2FQ9jzEMQCWSUjnbl0Pmrfcr1tup3sQ-3D")
  sleep 2
  on(OAPage).approve_permit_btn_element.click
  on(OAPage).set_to_time
  # on(OAPage).set_to_date_plus_one_day(on(OAPage).issue_to_date_btn_element.text)
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