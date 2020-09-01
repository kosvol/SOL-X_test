# frozen_string_literal: true

require './././support/env'

class Section4BPage < Section4APage
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  elements(:yes_no_btn, xpath: "//input[@name='energyIsolationCertIssued']")
  button(:create_eic_btn, xpath: "//button[contains(.,'Create Energy Isolation Certificate')]")
  button(:date_and_time_btn, xpath: '//button[@id="workSiteVisitSafetyChecksAndProcsCompletedOn"]')
  elements(:time_picker, xpath: "//div[@class='picker']")
  button(:calendar_btn, xpath: "//button[starts-with(@class,'Day__DayButton')]")
  element(:signature, xpath: "//div[@class='signature']/img")
  span(:location_stamp, xpath: "//div[starts-with(@class,'ComboButton__Container')]/button/span")
  # span(:location_stamp, xpath: "//p[starts-with(@class,'Input__Answer')]")

  # sub form
  elements(:eic_date_and_time, xpath: "//button[@id='eic_eicCreatedDate']")
  # @@eic_number = "//input[@id='eicNumber']"
  button(:competent_enter_pin, xpath: "//div[starts-with(@class,'Section__Description')]/div/label/button")
  elements(:eic_signer_name, xpath: "//div[starts-with(@class,'Section__Description')]/div[2]")
  # index first: competent, second: issuer, save and close
  buttons(:subform_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/button")

  def is_eic_details_prepopulated?
    # set_current_time
    # sleep 1
    Log.instance.info(">>> #{eic_date_and_time_elements[1].text} vs #{get_current_time_format}")
    Log.instance.info(">>> #{eic_date_and_time_elements[0].text} vs #{get_current_date_format_with_offset}")
    Log.instance.info(">>> #{generic_data_elements[1].text.include? "SIT/EIC/#{BrowserActions.get_year}"}")
    ((eic_date_and_time_elements[0].text === get_current_date_format_with_offset) && (eic_date_and_time_elements[1].text === get_current_time_format) && (generic_data_elements[1].text.include? 'SIT/EIC/'))
  end
end
