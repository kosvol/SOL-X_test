require './././support/env'

class PreDisplay < PumpRoomEntry
  include PageObject
  # include GasReading

  element(:warning_box, xpath: "//div[starts-with(@aria-label,'create-entry-record')]/div/div")
  element(:permit_status, xpath: "//*[contains(text(),'Permit')]")
  elements(:info_gas_testing_is_missing, xpath: "//div[starts-with(@class,'GasTesting')]/*")
  elements(:pre_structure_on_pred, xpath: "//div/*[local-name()='h3' or (local-name()='span'  and not(contains(text(),'LT')))]")
  @@button_li = "//span[contains(text(),'%s')]/ancestor::li"  #home, entry log, permit


  def is_element_disabled_by_att?(text)
    #enable? - doesn't work for PRED. for 'li' elements
    xpath_str = @@button_li % [text]
    el = @browser.find_element('xpath', xpath_str)
    !el.attribute("disabled").nil?
  rescue StandardError
    false
  end

end
