# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/utils/user_service'

# SectionEightPage object
class SectionEightPage < BasePage
  include EnvUtils
  SECTION_EIGHT = {
    section_header: "//h3[contains(.,'Section 8: Task Status & EIC Normalisation')]",
    termination_btn: "//button[contains(., 'Submit For Termination')]",
    task_commenced_at_date: "(//button[@id='taskCommencedAt'])[1]",
    task_commenced_at_time: "(//button[@id='taskCommencedAt'])[2]",
    competent_sign_btn: "(//button[contains(., 'Enter PIN & Sign')])[1]",
    issuing_sign_btn: "(//button[contains(., 'Enter PIN & Sign')])[2]",
    location_stamp: "(//*[starts-with(@class,'AnswerComponent__Answer')])[1]",
    rank_name: "(//*[starts-with(@class, 'Cell__Description')])[1]",
    task_status: '//*[@name="taskStatus" and @value="%s"]'
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_EIGHT[:section_header])
  end

  def verify_termination_btn(option)
    verify_btn_availability(SECTION_EIGHT[:termination_btn], option)
  end

  def verify_ra_signature_is_hidden
    verify_element_not_exist(SECTION_EIGHT[:termination_btn])
    verify_element_not_exist("//*[span='Responsible Authority:']")
  end

  def verify_commenced_time(issued_time)
    raise 'date verify failed' unless issued_time.include? retrieve_text(SECTION_EIGHT[:task_commenced_at_date])
    raise 'time verify failed' unless issued_time.include? retrieve_text(SECTION_EIGHT[:task_commenced_at_time])
  end

  def verify_extra_question(question_type, eic)
    sleep 1 # wait for the page load
    page_span = retrieve_page_span
    extra_questions = YAML.load_file('data/section8-questions.yml')[question_type]['questions']
    verify_general_question(extra_questions, page_span)
    eic_questions = YAML.load_file('data/section8-questions.yml')[question_type]['eic']
    verify_eic_questions(eic_questions, page_span, eic)
  end

  def click_termination_btn
    scroll_click(SECTION_EIGHT[:termination_btn])
  end

  def click_sign_btn(type)
    sleep 1 # wait for the page load
    case type
    when 'Issuing Authorized'
      scroll_click(SECTION_EIGHT[:issuing_sign_btn])
    when 'Competent Person'
      scroll_click(SECTION_EIGHT[:competent_sign_btn])
    else
      raise "#{type} not implemented"
    end
  end

  def verify_signed_detail(table)
    params = table.hashes.first
    expected_rank_name = UserService.new.retrieve_rank_and_name(params['rank'])
    actual_element = find_element(SECTION_EIGHT[:rank_name])
    wait_until_text_update(actual_element, 'Not Answered') # wait for location update
    compare_string(expected_rank_name, actual_element.text)
    compare_string(params['location_stamp'], retrieve_text(SECTION_EIGHT[:location_stamp]))
  end

  def answer_task_status(task_status)
    scroll_times_direction(1, 'down')
    scroll_click(SECTION_EIGHT[:task_status] % task_status)
  end

  private

  def retrieve_page_span
    result = []
    span_elements = find_elements('//div/span')
    span_elements.each do |element|
      result.append(element.text)
    end
    result
  end

  def verify_general_question(extra_questions, page_span)
    extra_questions.each do |questions|
      raise "question verify failed: expected #{page_span}, actual: #{questions}" unless page_span.include? questions
    end
  end

  def verify_eic_questions(eic_questions, page_span, eic)
    eic_questions.each do |questions|
      if eic == 'yes'
        raise 'eic questions verify wrong' unless page_span.include? questions
      elsif page_span.include? questions
        raise "eic question #{questions} should not appear"
      end
    end
  end
end
