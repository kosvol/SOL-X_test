# frozen_string_literal: true

require './././support/env'

class PendingStatePage < CreatedPermitToWorkPage
  include PageObject

  buttons(:master_review_btn, xpath: "//button[contains(.,'Master Review')]")
  button(:submit_for_oa_btn, xpath: "//button[contains(.,'Submit for Office Approval')]")

  def set_section1_filled_data
    # probably need to dynamic this created by
    @@section1_data_collector << 'Submitted By A/M Atif Hayat at'
    sleep 1
    @@section1_data_collector << "#{get_current_date_format} #{get_current_time_format}"
    p ">>> #{@@section1_data_collector}"
    @@section1_data_collector
  end

  def get_button_text
    edit_permit_btn_elements.first.text
  end
end
