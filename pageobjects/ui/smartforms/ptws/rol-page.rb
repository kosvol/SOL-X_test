# frozen_string_literal: true

require './././support/env'

class ROLPage < Section9Page
  include PageObject

  button(:rol_duration, xpath: '//button[@id="permitValidDuration"]')
  buttons(:boarding_ddl, xpath: '//button[@id="cl_riggingOfLadder_boardingArrangement"]')
  buttons(:boarding_value, xpath: '//ul/li/button')
  element(:foot_note, xpath: '//div[@id="SECTION_4A_RIGGING_OF_LADDER_19"]')
  elements(:rol_inputs, xpath: '//input')
  button(:current_date, xpath: "//button[contains(@class,'current')]")
  buttons(:date_and_time_fields, xpath: "//button[@id='cl_riggingOfLadder_createdDate']")
  buttons(:issued_date_and_time_fields, xpath: "//button[@id='cl_riggingOfLadder_permitIssuedOnDate']")
  buttons(:valid_until_date_and_time_fields, xpath: "//button[@id='cl_riggingOfLadder_permitValidUntil']")
  buttons(:submit_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div[2]/button")
  button(:updates_needed_btn, xpath: "//button[contains(.,'Updates Needed')]")
  @@duration = "//button[contains(.,'%s')]"

  def fill_rol_forms
    rol_inputs_elements.first.send_keys("Test Automation")
    rol_inputs_elements[1].click
    work_side_inspected_by
    sleep 1
    member_name_btn_elements.first.click
    confirm_btn_elements.last.click
    rol_inputs_elements[4].click
    rol_inputs_elements[7].click
    last_assessment_date_element.click
    sleep 1
    current_date
    sleep 1
    last_assessment_element.send_keys("Test Automation")
    rol_inputs_elements[11].click
    rol_inputs_elements[14].click
    rol_inputs_elements[17].click
    rol_inputs_elements[20].click
    rol_inputs_elements[22].click
    rol_inputs_elements[24].click
  end

  def fill_rol_checklist
    boarding_ddl_elements.first.click
    sleep 1
    boarding_value_elements.first.click
    
    tmp = 0
    (0..((radio_btn_elements.size / 3) - 1)).each do |_i|
      radio_btn_elements[0 + tmp].click
      # on(Section3DPage).radio_btn_elements[[0 + tmp, 1 + tmp, 2 + tmp].sample].click
      tmp += 3
    end
    
  end

  def select_rol_duration(_duration)
    BrowserActions.scroll_down(rol_duration_element)
    sleep 1
    rol_duration
    sleep 1
    scroll_multiple_times(2)
    sleep 1
    tmp_hour = @browser.find_element('xpath', @@duration % ["#{_duration+ " hour"}"])
    tmp_hour.click
    BrowserActions.scroll_down(tmp_hour)
    sleep 1
  end

  def submit_rol_permit_w_duration(_duration)
    select_rol_duration(_duration)
    submit_btn_elements.first.click
  end

  def is_duration?(permit_validity_timer, _duration, _timer_mins="59")
    if permit_validity_timer.include? ":#{_timer_mins}:"
      return permit_validity_timer.include? "0#{(_duration.to_i-1)}:#{_timer_mins}:"# if _duration === '1'
    else
      is_duration?(permit_validity_timer, _duration, (_timer_mins.to_i-1))
    end
  end
end
