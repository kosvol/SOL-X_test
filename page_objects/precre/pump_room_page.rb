# frozen_string_literal: true"

require_relative '../base_page'
require_relative 'pre_cre_base_page'

# PumpRoomPage object
class PumpRoomPage < PRECREBase
  include EnvUtils
  include CommonSectionPage

  PUMP_ROOM = {
    current_activity_pre: "//*[contains(text(),'Pump Room Entry Permit')]/parent::span",
    pre_id: "//h4[contains(text(),'PRE No:')]/following::p",
    pump_room_display_setting: "//span[contains(.,'Pump Room')]",
    gas_last_calibration_button: "//button[@id='gasLastCalibrationDate']",
    checkbox: "//span[contains(text(),'%s')]/following::*[1]/label",
    text_area: '//textarea',
    button_sample: "//span[contains(.,'%s')]",
    picker: "//label[contains(text(),'Start Time')]//following::button[@data-testid='hours-and-minutes']",
    picker_hh: "//div[@class='time-picker']//div[starts-with(@class,'picker')][1]//*[contains(text(),'%s')]",
    picker_mm: "//div[@class='time-picker']//div[starts-with(@class,'picker')][2]//*[contains(text(),'%s')]",
    permit_validity: "//h2[contains(text(),'Permit Validity')]"
  }.freeze

  def pre_landing_false?
    false?(BASE_PRE_CRE[:heading_text].text.eql? 'Section 1: Pump Room Entry Permit')
  end

  def pre_questions(base_data)
    find_elements(BASE_PRE_CRE[:form_structure]).each_with_index do |element, index|
      compare_string(element.text, base_data[index])
    end
  end

  def alert_text_displayed?(value)
    element_displayed?("//div[contains(.,'%s')]", value)
  end

  def alert_not_present?(text)
    verify_element_not_exist(format("//div[contains(.,'%s')]", text).to_s)
  end

  def select_current_day
    click(BASE_PRE_CRE[:current_day_button])
  end

  def select_checkbox(answer, question)
    xpath_str = format(PUMP_ROOM[:checkbox], question)
    click(format(xpath_str, answer).to_s)
  end

  def fill_pre_form(duration)
    fill_all_text_areas(PUMP_ROOM[:text_area], 'Test Automation')
    checkbox_click(PUMP_ROOM[:button_sample], ['At Sea', 'In Port'].sample)
    select_permit_duration(duration)
  end

  def time_picker_activate(delay)
    time = find_element(COMMON_SECTION[:time_element].text)
    hh, mm = add_minutes(time, delay)
    picker_hh = format(PUMP_ROOM[:picker_hh], hh)
    picker_mm = format(PUMP_ROOM[:picker_mm], mm)
    click(PUMP_ROOM[:picker])
    scroll_click(picker_hh)
    scroll_click(picker_mm)
    click(PUMP_ROOM[:permit_validity])
  end

end
