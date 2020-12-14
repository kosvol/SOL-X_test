# frozen_string_literal: true

require './././support/env'
require 'date'

class OAPage < Section9Page
  include PageObject

  
  element(:xxx, xpath: "//label[contains(.,'Your comments to the ship')]")
  button(:approve_permit_btn, xpath: "//button[contains(.,'Approve This Permit')]")
  button(:update_permit_btn, xpath: "//button[contains(.,'Request Updates')]")
  element(:update_comments, xpath: "//textarea[contains(@id,'comment')]")
  button(:add_comments_btn, xpath: "//button[contains(.,'Add Comments')]")
  button(:add_comments_btn1, xpath: "//button[contains(.,'Add/Show Comments (1)')]")
  button(:send_comments_btn, xpath: "//button[contains(.,'Send')]")
  button(:submit_permit_approval_btn, xpath: "//button[contains(.,'Approve This Permit to Work')]")
  elements(:date_time_from, id: 'date-from')
  elements(:date_time_to, id: 'date-to')
  elements(:to_date_calender, xpath: "//button[starts-with(@class,'Day__DayButton-')]")
  button(:designation, id: 'designation')
  button(:set_vs_designation, xpath: "//button[contains(.,'VS')]")
  elements(:yes_to_checkbox, xpath: "//input[starts-with(@value,'yes')]")
  list_items(:hour_from_picker, xpath: "//div[starts-with(@class,'picker')][1]/ul/li")
  list_items(:minute_from_picker, xpath: "//div[starts-with(@class,'picker')][2]/ul/li")

  element(:dismiss_picker, xpath: "//div[starts-with(@class,'TimePicker__OverlayContainer-')]")

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
    sleep 10
    tmp = OfficeApproval.get_office_approval_link(CommonPage.get_permit_id, 'VS', 'VS Automation').to_s
    p "OA Link : #{tmp}"
    $browser.get(tmp)
  end

  def set_from_to_details
    sleep 1
    BrowserActions.scroll_down(date_time_from_elements[0])
    ### set from time
    date_time_from_elements[1].click
    hour_from_picker_elements[0].click
    minute_from_picker_elements[1].click
    ### set to time
    dismiss_picker_element.click
    date_time_to_elements[1].click
    hour_from_picker_elements[23].click
    minute_from_picker_elements[59].click
    dismiss_picker_element.click
    date_time_to_elements[0].click

    sleep 1
    p ">> #{current_day_elements.size}"
    select_todays_date_from_calendar(2)
    # current_day_elements.each_with_index do |_element,_index|
    #   next if !_element.attribute('class').include? 'current'
    #   next if !_element.attribute('class').include? 'current'
    #     p ">> #{_index+1}"
    #     current_day_elements[_index+1].click
    #     break
    # end
  end

  def set_to_date_plus_one_day(_current_date)
    BrowserActions.enter_text(issue_to_date_btn_element, (Date.today + 1).strftime('%d/%m/%Y').to_s)
  end

  def is_comment_box_reset?
    (comment_counter_element.text === 'Comments (0)' && comment_box_element.text === 'This Permit has no comments')
  end

  def set_comment
    BrowserActions.enter_text(enter_comment_box_element, 'Test Automation')
    BrowserActions.enter_text(name_box_element, 'Test Automation')
    sleep 1
    rank_dd_list
    sleep 1
    list_permit_type_elements.last.click
    sleep 1
    send_comments_btn
    sleep 1
    comment_counter_element.text === 'Comments (1)'
    # tmp = @@comment_base % [get_current_date_format_with_offset, get_current_time_format_with_offset(0)]
    # p tmp
    # comments_element.text === tmp
  end

  def select_yes_on_checkbox
    sleep 1
    yes_to_checkbox_elements.each(&:click)
  end

  def set_designation
    designation
    sleep 1
    set_vs_designation
  end

  private

  def add_instruction
    false
  end
end
