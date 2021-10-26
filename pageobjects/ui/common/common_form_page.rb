# frozen_string_literal: true

require './././features/support/env'

class CommonFormsPage < CommonPage
  include PageObject

  element(:main_clock, css: 'h3[data-testid=main-clock]')
  element(:clock, xpath: '//*[@id="permitActiveAt"]/span')
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
  buttons(:update_reading_btn, xpath: "//button[contains(.,'Update Readings')]")
  button(:back_to_home_btn, xpath: "//button[contains(.,'Back to Home')]")
  buttons(:submit_update_btn, xpath: "//button[contains(.,'Submit')]")
  buttons(:save_and_close_btn, xpath: "//button[contains(.,'Save & Close')]")
  buttons(:save_btn, xpath: "//button[contains(.,'Save')]")
  buttons(:view_btn, xpath: "//button[contains(.,'View')]")
  buttons(:submit_for_master_approval_btn, xpath: "//button[contains(.,\"Submit for Master's Approval\")]")
  buttons(:submit_master_review_btn, xpath: "//button[contains(.,\"Submit for Master's Review\")]")

  @@text_obj = "//*[contains(.,'%s')]"

  def select_todays(advance_days = 0)
    wait_until(current_day_elements)
    current_day_elements.each_with_index do |element, index|
      if element.attribute('class').include? 'current'
        @browser.find_element("//button[contains(@class,'Day__DayButton')][(#{index}+#{advance_days})+1]").click
        break
      end
    end
  rescue StandardError
    calendar_next_month
    sleep 1
    @browser.find_elements(:xpath, "//button[contains(.,'01')]")[0].click
    sleep 1
  end

  def scroll_times_direction(time, direct)
    time.times do
      BrowserActions.scroll_down if direct == 'down'
      BrowserActions.scroll_up if direct == 'up'
      sleep 3
    end
  end

  def set_current_time
    #@@time = main_clock_element.text
    @@time = clock_element.text
  end

  def return_current_time
    @@time
  end

  def ret_current_time_format
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
    "#{ret_current_date_format_with_offset} #{move_date_time_by_minus_1_minute}"
  end

  def get_current_date_and_time_add_a_min
    "#{ret_current_date_format_with_offset} #{move_date_time_by_1_minute}"
  end

  def get_current_date_and_time
    "#{ret_current_date_format_with_offset} #{ret_current_time_format}"
  end

  def return_current_hour
    time_offset = ret_current_time_offset
    (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%H')
  end

  def ret_current_date_format_with_offset
    time_offset = ret_current_time_offset
    (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%d/%b/%Y')
  end

  def ret_current_time_offset
    @which_json = 'ship-local-time/base-get-current-time'
    ServiceUtil.post_graph_ql(@which_json, '1111')
    ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
  end

  def get_timezone
    @@time_offset = ret_current_time_offset
    if @@time_offset.to_s[0] != '-'
      " LT (GMT+#{@@time_offset})"
    else
      " LT (GMT#{@@time_offset})"
    end
  end
end
