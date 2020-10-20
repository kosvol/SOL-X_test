require './././support/env'

class PreDisplay < PumpRoomEntry
  include PageObject
  include GasReading

  element('warning_box', xpath: "//div[starts-with(@class,'WarningBox')]")
  element('permit_status', xpath: "//*[contains(text(),'Permit')]")
  element('info_gas_testing_is_missing', xpath: "//div[starts-with(@class,'GasTesting')]")

  #@browser.find_element(:xpath, "//div[starts-with(@class,'WarningBox')]").text

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
