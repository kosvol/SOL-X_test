# frozen_string_literal: true

require './././support/env'

class Section8Page < Section7Page
  include PageObject

  divs(:rank_name_and_date, xpath: "//div[starts-with(@class,'Cell__Content-')]/div")
  element(:task_status_completed, xpath: "//input[@value = 'Completed']")
  buttons(:submit_termination_btn, xpath: "//button[contains(.,'Submit For Termination')]")

  def get_signed_date_time
    BrowserActions.scroll_down(rank_and_name_stamp)
    sleep 1
    time_offset = get_current_time_format
    "#{get_current_date_format} #{time_offset}"
  end
end
