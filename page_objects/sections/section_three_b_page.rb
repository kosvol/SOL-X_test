# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/api/users_api'

# SectionThreeBPage object
class SectionThreeBPage < BasePage
  include EnvUtils
  SECTION_THREE_B = {
    section_header: "//h3[contains(.,'Section 3B: DRA - Checks & Measures')]",
    save_next_btn: "//button[contains(.,'Save & Next')]",
    previous_btn: "//button[contains(.,'Previous')]",
    work_inspect_answer: '//*[@name="inspectionCarriedOut" and @value="%s"]',
    work_inspect_by_btn: "//button[@id='workInspectionBy']",
    ddl_options: '//*[@class="option-text"]',
    method_desc: "(//p[starts-with(@class,'AnswerComponent__Answer-')])[1]",
    dra_sent: '//*[@name="sentForReview" and @value="%s"]/following-sibling::span',
    dra_sent_answer: "(//p[starts-with(@class,'AnswerComponent__Answer-')])[2]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_THREE_B[:section_header])
  end

  def answer_work_site_inspection(answer)
    @driver.find_element(:xpath, SECTION_THREE_B[:work_inspect_answer] % answer).click
  end

  def verify_work_site_answer(option)
    if option == 'should'
      verify_inspect_crew_list
    else
      verify_element_not_exist(SECTION_THREE_B[:work_inspect_by_btn])
    end
  end

  def verify_method_description(expected)
    actual_description = retrieve_text(SECTION_THREE_B[:method_desc])
    compare_string(expected, actual_description)
  end

  def answer_dra_is_sent(answer)
    scroll_click(SECTION_THREE_B[:dra_sent] % answer)
  end

  def verify_dra_been_sent(expected)
    if expected == 'should'
      find_element(SECTION_THREE_B[:dra_sent_answer])
    else
      verify_element_not_exist(SECTION_THREE_B[:dra_sent_answer])
    end
  end

  private

  def gen_ddl_option(users)
    "#{users['crewMember']['rank']} #{users['crewMember']['firstName']} #{users['crewMember']['lastName']}"
  end

  def verify_inspect_crew_list
    click(SECTION_THREE_B[:work_inspect_by_btn])
    sleep 1
    options = find_elements(SECTION_THREE_B[:ddl_options])
    user_list = UsersApi.new.request
    user_list['data']['users'].each_with_index do |users, index|
      expected_option = gen_ddl_option(users)
      compare_string(expected_option, options[index].text)
    end
  end
end
