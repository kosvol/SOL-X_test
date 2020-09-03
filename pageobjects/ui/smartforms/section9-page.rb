# frozen_string_literal: true

require './././support/env'

class Section9Page < Section8Page
  include PageObject

  buttons(:permit_terminated_on_date, xpath: "//button[@id='permitTerminationOn']")
  divs(:rank_name_and_date, xpath: "//div[starts-with(@class,'Cell__Content-')]/div")
  element(:task_status_completed, xpath: "//input[@value = 'Completed']")
  buttons(:submit_termination_btn, xpath: "//button[contains(.,'Submit For Termination')]")

  def get_signed_date_time
    BrowserActions.scroll_down(rank_and_name_stamp)
    sleep 1
    set_current_time
    time_offset = get_current_time_format
    "#{get_current_date_format} #{time_offset}"
  end

  def is_termination_date_time_filled?
    set_current_time
    (get_current_time_format === permit_terminated_on_date_elements.last.text) && (get_current_date_format_with_offset === permit_terminated_on_date_elements.first.text)
  end
end
