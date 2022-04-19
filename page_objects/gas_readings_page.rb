# frozen_string_literal: true

require_relative 'base_page'

# gas readings page object
class GasReadingsPage < BasePage
  include EnvUtils
  GAS_EQUIP_DETAIL = {
    gas_equipment_input: "//input[@id='gasEquipment']",
    gas_sr_number_input: "//input[@id='gasSrNumber']",
    gas_last_calibrate: "//*[@id='gasLastCalibrationDate']",
    add_gas_test_record: "//button[contains(.,'Add Gas Test Records')]"
  }.freeze

  GAS_INFORMATION = {
    toxic_gas_rows: "//li[starts-with(@class,'GasReadingListItem')]",
    add_toxic_gas_btn: "//button[span='Add Gas']",
    continue_btn: "//button[contains(.,'Continue')]",
    enter_pin_and_submit_btn: 'div[role="dialog"] > div > div > div > button:nth-child(2)',
    toxic_delete_btn: '//*[@aria-label="deleteGas"]',
    button_template: "//button[contains(.,'%s')]",
    done_btn: '//button[contains(.,"Done")]',
    show_signature_btn: "//button[@data-testid='show-signature-display']"
  }.freeze

  GAS_READINGS = {
    gas_last_calibration_button: "//button[@id='gasLastCalibrationDate']",
    o2_input: "//input[@id='O2']",
    hc_input: "//input[@id='HC']",
    h2s_input: "//input[@id='H2S']",
    co_input: "//input[@id='CO']",
    gas_name_input: "//input[@id='gasName']",
    threshold_input: "//input[@id='threshold']",
    reading_input: "//input[@id='reading']",
    unit_input: "//input[@id='unit']",
    gas_reading_table: "//div[starts-with(@class,'cell')]",
    current_day_date: "//*[contains(@class, 'current')]"
  }.freeze

  GAS_DISPLAY = {
    o2: '(//*[@data-testid="gas-reading"])[1]', hc: '(//*[@data-testid="gas-reading"])[2]',
    co: '(//*[@data-testid="gas-reading"])[3]', h2s: '(//*[@data-testid="gas-reading"])[4]',
    toxic: '(//*[@data-testid="gas-reading"])[5]', signature: '//*[@class="cell signature"]'
  }.freeze

  def fill_gas_equipment_fields
    find_element(GAS_EQUIP_DETAIL[:gas_equipment_input])
    sleep 0.5
    enter_text(GAS_EQUIP_DETAIL[:gas_equipment_input], 'Test Automation')
    enter_text(GAS_EQUIP_DETAIL[:gas_sr_number_input], 'Test Automation')
    select_calibration_date
    click(GAS_EQUIP_DETAIL[:add_gas_test_record])
  end

  def add_normal_gas_readings(o2_gas, hc_gas, h2s_gas, co_gas)
    enter_text(GAS_READINGS[:o2_input], o2_gas)
    enter_text(GAS_READINGS[:hc_input], hc_gas)
    enter_text(GAS_READINGS[:h2s_input], h2s_gas)
    enter_text(GAS_READINGS[:co_input], co_gas)
  end

  def add_toxic_gas_readings(gas_name, threshold, reading, unit)
    click(GAS_INFORMATION[:add_toxic_gas_btn])
    enter_text(GAS_READINGS[:gas_name_input], gas_name)
    enter_text(GAS_READINGS[:threshold_input], threshold)
    enter_text(GAS_READINGS[:reading_input], reading)
    enter_text(GAS_READINGS[:unit_input], unit)
  end

  def click_pin_and_submit
    @driver.find_element(:css, GAS_INFORMATION[:enter_pin_and_submit_btn]).click
  end

  def click_done_button
    find_elements(GAS_INFORMATION[:done_btn]).first.click
  end

  def click_button(button_name)
    button_xpath = GAS_INFORMATION[:button_template] % button_name
    scroll_click(button_xpath)
  end

  def verify_location_in_sign(location)
    click(GAS_INFORMATION[:show_signature_btn])
    sleep 1
    signature = retrieve_text("(//div[starts-with(@class, 'Cell__Description')])[last()]")
    compare_string(signature, location)
  end

  def delete_toxic_readings
    click(GAS_INFORMATION[:toxic_delete_btn])
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
    compare_string('Required', find_element(GAS_READINGS[:o2_input]).attribute('placeholder'))
    compare_string('Required', find_element(GAS_READINGS[:hc_input]).attribute('placeholder'))
    compare_string('Required', find_element(GAS_READINGS[:h2s_input]).attribute('placeholder'))
    compare_string('Required', find_element(GAS_READINGS[:co_input]).attribute('placeholder'))
  end

  def verify_submit_btn(option)
    submit_btn_element = @driver.find_element(:css, GAS_INFORMATION[:enter_pin_and_submit_btn])
    if option == 'enabled'
      raise 'submit btn is disabled' unless submit_btn_element.enabled?
    elsif submit_btn_element.enabled?
      raise 'submit btn is enabled'
    end
  end

  def verify_gas_reading(table)
    params = table.hashes.first
    verify_normal_gas_reading(params)
    verify_toxic(params['Toxic'])
    verify_signature(params['Rank'])
  end

  def select_calibration_date
    click(GAS_READINGS[:gas_last_calibration_button])
    click(GAS_READINGS[:current_day_date])
    compare_string(find_element(GAS_READINGS[:gas_last_calibration_button]).text, Time.now.strftime('%d/%b/%Y'))
  end

  private

  def verify_gas_titles(gas_reading_table)
    (3..8).each { |number| compare_string(gas_reading_table[number].text, GAS_TABLE_TITLES[number]) }
  end

  def verify_normal_gas_reading(params)
    compare_string(params['O2'], retrieve_text(GAS_DISPLAY[:o2]))
    compare_string(params['HC'], retrieve_text(GAS_DISPLAY[:hc]))
    compare_string(params['CO'], retrieve_text(GAS_DISPLAY[:co]))
    compare_string(params['H2S'], retrieve_text(GAS_DISPLAY[:h2s]))
  end

  def verify_toxic(expected_toxic)
    expected_toxic += ' ' if expected_toxic == '-' # add space to match display
    compare_string(expected_toxic, retrieve_text(GAS_DISPLAY[:toxic]))
  end

  def verify_signature(rank)
    rank_name = UserService.new.retrieve_rank_and_name(rank)
    compare_string(rank_name, retrieve_text(GAS_DISPLAY[:signature]))
  end
end
