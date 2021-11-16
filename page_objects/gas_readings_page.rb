# frozen_string_literal: true

require_relative 'base_page'

# GASREadings object
class GasReadingsPage < BasePage
  include EnvUtils
  GAS_READINGS = {
    # information fields
    gas_equipment_input: "//input[@id='gasEquipment']",
    gas_sr_number_input: "//input[@id='gasSrNumber']",
    last_calibration_btn: "//button[@id='gasLastCalibrationDate']",
    # main gas readings
    o2_input: "//input[@id='O2']",
    hc_input: "//input[@id='HC']",
    h2s_input: "//input[@id='H2S']",
    co_input: "//input[@id='CO']",
    # additional fields
    gas_name_input: "//input[@id='gasName']",
    threshold_input: "//input[@id='threshold']",
    reading_input: "//input[@id='reading']",
    unit_input: "//input[@id='unit']",
    # toxic gas readings
    remove_toxic_btn: "//button[contains(.,'Remove')]",
    toxic_gas_rows: "//li[starts-with(@class,'GasReadingListItem')]",
    add_gas_btn: "//button[contains(.,'Add Gas Test Record')]",
    add_toxic_gas_btn: "//button[contains(.,'Add Toxic Gas')]",
    review_sign_btn: "//button[contains(.,'Review & Sign')]",
    continue_btn: "//button[contains(.,'Continue')]",
    enter_pin_and_submit_btn: 'div[role="dialog"] > div > div > div > button:nth-child(2)'
  }.freeze

  def fill_gas_equipment_fields
    @driver.find_element(:xpath, GAS_READINGS[:gas_equipment_input]).send_keys('Test Automation')
    @driver.find_element(:xpath, GAS_READINGS[:gas_sr_number_input]).send_keys('Test Automation')
  end

  def normal_gas_readings(o2, hc, h2s, co)
    @driver.find_element(:xpath, GAS_READINGS[:o2_input]).send_keys(o2)
    @driver.find_element(:xpath, GAS_READINGS[:hc_input]).send_keys(hc)
    @driver.find_element(:xpath, GAS_READINGS[:h2s_input]).send_keys(h2s)
    @driver.find_element(:xpath, GAS_READINGS[:co_input]).send_keys(co)
    click(GAS_READINGS[:continue_btn])
  end

  def toxic_gas_readings(gas_name, threhold, reading, unit)
    find_element(GAS_READINGS[:gas_name_input]).send_keys(gas_name)
    find_element(GAS_READINGS[:threshold_input]).send_keys(threhold)
    find_element(GAS_READINGS[:reading_input]).send_keys(reading)
    find_element(GAS_READINGS[:unit_input]).send_keys(unit)
    click(GAS_READINGS[:add_toxic_gas_btn])
  end
end