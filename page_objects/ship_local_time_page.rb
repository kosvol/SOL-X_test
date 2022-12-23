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

  def retrieve_ship_time
    retrieve_text(SHIPTIME[:ship_time])
  end

  def retrieve_ship_utc
    retrieve_text(SHIPTIME[:ship_utc])
  end

  def click_confirm_btn
    click(SHIPTIME[:confirm_btn])
  end

  def click_cancel_btn
    click(SHIPTIME[:cancel_btn])
  end

  def time_comparing
    ship_time = retrieve_ship_time
    time_now = Time.now.utc.strftime('%H:%M')
    if ship_time == time_now
      puts "Time on ship is equal to Time now #{ship_time} = #{time_now}"
    else
      raise ArgumentError,
            "Time on ship is NOT equal to Time now #{ship_time} != #{time_now}"
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

  def time_offset_comparing
    ship_time = retrieve_ship_time
    time_now = Time.new.utc.new_offset('-02:30').strftime('%H:%M')
    puts" ship#{ship_time} now#{time_now}"
  end

  #DRAFT
  #
  def get_ship_time
    puts TimeService.new.retrieve_ship_time
    puts TimeService.new.retrieve_ship_utc_offset
  end

  def get_utc_off
    offset = TimeApi.new.request_ship_local_time['data']['currentTime']['utcOffset']
    puts offset
  end
  # def retrieve_ship_date
  #   retrieve_text(SHIPTIME[:ship_date]).scan(/\d+/).first.to_i
  # end

  def time_ship_executing
    hour = retrieve_ship_time[0, 2]
    minute = retrieve_ship_time[3, 4]
    utc = retrieve_ship_utc
    t_ship = Time.new(1111, 11, 11, hour, minute, 11, utc).strftime('%H:%M')
    # t_ship_utc = t_ship - t_ship.gmt_offset
    # t_ship_utc.strftime('%H:%M')
  end



  # def get_utc_api(duration)
  #   TimeService.new.set_default_ship_time(duration)
  # end

  def set_utc_default
    hour = retrieve_ship_utc[1, 2]
    min = retrieve_ship_utc[4, 5]
    while hour != '00'
      (move_picker(SHIPTIME[:hour], 0, +50))
      hour = retrieve_ship_utc[1, 2]
      puts hour
    end
    while min != '00'
      min = retrieve_ship_utc[4, 5]
      (move_picker(SHIPTIME[:min], 0, +50))
      puts min
    end
  end

  def set_utc_min
    el = @driver.find_element(:xpath, SHIPTIME[:sign])
    @driver.action.click_and_hold(el).perform
    @driver.action.move_by(0, -50).perform
    @driver.action.release.perform
    el2 = @driver.find_element(:xpath, SHIPTIME[:hour])
    @driver.action.click_and_hold(el2).perform
    @driver.action.move_by(0, -50).perform
    @driver.action.release.perform
  end

  private

  def move_picker(element, x_offset, y_offset)
    sleep 1
    el = @driver.find_element(:xpath, element)
    @driver.action.click_and_hold(el).perform
    @driver.action.move_by(x_offset, y_offset).perform
    @driver.action.release.perform
  end
end
