# frozen_string_literal: true

require_relative 'base_page'

# GASReadings object
class GasReadingsPage < BasePage
  include EnvUtils
  GAS_INFORMATION = {
    gas_equipment_input: "//input[@id='gasEquipment']",
    gas_sr_number_input: "//input[@id='gasSrNumber']",
    last_calibration_btn: "//button[@id='gasLastCalibrationDate']",
    remove_toxic_btn: "//button[contains(.,'Remove')]",
    toxic_gas_rows: "//li[starts-with(@class,'GasReadingListItem')]",
    add_gas_btn: "//button[contains(.,'Add Gas Test Record')]",
    add_toxic_gas_btn: "//button[contains(.,'Add Toxic Gas')]",
    review_sign_btn: "//button[contains(.,'Review & Sign')]",
    continue_btn: "//button[contains(.,'Continue')]",
    enter_pin_and_submit_btn: 'div[role="dialog"] > div > div > div > button:nth-child(2)',
    toxic_delete_btn: '//button[@aria-label="Delete"]',
    done_btn: '//button[contains(.,"Done")]',
    show_signature_btn: "//button[@data-testid='show-signature-display']"
  }.freeze

  GAS_READINGS = {
    o2_input: "//input[@id='O2']",
    hc_input: "//input[@id='HC']",
    h2s_input: "//input[@id='H2S']",
    co_input: "//input[@id='CO']",
    gas_name_input: "//input[@id='gasName']",
    threshold_input: "//input[@id='threshold']",
    reading_input: "//input[@id='reading']",
    unit_input: "//input[@id='unit']",
    gas_reading_table: "//div[starts-with(@class,'cell')]"
  }.freeze

  def fill_gas_equipment_fields
    enter_text(GAS_INFORMATION[:gas_equipment_input], 'Test Automation')
    enter_text(GAS_INFORMATION[:gas_sr_number_input], 'Test Automation')
  end

  def add_normal_gas_readings(o2, hc, h2s, co)
    enter_text(GAS_READINGS[:o2_input], o2)
    enter_text(GAS_READINGS[:hc_input], hc)
    enter_text(GAS_READINGS[:h2s_input], h2s)
    enter_text(GAS_READINGS[:co_input], co)
    click(GAS_INFORMATION[:continue_btn])
  end

  def add_toxic_gas_readings(gas_name, threshold, reading, unit)
    enter_text(GAS_READINGS[:gas_name_input], gas_name)
    enter_text(GAS_READINGS[:threshold_input], threshold)
    enter_text(GAS_READINGS[:reading_input], reading)
    enter_text(GAS_READINGS[:unit_input], unit)
    click(GAS_INFORMATION[:add_toxic_gas_btn])
  end

  def click_add_gas_button
    scroll_click(GAS_INFORMATION[:add_gas_btn])
  end

  def click_review_and_sign
    scroll_click(GAS_INFORMATION[:review_sign_btn])
  end

  def click_pin_and_submit
    @driver.find_element(:css, GAS_INFORMATION[:enter_pin_and_submit_btn]).click
  end

  def click_done_button
    find_elements(GAS_INFORMATION[:done_btn]).first.click
  end

  def verify_gas_table_titles
    gas_reading_table = find_elements(GAS_READINGS[:gas_reading_table])
    compare_string(gas_reading_table[1].text, GAS_TABLE_TITLES[1])
    verify_gas_titles(gas_reading_table)
  end

  def verify_location_in_sign(location)
    click(GAS_INFORMATION[:show_signature_btn])
    signature = retrieve_text("(//div[@class='children']/div/div/div/div[3]/div/div)")
    compare_string(signature, location)
  end


  private

  def verify_gas_titles(gas_reading_table)
    (3..8).each { |number| compare_string(gas_reading_table[number].text, GAS_TABLE_TITLES[number]) }
  end

  GAS_TABLE_TITLES = { 1 => 'Initial',
                       3 => '1 %',
                       4 => '2 % LEL',
                       5 => '3 PPM',
                       6 => '4 PPM',
                       7 => '1.5 CC',
                       8 => 'C/O STG C/O' }.freeze

  def delete_toxic_readings
    click(GAS_INFORMATION[:toxic_delete_btn])
    click(GAS_INFORMATION[:remove_toxic_btn])
  end

  def verify_toxic_count(count)
    if count == '0'
      verify_element_not_exist(GAS_INFORMATION[:toxic_gas_rows])
      return
    end
    toxic_list = find_elements(GAS_INFORMATION[:toxic_gas_rows])
    compare_string(count, toxic_list.size)
  end

  def verify_placeholder
    compare_string('Required (Limit 20.9 %)', find_element(GAS_READINGS[:o2_input]).attribute('placeholder'))
    compare_string('Required (Limit 1 % LEL)', find_element(GAS_READINGS[:hc_input]).attribute('placeholder'))
    compare_string('Required (TLV-TWA 5 PPM)', find_element(GAS_READINGS[:h2s_input]).attribute('placeholder'))
    compare_string('Required (TLV-TWA 25 PPM)', find_element(GAS_READINGS[:co_input]).attribute('placeholder'))
  end

  def verify_submit_btn(option)
    submit_btn_element = @driver.find_element(:css, GAS_INFORMATION[:enter_pin_and_submit_btn])
    if option == 'enabled'
      raise 'submit btn is disabled' unless submit_btn_element.enabled?
    elsif submit_btn_element.enabled?
      raise 'submit btn is enabled'
    end
  end
end
