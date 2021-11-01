# frozen_string_literal: true"

require_relative '../base_page'
require_relative 'pre_cre_base_page'

class PumpRoomPage < PRECREBase
  include EnvUtils

  PUMP_ROOM = {
    current_activity_pre: "//*[contains(text(),'Pump Room Entry Permit')]/parent::span",
    pre_id: "//h4[contains(text(),'PRE No:')]/following::p",
    pump_room_display_setting: "//span[contains(.,'Pump Room')]",
    gas_last_calibration_button: "//button[@id='gasLastCalibrationDate']"
  }.freeze

  def pre_landing_true?
    is_true(BASE_PRE_CRE[:heading_text].text == 'Section 1: Pump Room Entry Permit')
  end

  def pre_landing_false?
    is_false(BASE_PRE_CRE[:heading_text].text == 'Section 1: Pump Room Entry Permit')
  end

  def pre_questions(base_data)
    find_elements(BASE_PRE_CRE[:form_structure]).each_with_index do |element, index|
      compare_string(element.text, base_data[index])
    end
  end

  def alert_text_displayed?(value)
    element_displayed?("//div[contains(.,'%s')]", value)
  end

  def alert_present?(text)
    is_true(alert_text_displayed?(text))
  end

  def alert_not_present?(text)
    is_false(alert_text_displayed?(text))
  end

  def select_current_day
    click(BASE_PRE_CRE[:current_day_button])
  end

end
