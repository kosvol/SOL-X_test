# frozen_string_literal: true

require_relative '../base_page'

# RoLSectionOnePage object
class RoLSectionOnePage < BasePage
  include EnvUtils
  ROL_SECTION_ONE = {
    section_header: "//h3[contains(.,'Detailed Risk Assessments')]",
    form_answers: "//*[starts-with(@class,'AnswerComponent__Answer')]",
    edit_hazard_btn: "//button[contains(.,'View/Edit Hazards')]",
    headers: "//div[contains(@class,'Section__Description')]//h2",
    subheaders: "//div[contains(@class,'Section__Description')]//h4",
    questions: "//div[contains(@class,'Section__Description')]/div/div/span",
    other: "//div[contains(@class,'Section__Description')]//div[contains(@class, 'ontainer')]/label"
  }.freeze

  def initialize(driver)
    super
    find_element(ROL_SECTION_ONE[:section_header])
  end

  def verify_rol_dra_details
    current_created_date = retrieve_created_date
    actual_answers = retrieve_actual_dra_answers
    compare_string(retrieve_vessel_name, actual_answers[0])
    compare_string('Rigging of Gangway & Pilot Ladder', actual_answers[3])
    compare_string('Standard procedure for rigging Pilot/Combination Ladder', actual_answers[4])
    raise 'DRA no is not updated' if actual_answers[1].include? 'DRA/TEMP'
    raise 'DRA date/time is not pre-filled' unless actual_answers[2].include? current_created_date
  end

  def verify_rol_section_one_data
    expected_checklist = YAML.load_file('data/sections-data/rol_section_1.yml')['questions']
    expected_checklist.each do |question|
      next if retrieve_section_items('headers').include? question
      next if retrieve_section_items('subheaders').include? question
      next if retrieve_section_items('questions').include? question
      next if retrieve_section_items('other').include? question

      raise "#{question} verified failed"
    end
  end

  def verify_no_previous_btn
    verify_element_not_exist("//button[contains(.,'Previous')]")
  end

  def verify_next_btn_text(option)
    sleep 0.5
    find_element("//button/span[text()='#{option}']")
  end

  private

  def retrieve_actual_dra_answers
    result = []
    actual_answers = @driver.find_elements(:xpath, ROL_SECTION_ONE[:form_answers])
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
    elements = @driver.find_elements(:xpath, ROL_SECTION_ONE[:"#{items.to_sym}"])
    elements.each do |element|
      questions << element.text
    end
    questions
  end

  def retrieve_questions(css_input)
    questions = []
    @driver.manage.timeouts.implicit_wait = 0
    elements = @driver.find_elements(:xpath, "//div[contains(@class,'Section__Description')]/div/div/#{css_input}")
    @driver.manage.timeouts.implicit_wait = TIMEOUT
    elements.each do |element|
      questions << element.text
    end
    questions
  end
end
