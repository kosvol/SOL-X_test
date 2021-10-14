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

  def retrieve_ship_utc_offset
    TimeApi.new.request_ship_local_time['data']['currentTime']['utcOffset']
  end

  def retrieve_time_cal_hours(hours)
    (Time.now + (60 * 60 * hours.to_i)).utc.strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end

  def retrieve_time_cal_minutes(minutes)
    (Time.now + (60 * minutes.to_i)).utc.strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end
end
