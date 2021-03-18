require '././support/env'

class PreDisplay < Section9Page
  include PageObject
  # include GasReading

  element(:warning_box, xpath: "//div[starts-with(@aria-label,'create-entry-record')]/div/div")
  element(:permit_status, xpath: "//*[contains(text(),'Permit')]")
  elements(:info_gas_testing_is_missing, xpath: "//div[starts-with(@class,'GasTesting')]/*")
  elements(:pre_structure_on_pred, xpath: "//div/*[local-name()='h3' or (local-name()='span'  and not(contains(text(),'LT')))]")
  @@button_li = "//span[contains(text(),'%s')]/ancestor::li"  #home, entry log, permit

  element(:entrant_count, xpath: "//span[starts-with(@aria-label,'active-entrant-counter')]")
  element(:new_entry_log, xpath: "//span[contains(text(),'New Entry')]")
  element(:send_report, xpath: "//span[contains(text(),'Send Report')]")
  element(:entry_log_btn, xpath: "//a[contains(.,'Entry Log')]")
  elements(:sign_out_btn, xpath: "//span[contains(text(),'Sign Out')]")
  elements(:cross_btn, xpath: "//button[contains(@class,'Button__ButtonStyled-')]/span")
  element(:home_tab, xpath: "//a[contains(.,'Home')]")
  element(:entry_log_tab, xpath: "//a[contains(.,'Home')]")
  element(:permit_tab, xpath: "//a[contains(.,'Home')]")
  element(:pre_creator_display, xpath: "//span[contains(@class,'ActivePermitDetails')]")
  element(:time_shifted_by_text, xpath: "//div[contains(@class,'PermitValidUntil__TextSmall')]")
  element(:pre_duration_timer, xpath: "//div[contains(@class,'PermitValidUntil__SecondaryHeaderText')]/span")
  buttons(:send_report_btn, xpath: "//button[contains(.,\"Send Report\")]")

  def is_element_disabled_by_att?(text)
    #enable? - doesn't work for PRED. for 'li' elements
    xpath_str = @@button_li % [text]
    el = @browser.find_element('xpath', xpath_str)
    !el.attribute("disabled").nil?
  rescue StandardError
    false
  end
end
