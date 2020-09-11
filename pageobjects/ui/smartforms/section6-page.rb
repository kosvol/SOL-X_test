# frozen_string_literal: true

require './././support/env'

class Section6Page < Section4BPage
  include PageObject

  elements(:gas_yes_no, xpath: "//input[@name='gasReaderRequired']")
  # button(:save_and_next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button")
  button(:add_gas_reading_btn, xpath: "//div[starts-with(@class,'FormFieldGasReaderFactory__Container-')]/div/div/button")
  buttons(:submit_btn, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer')]/button")
  elements(:total_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]/div/section")
  # buttons(:back_home, xpath: "//button[starts-with(@class, 'Button__ButtonStyled')]")
  buttons(:date_and_time_btn, xpath: "//button[@id='gasLastCalibrationDate']")
  div(:rank_and_name_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]/div")
  div(:date_and_time_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]/div")

  element(:info_box_disable_gas, xpath: "//div[starts-with(@class,'InfoBox__InfoBoxWrapper')]")

  @@inf_box_disable_gas = "//div[starts-with(@class,'InfoBox__InfoBoxWrapper')]"
  text_field(:gas_equipment_input, xpath: "//input[@id='gasEquipment']")
  text_field(:gas_sr_number_input, xpath: "//input[@id='gasSrNumber']")
  element(:gas_last_calibration_button, xpath: "//button[@id='gasLastCalibrationDate']")
  # @@gas_equipment_input = "//input[@id='gasEquipment']"
  # @@gas_sr_number_input = "//input[@id='gasSrNumber']"
  # @@gas_last_calibration_button = "//button[@id='gasLastCalibrationDate']"
  @@gas_yes_no_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]//label"

  def is_gas_reader_section?
    sleep 1
    total_sections_elements.size >= 4
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

  def get_total_steps_to_section6(_which_section)
    case _which_section
    when '6'
      9
    when '4a'
      5
    when '3a'
      1
    when '3d'
      4
    when '4b'
      7
    when '3b'
      2
    end
  end
end
