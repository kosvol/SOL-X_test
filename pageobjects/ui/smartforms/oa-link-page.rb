# frozen_string_literal: true

require './././support/env'
require 'date'

class OAPage < Section9Page
  include PageObject

  button(:approve_permit_btn, xpath: "//button[contains(.,'Approve This Permit')]")
  button(:add_comments_btn, xpath: "//button[contains(.,'Add Comments')]")
  button(:add_comments_btn1, xpath: "//button[contains(.,'Add/Show Comments (1)')]")
  button(:send_comments_btn, xpath: "//button[contains(.,'Send')]")
  element(:submit_permit_approval_btn, xpath: "//input[contains(@value,'Approve this Permit to Work')]")
  element(:issue_to_time_btn, id: 'issuedToTime')
  element(:issue_to_date_btn, id: 'issuedToDate')
  element(:hours_23_btn, id: 'issuedToTime__hourTimePicker__23')
  element(:comment_counter, xpath: "//div[starts-with(@class,'CommentsPanel__Container-')]/header/h3")
  element(:comment_box, xpath: "//section[starts-with(@class,'messages')]/p")
  # element(:enter_comment_box, xpath: "//textarea")
  text_field(:name_box, id: 'user-name')
  button(:rank_dd_list, id: 'rank')
  element(:comments, xpath: "//li[contains(@data-testid,'comment-message')]")
  @@comment_base = "QAHSSE Manager
  Test Automation
  %s %s (GMT+0)
  Test Automation"
  
  def navigate_to_oa_link
    sleep 400
    $browser.get(OfficeApproval.get_office_approval_link(CommonPage.get_permit_id, 'VS', 'VS Automation').to_s)
  end

  def set_to_time
    BrowserActions.scroll_click(issue_to_time_btn_element)
    BrowserActions.scroll_click(hours_23_btn_element)
  end

  def set_to_date_plus_one_day(_current_date)
    BrowserActions.enter_text(issue_to_date_btn_element,"#{(Date.today+1).strftime("%d/%m/%Y")}")
  end

  def is_comment_box_reset?
    (comment_counter_element.text === "Comments (0)" && comment_box_element.text === "This Permit has no comments")
  end

  def set_comment
    BrowserActions.enter_text(enter_comment_box_element,"Test Automation")
    BrowserActions.enter_text(name_box_element,"Test Automation")
    sleep 1
    rank_dd_list
    sleep 1
    list_permit_type_elements.last.click
    sleep 1
    send_comments_btn
    sleep 1
    comment_counter_element.text === "Comments (1)"
    # tmp = @@comment_base % [get_current_date_format_with_offset, get_current_time_format_with_offset(0)]
    # p tmp
    # comments_element.text === tmp
  end

  private 
  
  def add_instruction
    false
  end

  def set_designation
    false
  end
  
end
