require './././support/env'

class ShipLocalTimePage
  include PageObject

  button(:clock_btn,xpath: "//button[starts-with(@class,'Clock__ClockButton')]")
  element(:clock,xpath: "//button[starts-with(@class,'Clock__ClockButton')]/h3")
  span(:utc_time,xpath: "//span[@data-testid='utc-time']")
  span(:utc_time_text,xpath: "//span[@data-testid='label-id']")
  spans(:utc_timezone,xpath: "//span[starts-with(@class,'ClockModal__UTCTimeText')]")
  button(:decrement,xpath: "//div[starts-with(@class,'ClockModal__')]/button[1]")
  button(:increment,xpath: "//div[starts-with(@class,'ClockModal__')]/button[2]")
  

  def is_utc_time
    # clock_btn
    # sleep 1
    return Time.now.utc.strftime("%I:%M") if Time.now.utc.strftime("%k") < "12"
    return "#{Time.now.utc.strftime("%k:%M")}" if Time.now.utc.strftime("%k") > "12"
  end

  def adjust_ship_local_time
    clock_btn
    ["1","2"].sample === "1" ? decrement : increment
  end

  def is_update_ship_time
    sleep 1
    clock_btn
    sleep 1
    tmp = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    current_time = utc_time.split(':')
    return ((utc_time_text === "Local Time #{tmp}h") && (utc_timezone_elements[1].text === "#{current_time[0].to_i+tmp}:#{current_time[1]}")) if tmp < 0
    return ((utc_time_text === "Local Time +#{tmp}h") && (utc_timezone_elements[1].text === "#{current_time[0].to_i+tmp}:#{current_time[1]}")) if tmp >= 0
  end
end