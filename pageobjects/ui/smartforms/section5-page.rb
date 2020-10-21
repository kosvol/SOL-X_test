# frozen_string_literal: true

require './././support/env'

class Section5Page < Section4BPage
  include PageObject

  button(:roles_and_resp_btn, xpath: "//div[starts-with(@class,'values-area')]/button")
  buttons(:roles_btn, xpath: '//ul/li/button')
  elements(:responsibility_box, xpath: "//li[@data-testid='responsibility-box']")
  elements(:non_crew_checkbox, xpath: "//li[@data-testid='responsibility-box']/div/label/span")
  text_field(:other_name, xpath: "//input[@id='otherName']")
  text_field(:other_company, xpath: "//input[@id='otherCompany']")
  buttons(:sign_btn, xpath: "//button[contains(.,'Enter PIN & Sign')]")
  span(:non_crew_copy_text, xpath: "//span[contains(.,'Ship Staff to use PIN for non-crew member to enter signature')]")
  elements(:roles_name, xpath: '//li/h3')
  spans(:signed_details, xpath: "//div/span")

  @@list_of_roles = ["Authorized Entrant 1","Authorized Entrant 2","Authorized Entrant 3","Authorized Entrant 4","Authorized Gas Tester","Diving Supervisor","Fire Watch 1","Fire Watch 2","Responsible for Safety","Standby Person","Task Leader","Task Performer 1","Task Performer 2","Task Performer 3","Task Performer 4","Task Performer - Assisting for Hot Work","Task Performer - Carrying out Hot Work","Task Performer - Diver (Underwater Operation)","Task Performer - Working Aloft","Task Performer - Working Overside"]

  def is_role_signed_user_details?(_entered_pin)
    time_offset = get_current_time_format
    rank_and_name = get_user_details_by_pin(_entered_pin)
    Log.instance.info(">> Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}")
    Log.instance.info(">> Date & Time #{get_current_date_format_with_offset} #{time_offset}")
    ((signed_details_elements.first.text === "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (signed_details_elements.last.text === "#{get_current_date_format_with_offset} #{time_offset}"))
  end

  def is_list_of_roles?
    tmp_arr = []
    roles_btn_elements.each do |_element|
      tmp_arr << _element.text
    end
    tmp_arr === @@list_of_roles
  end

  def is_role?(_role)
    roles_name_elements.each do |_element|
      return true if _element.text === _role
    end
    false
  end

  def select_roles_and_responsibility(_roles)
    roles_and_resp_btn
    sleep 1
    for i in 0..(_roles.to_i-1)
      roles_btn_elements[i].click
    end
    sleep 1
    confirm_btn_elements.last.click
    sleep 1
  end

  def delete_roles_and_responsibility(_total_roles)
    roles_and_resp_btn
    sleep 1
    for i in _total_roles.to_i..((_total_roles.to_i+_total_roles.to_i)-1)
      roles_btn_elements[i].click
    end
    sleep 1
    confirm_btn_elements.last.click
    sleep 1
  end
end
