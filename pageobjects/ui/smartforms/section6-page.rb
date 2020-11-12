# frozen_string_literal: true

require './././support/env'

class Section6Page < Section5Page
  include PageObject

  button(:remove_toxic_btn, xpath: "//button[contains(.,'Remove')]")
  button(:add_gas_btn, xpath: "//button[contains(.,'Add Gas Test Record')]")
  button(:add_toic_gas_btn, xpath: "//button[contains(.,'Add Toxic Gas')]")
  button(:review_sign_btn, xpath: "//button[contains(.,'Review & Sign')]")
  button(:enter_pin_and_submit_btn, xpath: "//button[contains(.,'Enter PIN & Submit')]")
  button(:continue_btn, xpath: "//button[contains(.,'Continue')]")
  elements(:gas_yes_no, xpath: "//input[@name='gasReaderRequired']")
  buttons(:submit_btn, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer')]/button")
  elements(:total_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]/div/section")
  buttons(:date_and_time_btn, xpath: "//button[@id='gasLastCalibrationDate']")
  div(:rank_and_name_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]/div")
  div(:date_and_time_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]/div")
  @@gas_added_by = "//span[contains(.,'%s')]"

  element(:info_box_disable_gas, xpath: "//div[starts-with(@class,'InfoBox__InfoBoxWrapper')]")

  @@inf_box_disable_gas = "//div[starts-with(@class,'InfoBox__InfoBoxWrapper')]"
  text_field(:gas_equipment_input, xpath: "//input[@id='gasEquipment']")
  text_field(:gas_sr_number_input, xpath: "//input[@id='gasSrNumber']")
  text_field(:o2_input, xpath: "//input[@id='o2']")
  text_field(:hc_input, xpath: "//input[@id='hc']")
  text_field(:h2s_input, xpath: "//input[@id='h2s']")
  text_field(:co_input, xpath: "//input[@id='co']")
  text_field(:gas_name_input, xpath: "//input[@id='gasName']")
  text_field(:threshold_input, xpath: "//input[@id='threshold']")
  text_field(:reading_input, xpath: "//input[@id='reading']")
  text_field(:unit_input, xpath: "//input[@id='unit']")

  elements(:gas_reading_table, xpath: "//div[starts-with(@class,'cell')]")
  elements(:toxic_gas_reading, xpath: "//li[@data-testid='gas-reader-list-item']//span")

  element(:gas_last_calibration_button, xpath: "//button[@id='gasLastCalibrationDate']")
  @@gas_yes_no_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]//label"

  def is_gas_reading_fields_enabled?
    gas_equipment_input_element.text
    gas_sr_number_input_element.text
    gas_yes_no_elements.size === 2
  end

  def get_gas_added_by(_agt)
    @browser.find_element(:xpath, format(@@gas_added_by, _agt))
  end

  def add_all_gas_readings
    normal_gas_readings
    sleep 1
    gas_name_input_element.send_keys('Test')
    threshold_input_element.send_keys('20')
    reading_input_element.send_keys('1.5')
    unit_input_element.send_keys('cc')
    add_toic_gas_btn
    sleep 1
  end

  def add_normal_gas_readings
    normal_gas_readings
    sleep 1
  end

  def is_gas_reader_section?
    sleep 1
    total_sections_elements.size > 3
  end

  def toggle_to_section(_which_section)
    (1..get_total_steps_to_section6(_which_section)).each do |_i|
      sleep 2
      click_next
    end
  end

  def gas_testing_switcher(value)
    select_checkbox(@@gas_yes_no_btn, value)
  end

  def is_info_box_disable_gas_exist?
    $browser.find_element(:xpath, @@inf_box_disable_gas)
    true
  rescue StandardError
    false
  end

  private

  def normal_gas_readings
    add_gas_btn
    sleep 1
    o2_input_element.send_keys('1')
    hc_input_element.send_keys('2')
    h2s_input_element.send_keys('3')
    co_input_element.send_keys('4')
    continue_btn
  end
end
