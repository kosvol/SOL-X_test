# frozen_string_literal: true

require './././features/support/env'

class Section9Page < Section8Page
  include PageObject

  buttons(:permit_terminated_on_date, xpath: "//button[@id='permitTerminationOn']")
  divs(:rank_name_and_date, xpath: "//div[starts-with(@class,'Cell__Content-')]/div")
  element(:task_status_completed, xpath: "//input[@value = 'Completed']")
  button(:submit_permit_termination_btn, xpath: "//button[contains(.,'Withdraw Permit To Work')]")

  def get_signed_date_time
    BrowserActions.scroll_down(rank_and_name_stamp)
    sleep 1
    set_current_time
    time_offset = ret_current_time_format
    "#{ret_current_date_format_with_offset} #{time_offset}"
  end

  def termintn_date_time_filled?
    (ret_current_time_format == permit_terminated_on_date_elements.last.text) &&
      (ret_current_date_format_with_offset == permit_terminated_on_date_elements.first.text)
  end
end
