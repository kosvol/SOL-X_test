# frozen_string_literal: true"

require_relative '../base_page'
require_relative '../sections/common_section_page'

# PumpRoomPage object
class PumpRoomPage < CreateEntryPermitPage
  include EnvUtils

  PUMP_ROOM = {
    current_activity_pre: "//*[contains(text(),'Pump Room Entry Permit')]/parent::span",
    pre_header: "//*[contains(text(),'Section 1: Pump Room Entry Permit')]",
    pre_id: "//h4[contains(text(),'PRE No:')]/following::p",
    pump_room_display_setting: "//span[contains(.,'Pump Room')]",
    gas_last_calibration_button: "//button[@id='gasLastCalibrationDate']",
    checkbox: "//span[contains(text(),'%s')]/following::*[1]/label",
    text_area: '//textarea',
    button_sample: "//span[contains(.,'%s')]",
    picker: "//label[contains(text(),'Start Time')]//following::button[@data-testid='hours-and-minutes']",
    picker_hh: "//div[@class='time-picker']//div[starts-with(@class,'picker')][1]//*[contains(text(),'%s')]",
    picker_mm: "//div[@class='time-picker']//div[starts-with(@class,'picker')][2]//*[contains(text(),'%s')]",
    permit_validity: "//h2[contains(text(),'Permit Validity')]",
    time_element: '//*[@id="permitActiveAt"]',
    error_msg: "//div[contains(.,'%s')]"
  }.freeze

  def initialize(driver)
    super
    find_element(PUMP_ROOM[:pre_header])
  end

  def verify_pre_questions
    base_data = YAML.load_file('data/pre/pump-room-entries.yml')['questions']
    find_elements(CREATE_ENTRY_PERMIT[:form_structure]).each_with_index do |element, index|
      compare_string(element.text, base_data[index])
    end
  end

  def verify_error_msg(error_msg)
    actual_msg = retrieve_text(CREATE_ENTRY_PERMIT[:error_msg])
    compare_string(error_msg, actual_msg)
  end

  def verify_text_not_present(text)
    verify_element_not_exist(format("//div[contains(.,'%s')]", text).to_s)
  end

  def select_checkbox(answer, question)
    xpath_str = format(PUMP_ROOM[:checkbox], question)
    click(format(xpath_str, answer).to_s)
  end

  def fill_pre_form(duration)
    tmp_elements = find_elements(PUMP_ROOM[:text_area])
    tmp_elements.each do |element|
      element.send_keys('Test Automation')
    end
    click(format(PUMP_ROOM[:button_sample], ['At Sea', 'In Port'].sample).to_s)
    select_permit_duration(duration)
  end

  def activate_time_picker(delay)
    click(PUMP_ROOM[:picker])
    scroll_click(picker_hh_mm(delay).first)
    scroll_click(picker_hh_mm(delay).last)
    @driver.action.move_to(@driver.find_element(:xpath, PUMP_ROOM[:picker]), 50, 50).click.perform
  end

  def select_calibration_date
    click(PUMP_ROOM[:gas_last_calibration_button])
    select_current_day
    compare_string(PUMP_ROOM[:gas_last_calibration_button].text, Time.now.strftime('%d/%b/%Y'))
  end

  def verify_pre_section_title(text, condition)
    if condition == true
      raise 'Verify failed' unless CREATE_ENTRY_PERMIT[:heading_text].text.eql?(text)
    else
      raise 'Verify failed' unless (CREATE_ENTRY_PERMIT[:heading_text].text.eql?(text)) == true
    end
  end

  def click_close_button
    click("//button[contains(.,'Close')]")
  end

  private

  def select_current_day
    click(CREATE_ENTRY_PERMIT[:current_day_button])
  end

  def picker_hh_mm(delay)
    time = find_element(PUMP_ROOM[:time_element]).text
    hh, mm = add_minutes(time, delay)
    picker_hh = format(PUMP_ROOM[:picker_hh], hh)
    picker_mm = format(PUMP_ROOM[:picker_mm], mm)
    [picker_hh, picker_mm]
  end

  def add_minutes(time, add_mm)
    hh, mm = time.split(':')
    mm = mm.to_i
    hh = hh.to_i
    mm += add_mm.to_i
    if mm >= 60
      mm -= 60
      hh += 1
    end
    [format('%02d', hh), format('%02d', mm)]
  end
end
