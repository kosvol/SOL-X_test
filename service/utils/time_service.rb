# frozen_string_literal: true

require_relative '../api/time_api'

# service for time
class TimeService
  def retrieve_current_date_time
    Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end

  def retrieve_current_date
    Time.now.utc.strftime('%Y-%m-%dT12:00:00.000Z')
  end

  def retrieve_ship_time
    epoch_time = TimeApi.new.request_ship_local_time['data']['currentTime']['secondsSinceEpoch']
    utc_offset = retrieve_ship_utc_offset
    Time.at(epoch_time).utc.to_datetime.new_offset(utc_offset.to_s).strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end

  def retrieve_ship_utc_offset
    offset = TimeApi.new.request_ship_local_time['data']['currentTime']['utcOffset']
    offset.nil? ? 0 : offset
  end

  def retrieve_time_cal_hours(hours)
    (Time.now + (60 * 60 * hours.to_i)).utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
  end

  def retrieve_time_cal_minutes(minutes)
    (Time.now + (60 * minutes.to_i)).utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
  end

  def retrieve_ship_time_hh_mm
    epoch_time = TimeApi.new.request_ship_local_time['data']['currentTime']['secondsSinceEpoch']
    utc = retrieve_ship_utc_offset
    if utc >= 30
      utc *= 60
    elsif utc < 30
      utc = utc * 60 * 60
    end
    ship_time_sec = epoch_time + utc
    Time.at(ship_time_sec).utc.to_datetime.strftime('%H:%M')
  end
end
