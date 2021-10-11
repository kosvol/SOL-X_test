# frozen_string_literal: true

require './././support/env'

class Section6Page < Section5Page
  include PageObject
  include GasReading

  element(:rank_and_name_stamp, xpath: "//button[starts-with(@data-testid,'show-signature-display')]/span/span")
  element(:date_and_time_stamp,
          xpath: "//div[starts-with(@class,'FormFieldGasReaderDisplay__GasReadingColumn')]/div[2]")
  elements(:info_box_disable_gas, xpath: "//div[starts-with(@class,'InfoBox__InfoBoxWrapper')]")
  elements(:info_warning_boxes, xpath: "//div[starts-with(@class,'InfoBox__')]/*")
  element(:gas_notes, xpath: "//div[starts-with(@class,'WarningBox__')]/*")
  elements(:gas_reading_table, xpath: "//div[starts-with(@class,'cell')]")
  elements(:toxic_gas_reading, xpath: "//li[@data-testid='gas-reader-list-item']//span")
  elements(:gas_yes_no, xpath: "//input[@name='gasReaderRequired']")
  elements(:total_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]/div/section")
  button(:gas_last_calibration_button, xpath: "//button[@id='gasLastCalibrationDate']")
  buttons(:last_calibration_btn, xpath: "//button[@id='gasLastCalibrationDate']")
  buttons(:submit_btn, xpath: "//div[starts-with(@class,'Section__Description')]/button")
  span(:gas_added_by, css: 'div[role="dialog"] > div > section > div > span')

  def gas_reading_fields_enabled?
    gas_equipment_input_element.text
    gas_sr_number_input_element.text
    gas_yes_no_elements.size == 2
  end

  def gas_reader_section?
    sleep 1
    p ">> #{total_sections_elements.size}"
    total_sections_elements.size == 5
  end

  def gas_testing_switcher(value)
    if value == 'Yes'
      gas_yes_no_elements.first.click
    else
      gas_yes_no_elements.last.click
    end
  end

  def normal_gas_readings(o2, hc, h2s, co)
    sleep 1
    o2_input_element.send_keys(o2)
    hc_input_element.send_keys(hc)
    h2s_input_element.send_keys(h2s)
    co_input_element.send_keys(co)
    continue_btn
    sleep 1
  end

  private

  def toxic_gas_readings(gas_name, threhold, reading, unit)
    BrowserActions.wait_until_is_visible(gas_name_input_element)
    BrowserActions.wait_until_is_displayed(gas_name_input_element)
    gas_name_input_element.send_keys(gas_name)
    threshold_input_element.send_keys(threhold)
    reading_input_element.send_keys(reading)
    unit_input_element.send_keys(unit)
    sleep 1
    add_toxic_gas_btn
    sleep 1
  end
end