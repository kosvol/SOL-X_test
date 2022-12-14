# frozen_string_literal: true

require_relative '../base_page'

# PumpRoomEntryPage object
class PumpRoomEntryPage < BasePage
  include EnvUtils

  PUMP_ROOM = {
    pre_header: "//h3[contains(.,'Pump Room Entry Permit')]",
    current_activity_pre: "//*[contains(text(),'Pump Room Entry Permit')]/parent::span",
    pre_id: "//h4[contains(text(),'PRE No:')]/following::p",
    pump_room_display_setting: "//span[contains(.,'Pump Room')]",
    checklist: "//span[contains(text(),'%s')]/following::*[1]/label",
    text_area: '//textarea',
    radio_button: "//span[contains(.,'%s')]",
    permit_validity: "//h2[contains(text(),'Permit Validity')]",
    time_element: '//*[@id="permitActiveAt"]',
    error_msg: "//div[contains(.,'%s')]",
    purpose_of_entry: "//textarea[@id='reasonForEntry']",
    picker_days: "//label[contains(text(),'Start Time')]//following::button[@data-testid='days']",
    selected_day: "//*[contains(@class, 'selected')]",
    current_day_date: "//*[contains(@class, 'current')]",
    scheduled_date: "//*[contains(.,'Scheduled for')]/parent::*//span[1]",
    heading_text: "//*[@id='navigation-wrapper']/nav/h3",
    form_structure: "//div[contains(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span",
    reporting_interval: "//input[@id='pre_section2_reportingIntervalPeriod']",
    terminate_btn: "//button[span='Terminate']",
    duration_dd_btn: "//button[@id='permitValidDuration']",
    dd_list_value: "//ul[starts-with(@class,'UnorderedList-')]/li/button/div[contains(text(),'%s')]"
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

  def verify_text_not_present(text)
    verify_element_not_exist(format("//div[contains(.,'%s')]", text).to_s)
  end

  def select_answer(table)
    table.raw.each do |question, answer|
      xpath_str = format(PUMP_ROOM[:checklist], question) + format(PUMP_ROOM[:radio_button], answer)
      click(xpath_str.to_s)
    end
  end

  def fill_text_area
    tmp_elements = find_elements(PUMP_ROOM[:text_area])
    tmp_elements.each do |element|
      element.send_keys('Test Automation')
    end
  end

  def select_permit_duration(duration)
    @driver.execute_script('window.scrollBy(0,document.body.scrollHeight)', '')
    click(PUMP_ROOM[:duration_dd_btn])
    click(format(PUMP_ROOM[:dd_list_value], duration))
  end

  def verify_scheduled_date
    text = retrieve_text(PUMP_ROOM[:scheduled_date])
    raise "Text #{text} not contain scheduled date #{selected_date}" unless text.include? selected_date.to_s
  end

  def verify_reporting_interval(condition)
    scroll_times_direction(1, 'down')
    if condition == 'should'
      reporting_interval = find_element(PUMP_ROOM[:reporting_interval])
      raise 'reporting interval verify failed' unless reporting_interval.enabled?
    else
      verify_element_not_exist(PUMP_ROOM[:reporting_interval])
    end
  end

  def click_terminate_btn
    scroll_click(PUMP_ROOM[:terminate_btn])
  end

  def verify_non_editable
    verify_element_not_exist(PUMP_ROOM[:text_area])
    verify_element_not_exist(PUMP_ROOM[:radio_button])
    verify_element_not_exist(PUMP_ROOM[:duration_dd_btn])
  end
end
