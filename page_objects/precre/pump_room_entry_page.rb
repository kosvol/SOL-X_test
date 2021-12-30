# frozen_string_literal: true"

require_relative '../base_page'

# PumpRoomEntryPage object
class PumpRoomEntryPage < CreateEntryPermitPage
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
    error_msg: "//div[contains(.,'%s')]",
    warning_box: "//*[contains(@class, 'WarningBox__AlertWrapper')][3]",
    purpose_of_entry: "//textarea[@id='reasonForEntry']",
    picker_days: "//label[contains(text(),'Start Time')]//following::button[@data-testid='days']",
    selected_day: "//*[contains(@class, 'selected')]",
    current_day_date: "//*[contains(@class, 'current')]",
    current_day: "//button[contains(@class,'Day__DayButton')]",
    scheduled_date: "//*[contains(.,'Scheduled for')]/parent::*//span[1]",
    heading_text: "//*[@id='navigation-wrapper']/nav/h3",
    form_structure: "//div[contains(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span"
  }.freeze

  def initialize(driver)
    super
    find_element(PUMP_ROOM[:pre_header])
  end

  def verify_pre_questions
    base_data = YAML.load_file('data/pre/pump-room-entries.yml')['questions']
    find_elements(PUMP_ROOM[:form_structure]).each_with_index do |element, index|
      compare_string(element.text, base_data[index])
    end
  end

  def verify_error_msg(error_msg)
    actual_msg = retrieve_text(PUMP_ROOM[:warning_box])
    raise "Verification failed, error message #{error_msg} not presents on screen" unless actual_msg.include? error_msg
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
    click(CREATE_ENTRY_PERMIT[:picker])
    scroll_click(picker_hh_mm(delay).first)
    scroll_click(picker_hh_mm(delay).last)
    @driver.action.move_to(@driver.find_element(:xpath, CREATE_ENTRY_PERMIT[:picker]), 50, 50).click.perform
  end

  def select_calibration_date
    click(PUMP_ROOM[:gas_last_calibration_button])
    select_current_day
    compare_string(find_element(PUMP_ROOM[:gas_last_calibration_button]).text, Time.now.strftime('%d/%b/%Y'))
  end

  def verify_pre_section_title(text)
    actual_title = find_element(PUMP_ROOM[:heading_text]).text
    raise "#{actual_title} is not Pump room page" unless actual_title == text
  end

  def select_day_in_future(number)
    click(PUMP_ROOM[:picker_days])
    current_day = find_element(PUMP_ROOM[:current_day_date]).text
    self.selected_date = current_day.to_i + number.to_i
    changed_day = "//div[starts-with(@class,'DatePicker__OverlayContainer')]//button[contains(.,'#{current_day.to_i +
      number.to_i}')]"
    click(changed_day)
  end

  def verify_scheduled_date
    text = retrieve_text(PUMP_ROOM[:scheduled_date])
    raise "Text #{text} not contain scheduled date #{selected_date}" unless text.include? selected_date.to_s
  end

  private

  def select_current_day
    click(PUMP_ROOM[:current_day])
  end
end
