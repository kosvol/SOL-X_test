# frozen_string_literal: true

require_relative 'base_page'

# ShipLocalTimePage object
class ShipLocalTimePage < BasePage
  include EnvUtils

  SHIPTIME = {
    ship_time: "//span[contains(.,'Adjusted Time')]/following::*[1]",
    ship_utc: "//span[contains(.,'Set UTC')]/following::*[1]",
    ship_date: "//time[starts-with(@class,'VesselDate__DateText')]",
    sign: "//ul[starts-with(@aria-label,'sign-picker')]/li[@class='selected']",
    hour: "//ul[starts-with(@aria-label,'hour-picker')]/li[@class='selected']",
    min: "//ul[starts-with(@aria-label,'minute-picker')]/li[@class='selected']",
    cancel_btn: "//button[span = 'Cancel']",
    confirm_btn: "//button[span = 'Confirm']"

  }.freeze

  def receive_utc_by_api(value)
    TimeApi.new.update_ship_utc(value)
  end

  def click_confirm_btn
    click(SHIPTIME[:confirm_btn])
  end

  def click_cancel_btn
    click(SHIPTIME[:cancel_btn])
  end

  def compare_time
    ship_time = retrieve_ship_time
    time_now = Time.now.utc.strftime('%H:%M')
    if ship_time == time_now
      puts 'Time on ship is equal to Time now'
    else
      raise ArgumentError,
            'Time on ship is NOT equal to Time now'
    end
  end

  def update_sign_to_value(sign)
    utc = retrieve_ship_utc
    if  sign == '-' && utc[0, 1] != sign
      move_picker(SHIPTIME[:sign], 0, 50)
      sleep 1
    elsif sign == '+' && utc[0, 1] != sign
      move_picker(SHIPTIME[:sign], 0, -50)
    end
  end

  def update_hour_to_value(hour)
    ship_hour = retrieve_ship_utc[1, 2]
    while ship_hour.to_s != hour
      if ship_hour < hour
        move_picker(SHIPTIME[:hour], 0, -50)
        ship_hour = retrieve_ship_utc[1, 2]
      elsif ship_hour > hour
        move_picker(SHIPTIME[:hour], 0, 50)
        ship_hour = retrieve_ship_utc[1, 2]
      end
    end
  end

  def update_min_to_value(min)
    minute = retrieve_ship_utc[3, 4].delete('\\:')
    while minute != min
      if minute < min
        move_picker(SHIPTIME[:min], 0, -50)
        minute = retrieve_ship_utc[3, 4].delete('\\:')
      elsif minute > min
        move_picker(SHIPTIME[:min], 0, 50)
        minute = retrieve_ship_utc[3, 4].delete('\\:')
      end
    end
  end

  private

  def retrieve_ship_time
    retrieve_text(SHIPTIME[:ship_time])
  end

  def retrieve_ship_utc
    retrieve_text(SHIPTIME[:ship_utc])
  end

  def move_picker(element, x_offset, y_offset)
    sleep 1
    el = @driver.find_element(:xpath, element)
    @driver.action.click_and_hold(el).perform
    @driver.action.move_by(x_offset, y_offset).perform
    @driver.action.release.perform
  end
end
