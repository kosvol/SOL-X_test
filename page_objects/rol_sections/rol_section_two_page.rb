# frozen_string_literal: true

require_relative '../base_page'

# RoLSectionTwoPage object
class RoLSectionTwoPage < BasePage
  include EnvUtils
  ROL_SECTION_TWO = {
    section_header: "//h3[contains(.,'Rigging of Gangway & Pilot Ladder Checklist')]",
    form_answers: "//*[starts-with(@class,'AnswerComponent__Answer')]",
    headers: "//div[contains(@class,'Section__Description')]//h2",
    subheaders: "//div[contains(@class,'Section__Description')]//h4",
    questions: "//div[contains(@class,'Section__Description')]/div/div/span",
    warning_box: "//div[starts-with(@class,'WarningBox__')]",
    boarding_arr_btn: "//button[@id='cl_riggingOfLadder_boardingArrangement']",
    dd_list_value: "//ul[starts-with(@class,'UnorderedList-')]/li/button",
    duration_dd_btn: "//button[@id='permitValidDuration']",
    submit_btn: "//button[contains(., 'Submit')]",
    previous_btn: "//button[contains(.,'Previous')]",
    active_btn: "//button[contains(., 'Activate Permit To Work')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ROL_SECTION_TWO[:section_header])
  end

  def verify_rol_checklist_details
    current_created_date = retrieve_created_date
    actual_answers = retrieve_actual_chlist_answers
    compare_string(retrieve_vessel_name, actual_answers[1])
    compare_string('Rigging of Gangway & Pilot Ladder', actual_answers[0])
    raise 'DRA date/time is not pre-filled' unless actual_answers[2].include? current_created_date
  end

  def verify_rol_section_two_data
    expected_checklist = YAML.load_file('data/sections-data/rol_section_2.yml')['questions']
    expected_checklist.each do |question|
      next if retrieve_section_items('headers').include? question
      next if retrieve_section_items('subheaders').include? question
      next if retrieve_section_items('questions').include? question

      raise "#{question} verified failed"
    end
  end

  def verify_checklist_warn_box
    expected_box = YAML.load_file('data/sections-data/rol_section_2.yml')['warning_box']
    actual_elements = find_elements(ROL_SECTION_TWO[:warning_box])
    actual_elements.each_with_index do |element, index|
      compare_string(expected_box[index], element.text)
    end
  end

  def verify_ddl_value(ddl_type, table)
    case ddl_type
    when 'Duration'
      @driver.execute_script('window.scrollBy(0,document.body.scrollHeight)', '')
      click(ROL_SECTION_TWO[:duration_dd_btn])
    else
      click(ROL_SECTION_TWO[:boarding_arr_btn])
    end
    dropdown_elements = find_elements(ROL_SECTION_TWO[:dd_list_value])
    verify_each_value(table, dropdown_elements)
  end

  def verify_submit_btn(option)
    verify_btn_availability(ROL_SECTION_TWO[:submit_btn], option)
  end

  def verify_no_extra_btns
    verify_element_not_exist("//button[contains(.,'Save')]")
    verify_element_not_exist("//button[contains(.,'Close')]")
    compare_string(@driver.find_elements(xpath: ROL_SECTION_TWO[:previous_btn]).size, 1)
  end

  def verify_no_duration_dd
    verify_element_not_exist(ROL_SECTION_TWO[:duration_dd_btn])
  end

  def select_permit_duration(duration)
    @driver.execute_script('window.scrollBy(0,document.body.scrollHeight)', '')
    click(ROL_SECTION_TWO[:duration_dd_btn])
    find_elements(ROL_SECTION_TWO[:dd_list_value])[duration - 1].click
  end

  def click_activate
    click(ROL_SECTION_TWO[:active_btn])
  end

  def click_submit_btn
    sleep 1
    scroll_times_direction(2, 'down')
    scroll_click(ROL_SECTION_TWO[:submit_btn])
  end

  private

  def retrieve_actual_chlist_answers
    result = []
    actual_answers = @driver.find_elements(:xpath, ROL_SECTION_TWO[:form_answers])
    actual_answers.each do |element|
      result.append(element.text)
    end
    result
  end

  def retrieve_created_date
    time_offset = TimeService.new.retrieve_ship_utc_offset
    (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%d/%b/%Y')
  end

  def retrieve_section_items(items)
    questions = []
    elements = @driver.find_elements(:xpath, ROL_SECTION_TWO[:"#{items.to_sym}"])
    elements.each do |element|
      questions << element.text
    end
    questions
  end

  def verify_each_value(table, dropdown_elements)
    table.raw.each_with_index do |item, index|
      compare_string(item.first, dropdown_elements[index].text)
    end
  end
end
