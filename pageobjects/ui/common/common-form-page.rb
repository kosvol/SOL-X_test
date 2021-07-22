# frozen_string_literal: true

require './././support/env'

class CommonFormsPage < CommonPage
  include PageObject
  
  element(:main_clock, xpath: "//h3[@data-testid='main-clock']")
  element(:back_arrow, xpath: "//button/*[@data-testid='arrow']")
  elements(:generic_data, xpath: "//*[starts-with(@class,'AnswerComponent__Answer')]")
  element(:enter_comment_box, xpath: '//textarea')
  elements(:enter_comment_boxes, xpath: '//textarea')
  buttons(:current_day, xpath: "//button[contains(@class,'Day__DayButton')]")
  element(:form_navigation_bar, xpath: "//nav[contains(@class, 'SectionControl')]")
  element(:is_dashboard_screen, xpath: "//h2[contains(.,'Crew Finder')]")

  ### Wifi
  elements(:wifi_popup_smartform, xpath: "//div[starts-with(@class,'OfflineInfoCard__')]")
  element(:wifi_restore_popup, xpath: "//h3[contains(.,'Wi-Fi restored')]")

  ### buttons by text ###
  button(:calendar_next_month, xpath: "//button[contains(@data-testid,'calendar-next-month')]")
  element(:no_permits_found, xpath: "//h3[contains(.,'No permits found.')]")
  button(:enter_pin_btn, xpath: "//button[contains(.,'Enter Pin')]")
  buttons(:sign_btn, xpath: "//button[contains(.,'Sign')]")
  button(:back_btn, xpath: "//button[contains(.,'Back')]")
  button(:cancel_btn, xpath: "//button[contains(.,'Cancel')]")
  button(:clear_btn, xpath: "//button[contains(.,'Clear')]")
  buttons(:done_btn, xpath: "//button[contains(.,'Done')]")
  buttons(:previous_btn, xpath: "//button[contains(.,'Previous')]")
  buttons(:close_btn, xpath: "//button[contains(.,'Close')]")
  buttons(:confirm_btn, xpath: "//button[contains(.,'Confirm')]")
  buttons(:submit_termination_btn, xpath: "//button[contains(.,'Submit For Termination')]")
  buttons(:update_reading_btn, xpath: "//button[contains(.,'Update Readings')]")
  button(:back_to_home_btn, xpath: "//button[contains(.,'Back to Home')]")
  buttons(:submit_update_btn, xpath: "//button[contains(.,'Submit')]")
  buttons(:save_and_close_btn, xpath: "//button[contains(.,'Save & Close')]")
  buttons(:save_btn, xpath: "//button[contains(.,'Save')]")
  buttons(:view_btn, xpath: "//button[contains(.,'View')]")
  buttons(:review_and_terminate_btn, xpath: "//button[contains(.,'Review & Withdraw')]")
  button(:request_update_btn, xpath: "//button[contains(.,'Request Updates')]")
  buttons(:submit_for_master_approval_btn, xpath: "//button[contains(.,\"Submit for Master's Approval\")]")
  buttons(:submit_master_review_btn, xpath: "//button[contains(.,\"Submit for Master's Review\")]")

  @@text_obj = "//*[contains(.,'%s')]"
  
  def select_todays_date_from_calendar(advance_days=0)
    begin
      current_day_elements.each_with_index do |_element,_index|
        if _element.attribute('class').include? 'current'
          BrowserActions.js_click("//button[contains(@class,'Day__DayButton')][(#{_index}+#{advance_days})+1]")
          break
        end
      end
    rescue StandardError
      calendar_next_month
      sleep 1
      BrowserActions.js_clicks("//button[contains(.,'01')]","1")
      sleep 1
    end
  end

  def scroll_multiple_times(times)
    (1..times).each do |_i|
      BrowserActions.scroll_down
      sleep 1
    end
  end

  def set_current_time
    @@time = main_clock_element.text
  end

  def get_current_time
    @@time
  end

  def get_current_time_format
      "#{@@time}#{get_timezone}"
  end

  def move_date_time_by_1_minute
    move = DateTime.strptime(@@time, '%H:%M') + Rational(1, 840)
    "#{move.strftime('%H:%M')}#{get_timezone}"
  end

  def move_date_time_by_minus_1_minute
    move = DateTime.strptime(@@time, '%H:%M') - Rational(1, 1540)
    "#{move.strftime('%H:%M')}#{get_timezone}"
  end

  def get_current_date_and_time_minus_a_min
    "#{get_current_date_format_with_offset} #{move_date_time_by_minus_1_minute}"
  end

  def get_current_date_and_time_add_a_min
    "#{get_current_date_format_with_offset} #{move_date_time_by_1_minute}"
  end

  def get_current_date_and_time
    "#{get_current_date_format_with_offset} #{get_current_time_format}"
  end

  def get_current_hour
    time_offset = get_current_time_offset
    (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%H')
  end

  def get_current_date_format_with_offset
    time_offset = get_current_time_offset
    (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%d/%b/%Y')
  end

  def get_current_time_offset
    @which_json = 'ship-local-time/base-get-current-time'
    ServiceUtil.post_graph_ql(@which_json, '1111')
    ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
  end

  def get_timezone
    @@time_offset = get_current_time_offset
    if @@time_offset.to_s[0] != "-"
      " LT (GMT+#{@@time_offset})"
    else
      " LT (GMT#{@@time_offset})"
    end
  end

  def match_screen_labels(_data_arr)
    _data_arr.each do |_element|
      begin
        @browser.find_element(:xpath, "//span[contains(., \"#{_element.text}\")]")
      rescue StandardError
        begin 
          @browser.find_element(:xpath, "//label[contains(., \"#{_element.text}\")]")
        rescue StandardError
          begin
            @browser.find_element(:xpath, "//p[contains(., \"#{_element.text}\")]")
          rescue
            begin
              @browser.find_element(:xpath, "//h4[contains(., \"#{_element.text}\")]")
            rescue
              @browser.find_element(:xpath, "//button[contains(., \"#{_element.text}\")]")
            end
          end
        end
      end
    end
  end
end
