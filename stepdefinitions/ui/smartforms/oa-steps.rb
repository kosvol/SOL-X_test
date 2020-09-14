And (/^I set oa permit to active state via manual office approval$/) do
  CommonPage.set_permit_id(on(Section0Page).created_ptw_id_elements.last.text)
  sleep 360
  $browser.get(OfficeApproval.get_office_approval_link(CommonPage.get_permit_id, 'VS', 'VS Automation').to_s)
  # $browser.get("http://solas-dev-office-portal.azurewebsites.net/permit-overview?formId=SIT/PTW/2020/395&eventId=01EJ5B2Z8CX1WDSRPQ6A33GFJA&staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  BrowserActions.scroll_click(on(OAPage).approve_permit_btn_element)
  on(OAPage).set_to_time
  BrowserActions.scroll_click(on(OAPage).submit_permit_approval_btn_element)
  $browser.get(EnvironmentSelector.get_environment_url)
  step 'I click on pending approval filter'
  step 'I approve permit'
  step 'I click on back to home'
end