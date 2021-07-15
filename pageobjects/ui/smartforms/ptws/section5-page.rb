# frozen_string_literal: true

require './././support/env'

class Section5Page < Section4BPage
  include PageObject

  button(:roles_and_resp_btn, xpath: "//div[starts-with(@class,'values-area')]/button")
  elements(:roles_btn, xpath: "//div[starts-with(@data-testid,'combo-box-with-buttons-sheet')]/div[2]/div/ul/li")#'//ul/li/button')
  elements(:responsibility_box, xpath: "//li[@data-testid='responsibility-box']")
  elements(:non_crew_checkbox, xpath: "//li[@data-testid='responsibility-box']/div/label/span")
  text_field(:other_name, xpath: "//input[@id='otherName']")
  text_field(:other_company, xpath: "//input[@id='otherCompany']")
  buttons(:sign_btn_role, xpath: "//button[contains(.,'Enter PIN & Sign')]")
  span(:non_crew_copy_text, xpath: "//span[contains(.,'Ship Staff to use PIN for non-crew member to enter signature')]")
  elements(:roles_name, xpath: '//li/h3')
  spans(:signed_rank_and_name, xpath: "//li[@data-testid='responsibility-box']/div/div/span")
  elements(:signed_time, xpath: "//li[@data-testid='responsibility-box']/div/div/time")
  elements(:signed_location, xpath: "//li[@data-testid='responsibility-box']/div/div/p")
  elements(:get_filled_roles_responsibility, xpath: "//ul/li[starts-with(@aria-label,'Authorized Entrant 1')]")
  elements(:get_filled_crew_details, xpath: "//div/span")
  element(:get_non_crew_date_time, xpath: "//div/time")
  
  @@list_of_roles = ['Authorized Entrant 1', 'Authorized Entrant 2', 'Authorized Entrant 3', 'Authorized Entrant 4', 'Authorized Gas Tester', 'Diving Supervisor', 'Fire Watch 1', 'Fire Watch 2', 'Responsible for Safety', 'Standby Person', 'Task Leader', 'Task Performer 1', 'Task Performer 2', 'Task Performer 3', 'Task Performer 4', 'Task Performer - Assisting for Hot Work', 'Task Performer - Carrying out Hot Work', 'Task Performer - Diver (Underwater Operation)', 'Task Performer - Working Aloft', 'Task Performer - Working Overside']

  def is_role_signed_user_details?(_which_role,_entered_pin)
    rank_and_name = get_user_details_by_pin(_entered_pin)
    Log.instance.info(">> Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}")
    Log.instance.info(">> Date & Time #{get_current_date_and_time}")
    if _which_role === "first"
      ((signed_rank_and_name_elements.first.text === "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (signed_time_elements.first.text === get_current_date_and_time.to_s))
    elsif _which_role === "second"
      ((signed_rank_and_name_elements.last.text === "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (signed_time_elements.last.text === get_current_date_and_time.to_s))
    end
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
    sleep 1
    roles_and_resp_btn
    sleep 1
    (0..(_roles.to_i - 1)).each do |i|
      roles_btn_elements[i].click
    end
    sleep 1
    confirm_btn_elements.last.click
    sleep 1
  end

  def delete_roles_and_responsibility(_total_roles)
    # roles_and_resp_btn
    # sleep 1
    cross_btn_elements[_total_roles.to_i-1].click
    # sleep 1
    # confirm_btn_elements.last.click
    # sleep 1
  end
end
