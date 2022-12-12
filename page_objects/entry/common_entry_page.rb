# frozen_string_literal: true

require_relative '../base_page'

# common entry permit object
class CommonEntryPage < BasePage
  include EnvUtils

  # attr_accessor :permit_id, :permit_duration, :temp_id, :permit_index, :issue_time_date, :selected_date

  COMMON_ENTRY = {
    heading_text: "//*[@id='root']/div/nav/header",
    add_gas_reader_button: '//button[span="Add Gas Reader Details & Test Records"]',
    updates_needed_btn: '//button[span="Updates Needed"]',
    comment_text_area: '//*[@name="updatesNeededComment"]',
    submit_comment_btn: '//button[span="Submit"]',
    comment_title: "(//h2[contains(@class,'Heading__H2')])[1]",
    comment_text: "(//p[contains(@class,'AnswerComponent__Answer')])[1]",
    submit_approval_btn: '//button[span="Submit for Approval"]',
    close_btn: '//button[span="Close"]',
    header_temp_id: '(//p[starts-with(@class, "AnswerComponent__Answer")])[last()]',
    resp_of_signature: "//h2[contains(.,'Responsible Officer Signature:')]",
    resp_of_sig_rank: "//h3[contains(.,'Rank/Name')]",
    validation_pop: '//div[starts-with(@class, "ValidationModal__Content")]',
    approve_activation_btn: "//button[span='Approve for Activation']"
  }.freeze

  def initialize(driver)
    super
    find_element(COMMON_ENTRY[:heading_text])
  end

  def click_add_gas_reader
    click(COMMON_ENTRY[:add_gas_reader_button])
  end

  def click_updates_needed
    scroll_click(COMMON_ENTRY[:updates_needed_btn])
  end

  def submit_comment(text)
    enter_text(COMMON_ENTRY[:comment_text_area], text)
    click(COMMON_ENTRY[:submit_comment_btn])
  end

  def verify_comment(expected_text)
    compare_string('Comments from Approving Authority', retrieve_text(COMMON_ENTRY[:comment_title]))
    compare_string(expected_text, retrieve_text(COMMON_ENTRY[:comment_text]))
  end

  def verify_non_auth_view
    verify_element_not_exist(COMMON_ENTRY[:submit_approval_btn])
    verify_element_not_exist(COMMON_ENTRY[:updates_needed_btn])
    raise 'Close button is disabled' unless find_element(COMMON_ENTRY[:close_btn]).enabled?
  end

  def retrieve_temp_id
    retrieve_text(COMMON_ENTRY[:header_temp_id])
  end

  def check_ra_signature(rank, location)
    compare_string(retrieve_text(COMMON_ENTRY[:resp_of_signature]), 'Responsible Officer Signature:')
    compare_string(retrieve_text(COMMON_ENTRY[:resp_of_sig_rank]), 'Rank/Name')
    find_element("//*[contains(.,'#{rank}')]")
    find_element("//*[contains(.,'#{location}')]")
  end

  def verify_no_add_gas_btn
    verify_element_not_exist(COMMON_ENTRY[:add_gas_reader_button])
  end

  def verify_validation
    find_element(COMMON_ENTRY[:validation_pop])
  end

  def click_submit_approval
    click(COMMON_ENTRY[:submit_approval_btn])
  end

  def click_approve_for_activation
    scroll_click(COMMON_ENTRY[:approve_activation_btn])
  end

  def verify_comment_btn
    enter_text(COMMON_ENTRY[:comment_text_area], 'Test Automation')
    find_element(COMMON_ENTRY[:submit_comment_btn])
  end

  def verify_add_gas_btn
    find_element(COMMON_ENTRY[:add_gas_reader_button])
  end
end
