# frozen_string_literal: true

require './././support/env'

class Section7Page < Section6Page
  include PageObject

  buttons(:non_oa_buttons, xpath: "//form[starts-with(@class,'FormComponent__Form-')]//button")
  button(:submit_oa_btn, xpath: "//button[contains(.,'Submit for Office Approval')]")
  button(:update_btn, xpath: "//button[contains(.,'Updates Needed')]")
  button(:activate_permit_btn, xpath: "//button[contains(.,'Activate Permit To Work')]")
  elements(:permit_issued_on, xpath: "//div[starts-with(@class,'Section__Description')]/div[starts-with(@class,'ViewGenericAnswer__')]")
  elements(:permit_valid_until, xpath: "//div[starts-with(@class,'Section__Description')]/div[starts-with(@class,'ViewGenericAnswer__')]")
  
  def get_validity_until(_offset_hours)
    tmp = (Time.parse(@@issue_time_date)+((60*60)*_offset_hours))
    return "#{tmp.strftime("%d/%b/%Y %H:%M")} #{@@issue_time_date[18,29]}"
  end

  def activate_permit
    set_current_time
    reset_data_collector
    @@created_permit_data = set_section1_filled_data
  end
end
