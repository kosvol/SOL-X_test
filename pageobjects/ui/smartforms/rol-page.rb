# frozen_string_literal: true

require './././support/env'

class ROLPage < Section9Page
  include PageObject

  button(:rol_duration, xpath: '//button[@id="cl_riggingOfLadder_permitValidDuration"]')
  buttons(:boarding_ddl, xpath: '//button[@id="cl_riggingOfLadder_boardingArrangement"]')
  buttons(:boarding_value, xpath: '//ul/li/button')
  element(:foot_note, xpath: '//div[@id="SECTION_4A_RIGGING_OF_LADDER_subsection19"]')
  elements(:rol_inputs, xpath: '//input')
  button(:current_date, xpath: "//button[contains(@class,'current')]")
  buttons(:date_and_time_fields, xpath: "//button[@id='cl_riggingOfLadder_createdDate']")
  buttons(:issued_date_and_time_fields, xpath: "//button[@id='cl_riggingOfLadder_permitIssuedOnDate']")
  buttons(:valid_until_date_and_time_fields, xpath: "//button[@id='cl_riggingOfLadder_permitValidUntil']")
  @@duration = "//button[contains(.,'%s')]"

  def fill_rol_forms
    rol_inputs_elements.first.send_keys("Test Automation")
    rol_inputs_elements[1].click
    work_side_inspected_by
    sleep 1
    member_name_btn_elements[44].click
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

  def submit_rol_permit_w_duration(_duration)
    BrowserActions.scroll_down(rol_duration_element)
    sleep 1
    BrowserActions.scroll_down
    sleep 1
    rol_duration
    sleep 1
    tmp_hour = @browser.find_element('xpath', @@duration % ["#{_duration+ " hour"}"])
    BrowserActions.scroll_down(tmp_hour)
    tmp_hour.click
    sleep 1
    submit_btn_elements.first.click
  end

  def is_duration?(permit_validity_timer, _duration)
    return permit_validity_timer.include?('00:59:') if _duration === '1'
    return permit_validity_timer.include?('01:59:') if _duration === '2'
    return permit_validity_timer.include?('02:59:') if _duration === '3'
    return permit_validity_timer.include?('03:59:') if _duration === '4'
    return permit_validity_timer.include?('04:59:') if _duration === '5'
    return permit_validity_timer.include?('05:59:') if _duration === '6'
    return permit_validity_timer.include?('06:59:') if _duration === '7'
    return permit_validity_timer.include?('07:59:') if _duration === '8'
  end
end
