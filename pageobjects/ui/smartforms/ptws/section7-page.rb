# frozen_string_literal: true

require './././support/env'

class Section7Page < Section6Page
  include PageObject

  buttons(:non_oa_buttons, xpath: "//form[starts-with(@class,'FormComponent__Form-')]//button")
  button(:submit_oa_btn, xpath: "//button[contains(.,'Submit for Office Approval')]")
  button(:update_btn, xpath: "//button[contains(.,'Updates Needed')]")
  button(:activate_permit_btn, xpath: "//button[contains(.,'Activate Permit To Work')]")

  def activate_permit
    set_current_time
    reset_data_collector
    @@created_permit_data = set_section1_filled_data
  end
end
