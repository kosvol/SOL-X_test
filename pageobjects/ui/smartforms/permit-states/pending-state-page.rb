# frozen_string_literal: true

require './././support/env'

class PendingStatePage < Section9Page
  include PageObject

  buttons(:master_review_btn, xpath: "//button[contains(.,'Master Review')]")
  buttons(:master_approval_btn, xpath: "//button[contains(.,'Master Approval')]")
  buttons(:submit_for_oa_btn, xpath: "//button[contains(.,'Submit for Office Approval')]")
  buttons(:submit_for_master_approval_btn, xpath: "//button[contains(.,\"Submit for Master's Approval\")]")
  buttons(:edit_update_btn, xpath: "//button[contains(.,'Edit/Update')]")
  buttons(:submit_master_review_btn, xpath: "//button[contains(.,\"Submit for Master's Review\")]")
  element(:update_comment_box, id: 'updatesNeededComment')
  
  def set_update_comment
    request_update_btn
    sleep 1
    BrowserActions.enter_text(update_comment_box_element,"Test Automation")
    submit_update_btn
  end

  def set_section1_filled_data
    # probably need to dynamic this created by
    @@section1_data_collector << 'Submitted By A/M Atif Hayat at'
    sleep 1
    @@section1_data_collector << "#{get_current_date_format_with_offset} #{get_current_time_format}"
    p ">>> #{@@section1_data_collector}"
    @@section1_data_collector
  end

  def get_button_text
    edit_permit_btn_elements.first.text
  end
end
