# frozen_string_literal: true

require './././support/env'
require 'date'

class OAPage < Section4BPage
  include PageObject

  button(:approve_permit_btn, xpath: "//button[contains(.,'Approve This Permit')]")
  button(:add_comments_btn, xpath: "//button[contains(.,'Add Comments')]")
  element(:submit_permit_approval_btn, xpath: "//input[contains(@value,'Approve this Permit to Work')]")
  element(:issue_to_time_btn, id: 'issuedToTime')
  element(:issue_to_date_btn, id: 'issuedToDate')
  element(:hours_23_btn, id: 'issuedToTime__hourTimePicker__23')

  def set_to_time
    BrowserActions.scroll_click(issue_to_time_btn_element)
    BrowserActions.scroll_click(hours_23_btn_element)
  end

  def set_to_date_plus_one_day(_current_date)
    BrowserActions.enter_text(issue_to_date_btn_element,"#{((Date.strptime("15/09/2020","%d/%m/%Y").to_date)+1).strftime("%d/%m/%Y")}")
  end

  private 
  
  def add_instruction
    false
  end

  def set_from_time
    false
  end

  def set_designation
    false
  end
  
end
