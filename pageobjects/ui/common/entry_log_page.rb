require './././support/env'

class EntryLog
  include PageObject

  element(:main_clock, xpath: "//h3[@data-testid='main-clock']")
  element(:back_arrow, xpath: "//button/*[@data-testid='arrow']")
  element(:shield_icon, xpath: "//img/*[@data-testid='shield-icon']")
  elements(:info_gas_testing_is_missing, xpath: "//div[starts-with(@class,'GasTesting')]/*")
  button(:home_button, xpath: "//button[contains(.,'Home')]")
  element(:entry_log_button, xpath: "//div[starts-with(@class,'Entry Log')]")
  text_field(:o2_input, xpath: "//input[@id='O2']")
  text_field(:hc_input, xpath: "//input[@id='HC']")
  text_field(:h2s_input, xpath: "//input[@id='H2S']")
  text_field(:co_input, xpath: "//input[@id='CO']")
  button(:continue_btn, xpath: "//button[contains(.,'Continue')]")
  button(:add_toxic_gas_btn, xpath: "//button[contains(.,'Add Toxic Gas')]")
  button(:review_sign_btn, xpath: "//button[contains(.,'Review & Sign')]")
  button(:enter_pin_and_submit_btn, xpath: "//button[contains(.,'Enter PIN & Submit')]")

  def normal_gas_readings(_o2,_hc,_h2s,_co)
    sleep 1
    o2_input_element.send_keys(_o2)
    hc_input_element.send_keys(_hc)
    h2s_input_element.send_keys(_h2s)
    co_input_element.send_keys(_co)
    continue_btn
  end

  def add_normal_gas_readings
    normal_gas_readings('1','2','3','4')
    sleep 1
  end

end
