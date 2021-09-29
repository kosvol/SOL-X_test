# frozen_string_literal: true

require './././support/env'

class Section7Page < Section6Page
  include PageObject

  buttons(:non_oa_buttons, xpath: "//form[starts-with(@class,'FormComponent__Form-')]//button")
  button(:submit_oa_btn, xpath: "//button[contains(.,'Submit for Office Approval')]")
  button(:update_btn, xpath: "//button[contains(.,'Updates Needed')]")
  button(:request_update_btn, xpath: "//button[contains(.,'Request Updates')]")
  button(:activate_permit_btn, xpath: "//button[contains(.,'Activate Permit To Work')]")
  elements(:permit_issued_on,
           xpath: "//div[starts-with(@class,'Section__Description')]/div[starts-with(@class,'ViewGenericAnswer__')]")
  elements(:permit_valid_until,
           xpath: "//div[starts-with(@class,'Section__Description')]/div[starts-with(@class,'ViewGenericAnswer__')]")
  element(:oa_description, xpath: "//p[contains(@class, 'ViewFormSection__Description')]")
  element(:additional_instruction,
          xpath: "//div[@class='screen-only']//h4[contains(text(),'Additional Instruction')]/following-sibling::p")
  element(:issued_from_date, xpath: "//h4[contains(text(),'Issued From')]/following-sibling::p")
  element(:issued_to_date, xpath: "//h4[contains(text(),'To')]/following-sibling::p")
  element(:valid_until_date_7b, xpath: "//h4[contains(text(),'valid until')]/following-sibling::p")
  element(:approver_name,
          xpath: '//div[@class="screen-only"]//h4[contains(text(),"Authority\'s Name:")]/following-sibling::p')
  element(:approver_designation,
          xpath: "//div[@class='screen-only']//h4[contains(text(),'Designation')]/following-sibling::p")

  def get_validity_until(_offset_hours)
    tmp = (Time.parse(@@issue_time_date) + ((60 * 60) * _offset_hours))
    "#{tmp.strftime('%d/%b/%Y %H:%M')} #{@@issue_time_date[18, 29]}"
  end

  def oa_from_to_time_with_offset(_approve_time, _time_offset, _hours, _mins)
    time = Time.new(_approve_time.year, _approve_time.mon, _approve_time.day, _hours, _mins, 0, 0)
    time_ship = convert_time_to_ship(time, _time_offset)
    p time_ship.to_s
    time_ship
  end

  def permit_valid_until_with_offset(_approve_time, _time_offset, _shift_hours)
    time_to = Time.new(_approve_time.year, _approve_time.mon, _approve_time.day,
                       (_approve_time.hour.to_i + _shift_hours), 0, 0, 0)
    valid_to_date = convert_time_to_ship(time_to, _time_offset)
    p valid_to_date.to_s
    valid_to_date
  end

  def convert_time_to_ship(_time, _offset)
    if _offset.to_s[0] != '-'
      (_time + (60 * 60 * _offset)).strftime("%d/%b/%Y %H:%M LT (GMT+#{_offset})")
    else
      (_time + (60 * 60 * _offset)).strftime("%d/%b/%Y %H:%M LT (GMT#{_offset})")
    end
  end

  def activate_permit
    set_current_time
    reset_data_collector
    set_section1_filled_data(CommonPage.get_entered_pin, 'Submitted By')
  end
end
