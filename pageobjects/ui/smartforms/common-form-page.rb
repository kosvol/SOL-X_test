# frozen_string_literal: true

require './././support/env'

class CommonFormsPage < CommonPage
  include PageObject

  ### common locator
  elements(:labels_scrapper, xpath: "//*[local-name()='h3' or local-name()='h2' or local-name()='h4' or local-name()='label']")
  element(:main_clock, xpath: "//h3[@data-testid='main-clock']")
  element(:back_arrow, xpath: "//button/*[@data-testid='arrow']")
  elements(:generic_data, xpath: "//*[starts-with(@class,'ViewGenericAnswer__Answer')]")
  button(:enter_pin_btn, xpath: "//button[contains(.,'Enter Pin')]")
  buttons(:sign_btn, xpath: "//button[contains(.,'Sign')]")
  button(:back_btn, xpath: "//button[contains(.,'Back')]")
  button(:cancel_btn, xpath: "//button[contains(.,'Cancel')]")
  button(:clear_btn, xpath: "//button[contains(.,'Clear')]")
  button(:done_btn, xpath: "//button[contains(.,'Done')]")
  buttons(:previous_btn, xpath: "//button[contains(.,'Previous')]")
  buttons(:close_btn, xpath: "//button[contains(.,'Close')]")
  button(:save_and_next_btn, xpath: "//button[contains(.,'Save & Next')]")
  button(:next_btn, xpath: "//button[contains(.,'Next')]")
  buttons(:confirm_btn, xpath: "//button[contains(.,'Confirm')]")
  buttons(:submit_termination_btn, xpath: "//button[contains(.,'Submit For Termination')]")
  buttons(:submit_termination_btn1, xpath: "//button[contains(.,'Submit for Termination')]")
  buttons(:update_reading_btn, xpath: "//button[contains(.,'Update Readings')]")
  button(:back_to_home_btn, xpath: "//button[contains(.,'Back to Home')]")
  buttons(:submit_update_btn, xpath: "//button[contains(.,'Submit')]")
  buttons(:save_and_close_btn, xpath: "//button[contains(.,'Save & Close')]")
  buttons(:save_btn, xpath: "//button[contains(.,'Save')]")
  buttons(:review_and_terminate_btn, xpath: "//button[contains(.,'Review and Terminate')]")
  button(:request_update_btn, xpath: "//button[contains(.,'Request Updates')]")
  element(:enter_comment_box, xpath: "//textarea")
  
  def scroll_multiple_times(times)
    for i in 1..times do
      BrowserActions.scroll_down
      sleep 1
    end
  end
  
  def click_next
    next_btn
  rescue StandardError
    save_and_next_btn
  end
  
  def set_current_time
    @@time = main_clock_element.text
  end

  def get_current_time_format
    @which_json = 'ship-local-time/base-get-current-time'
    ServiceUtil.post_graph_ql(@which_json, '1111')
    @@time_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    "#{@@time} LT (GMT+#{@@time_offset})"
  end

  def get_current_date_format
    Time.new.strftime('%d/%b/%Y')
  end

  def get_current_date_format_with_offset
    which_json = 'ship-local-time/base-get-current-time'
    ServiceUtil.post_graph_ql(which_json, '1111')
    time_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%d/%b/%Y')
  end

  def get_current_time_format_with_offset(_offset)
    # which_json = 'ship-local-time/base-get-current-time'
    # ServiceUtil.post_graph_ql(which_json, '1111')
    # time_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    (Time.now + (60 * 60 * _offset)).strftime('%H:%M')
    # (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%H:%M')
  end

  def get_total_steps_to_section6(_which_section)
    case _which_section
    when '6'
      10
    when '7'
      11
    when '4a'
      6
    when '3a'
      2
    when '3b'
      3
    when '3c'
      4
    when '3d'
      5
    when '4b'
      8
    when '5'
      9
    when '2'
      1
    end
  end

end