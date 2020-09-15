And (/^I set oa permit to active state via manual office approval$/) do
  CommonPage.set_permit_id(on(Section0Page).created_ptw_id_elements.last.text)
  sleep 360
  $browser.get(OfficeApproval.get_office_approval_link(CommonPage.get_permit_id, 'VS', 'VS Automation').to_s)
  # $browser.get("http://office-approval.dev.solas.magellanx.io/approve-page/01EJ7WE70DY9C3FCCEM7S80FR7?staffId=410ab5c6feb3d2f1b030b9d9ce036138")
  BrowserActions.scroll_click(on(OAPage).approve_permit_btn_element)
  on(OAPage).set_to_time
  on(OAPage).set_to_date_plus_one_day(on(OAPage).issue_to_date_btn_element.text)
  BrowserActions.scroll_click(on(OAPage).submit_permit_approval_btn_element)
  $browser.get(EnvironmentSelector.get_environment_url)
  step 'I click on pending approval filter'
  step 'I approve permit'
  step 'I click on back to home'
end