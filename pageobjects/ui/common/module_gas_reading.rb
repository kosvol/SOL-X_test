require './././support/env'

module GasReading
  include PageObject
  
  text_field(:gas_equipment_input, xpath: "//input[@id='gasEquipment']")
  text_field(:gas_sr_number_input, xpath: "//input[@id='gasSrNumber']")
  buttons(:last_calibration_btn, xpath: "//button[@id='gasLastCalibrationDate']")

  text_field(:o2_input, xpath: "//input[@id='O2']")
  text_field(:hc_input, xpath: "//input[@id='HC']")
  text_field(:h2s_input, xpath: "//input[@id='H2S']")
  text_field(:co_input, xpath: "//input[@id='CO']")

  text_field(:gas_name_input, xpath: "//input[@id='gasName']")
  text_field(:threshold_input, xpath: "//input[@id='threshold']")
  text_field(:reading_input, xpath: "//input[@id='reading']")
  text_field(:unit_input, xpath: "//input[@id='unit']")

#   button(:del_row_stage1, xpath: "//button[@aria-label = 'Delete']")
#   button(:del_row_stage2, xpath: "//span[contains(text(),'Remove')]//..")
  button(:remove_toxic_btn, xpath: "//button[contains(.,'Remove')]")
  elements(:toxic_gas_rows, xpath: "//li[starts-with(@class,'GasReadingListItem')]")
  button(:add_gas_btn, xpath: "//button[contains(.,'Add Gas Test Record')]")
  button(:add_toxic_gas_btn, xpath: "//button[contains(.,'Add Toxic Gas')]")
  button(:review_sign_btn, xpath: "//button[contains(.,'Review & Sign')]")
  button(:continue_btn, xpath: "//button[contains(.,'Continue')]")

  def add_all_gas_readings
    add_gas_btn
    normal_gas_readings('1','2','3','4')
    sleep 1
    toxic_gas_readings('Test','20','1.5','cc')
  end

  def add_normal_gas_readings
    add_gas_btn
    normal_gas_readings('1','2','3','4')
    sleep 1
  end

  def toxic_gas_del_row
    if toxic_gas_rows_elements.size === 1
      del_row_stage1
      del_row_stage2
    end
  end

end


