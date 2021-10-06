# frozen_string_literal: true

require './././support/env'

class ShipLocalTimePage
  include PageObject

  element(:clock_btn, xpath: "//section/div[starts-with(@class,'Clock__ClockContainer')]")
  element(:clock, xpath: "//button[starts-with(@class,'Clock__ClockButton')]/h3")
  span(:utc_time, xpath: "//span[@data-testid='utc-time']")
  span(:utc_time_text, xpath: "//span[@data-testid='label-id']")
  spans(:utc_timezone, xpath: "//span[starts-with(@class,'ClockModal__UTCTimeText')]")
  button(:decrement, xpath: "//div[starts-with(@class,'ClockModal__')]/button[1]")
  button(:increment, xpath: "//div[starts-with(@class,'ClockModal__')]/button[2]")

  def is_utc_time
    if (Time.now.utc.strftime('%k').to_i < 12) && Time.now.utc.strftime('%k').to_i.positive?
      Time.now.utc.strftime('%I:%M')
    elsif Time.now.utc.strftime('%k').to_i >= 12
      Time.now.utc.strftime('%H:%M')
    end
  end

  def adjust_ship_local_time
    clock_btn_element.click
    sleep 1
    %w[1 2].sample == '1' ? decrement : increment
  end

  def is_update_ship_time
    sleep 1
    clock_btn_element.click
    sleep 1
    get_current_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    Log.instance.info(utc_timezone_elements[1].text)
    Log.instance.info("#{cal_new_offset_time(get_current_offset)}:#{@current_time[1]}")
    ((utc_time_text == get_new_current_offset_text(get_current_offset)) && (utc_timezone_elements[1].text == "#{cal_new_offset_time(get_current_offset)}:#{@current_time[1]}"))
  end

  private

  def get_new_current_offset_text(get_current_offset)
    get_current_offset.negative? ? "Local Time #{get_current_offset}h" : "Local Time +#{get_current_offset}h"
  end

  def cal_new_offset_time(get_current_offset)
    @current_time = utc_time.split(':')
    time_w_offset = @current_time[0].to_i + get_current_offset
    count_hour = if time_w_offset >= 24
                   (time_w_offset - 24).abs
                 else
                   time_w_offset
                 end
    count_hour.to_s.size == 2 ? count_hour.to_s : "0#{count_hour}"
  end
end
