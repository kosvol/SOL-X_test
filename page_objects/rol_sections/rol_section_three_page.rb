# frozen_string_literal: true

require_relative '../base_page'

# RoLSectionThreePage object
class RoLSectionThreePage < BasePage
  include EnvUtils
  ROL_SECTION_THREE = {
    section_header: "//h3[contains(.,'Task Status')]",
    form_answers: "//*[starts-with(@class,'AnswerComponent__Answer')]",
    headers: "//div[contains(@class,'Section__Description')]//h2",
    questions: "//div[contains(@class,'Section__Description')]/div/div/span",
    other: "//div[contains(@class,'Section__Description')]//label[contains(@for, 'bestPractice')]",
    submit_btn: "//button[contains(., 'Submit')]",
    previous_btn: "//button[contains(.,'Previous')]",
    close_btn: "//button[contains(.,'Close')]",
    task_commenced_at_date: "//button[@id='taskCommencedAt-datepicker']",
    task_commenced_at_time: "//button[@id='taskCommencedAt-timepicker']",
    termination_btn: "//button[contains(., 'Submit For Termination')]",
    withdraw_btn: "//button[contains(., 'Withdraw Permit To Work')]",
    request_updates_btn: "//button[contains(., 'Request Updates')]",
    aa_comments: '//textarea[@id="updatesNeededComment"]'
  }.freeze

  def initialize(driver)
    super
    find_element(ROL_SECTION_THREE[:section_header])
  end

  def verify_rol_section_three_data
    expected_checklist = YAML.load_file('data/sections-data/rol_section_3.yml')['questions']
    expected_checklist.each do |question|
      next if retrieve_section_items('headers').include? question
      next if retrieve_section_items('questions').include? question
      next if retrieve_section_items('other').include? question

      raise "#{question} verified failed"
    end
  end

  def verify_commenced_time(issued_time)
    raise 'date verify failed' unless issued_time.include? retrieve_text(ROL_SECTION_THREE[:task_commenced_at_date])
    raise 'time verify failed' unless issued_time.include? retrieve_text(ROL_SECTION_THREE[:task_commenced_at_time])
  end

  def verify_no_extra_btns
    verify_element_not_exist("//button[contains(.,'Save')]")
    compare_string(@driver.find_elements(xpath: ROL_SECTION_THREE[:previous_btn]).size, 1)
    compare_string(@driver.find_elements(xpath: ROL_SECTION_THREE[:close_btn]).size, 1)
  end

  def click_termination_btn
    sleep 1
    scroll_click(ROL_SECTION_THREE[:termination_btn])
  end

  def click_withdraw
    sleep 1
    scroll_click(ROL_SECTION_THREE[:withdraw_btn])
  end

  def click_request_updates_btn
    sleep 1
    scroll_click(ROL_SECTION_THREE[:request_updates_btn])
  end

  def enter_aa_comments(text)
    element = find_element(ROL_SECTION_THREE[:aa_comments])
    @driver.execute_script('arguments[0].scrollIntoView({block: "center", inline: "center"})', element)
    element.send_keys(text)
  end

  def click_submit_btn
    sleep 1
    scroll_click(ROL_SECTION_THREE[:submit_btn])
  end

  private

  def retrieve_section_items(items)
    questions = []
    elements = @driver.find_elements(:xpath, ROL_SECTION_THREE[:"#{items.to_sym}"])
    elements.each do |element|
      questions << element.text
    end
    questions
  end
end
