# frozen_string_literal: true

require './././support/env'

class Section4BPage < Section4APage
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  elements(:yes_no_btn, xpath: "//input[@name='energyIsolationCertIssued']")
  button(:create_eic_btn, xpath: "//section[starts-with(@class, 'Section__SectionMain')]/div/div/label/button")
  button(:date_and_time_btn, xpath: '//button[@id="workSiteVisitSafetyChecksAndProcsCompletedOn"]')
  elements(:time_picker, xpath: "//div[@class='picker']")
  button(:calendar_btn, xpath: "//button[starts-with(@class,'Day__DayButton')]")
  element(:signature, xpath: "//div[@class='signature']/img")
  span(:location_stamp, xpath: "//div[starts-with(@class,'ComboButton__Container')]/button/span")

  # sub form
  elements(:eic_date_and_time, xpath: "//button[@id='eic_eicCreatedDate']")
  @@eic_number = "//input[@id='eicNumber']"
  button(:competent_enter_pin, xpath: "//div[starts-with(@class,'Section__Description')]/div/label/button")
  elements(:eic_signer_name, xpath: "//div[starts-with(@class,'Section__Description')]/div[2]")
  # index first: competent, second: issuer, save and close
  buttons(:subform_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/button")

  def is_eic_details_prepopulated?
    # set_current_time
    # sleep 1
    Log.instance.info(">>> #{get_current_date_format}")
    Log.instance.info(">>> #{get_current_time_format}")
    Log.instance.info(">>> #{BrowserActions.get_attribute_value(@@eic_number).include? 'SIT/EIC/'}")
    ((eic_date_and_time_elements[0].text === get_current_date_mm_yyyy_format) && (eic_date_and_time_elements[1].text === get_current_time_format) && (BrowserActions.get_attribute_value(@@eic_number).include? 'SIT/EIC/'))
  end
end
