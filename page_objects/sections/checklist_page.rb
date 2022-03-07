# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/utils/time_service'

# ChecklistPage object
class ChecklistPage < BasePage
  include EnvUtils
  CHECKLIST = {
    info_box: "//div[starts-with(@class,'InfoBox__')]",
    warning_box: "//div[starts-with(@class,'WarningBox__')]",
    heavy_weather_note_box: '//div[@id="4A_HEAVY_WEATHER_2"]',
    rank_name: "(//*[starts-with(@class,'Cell__Description')])[1]",
    location_stamp: "(//*[starts-with(@class,'AnswerComponent__Answer')])[last()]",
    vessel_name: "(//*[starts-with(@class,'AnswerComponent__Answer')])[1]",
    created_on: "(//*[starts-with(@class,'AnswerComponent__Answer')])[2]"
  }.freeze

  def verify_checklist_questions(checklist)
    expected_checklist = YAML.load_file("data/checklist/#{checklist}.yml")['questions']
    expected_checklist.each do |question|
      next if retrieve_questions('span').include? question
      next if retrieve_questions('label').include? question
      next if retrieve_questions('h4').include? question
      next if retrieve_questions('p').include? question

      raise "#{question} verified failed"
    end
  end

  def verify_checklist_box(checklist, box_type)
    expected_box = YAML.load_file("data/checklist/#{checklist}.yml")[box_type]
    actual_elements = find_elements(CHECKLIST[box_type.to_sym])
    actual_elements.each_with_index do |element, index|
      compare_string(expected_box[index], element.text)
    end
  end

  def verify_location_stamp(zone)
    actual_element = find_element(CHECKLIST[:location_stamp])
    wait_util_text_update(actual_element, 'Not Answered') # wait for location update
    compare_string(zone, actual_element.text)
  end

  def verify_rank_name(rank)
    expected_rank_name = UserService.new.retrieve_rank_and_name(rank)
    actual_element = find_element(CHECKLIST[:rank_name])
    wait_util_text_update(actual_element, 'Not Answered') # wait for location update
    compare_string(expected_rank_name, actual_element.text)
  end

  def verify_checklist_answers
    verify_vessel_name
    verify_created_time
  end

  private

  def retrieve_questions(css_input)
    questions = []
    @driver.manage.timeouts.implicit_wait = 0
    elements = @driver.find_elements(:xpath, "//div/#{css_input}")
    @driver.manage.timeouts.implicit_wait = TIMEOUT
    elements.each do |element|
      questions << element.text
    end
    questions
  end

  def verify_vessel_name
    expected_vessel_name = retrieve_vessel_name
    actual_vessel_name = retrieve_text(CHECKLIST[:vessel_name])
    compare_string(expected_vessel_name, actual_vessel_name)
  end

  def verify_created_time
    TimeService.new.retrieve_ship_utc_offset
    time_offset = TimeService.new.retrieve_ship_utc_offset
    expected_date = (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%d/%b/%Y')
    actual_date_time = retrieve_text(CHECKLIST[:created_on])
    raise 'verify check list time failed' unless actual_date_time.include? expected_date
  end

  def wait_util_text_update(element, text_to_update)
    wait = 0
    until element.text != text_to_update
      sleep 0.5
      wait += 1
      break if wait > 5
    end
  end
end
