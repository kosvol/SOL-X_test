# frozen_string_literal: true

require './././support/env'

class ROLPage < Section7Page
  include PageObject

  button(:rol_duration, xpath: '//button[@id="cl_riggingOfLadder_permitValidDuration"]')
  buttons(:durations, xpath: "//div[@data-testid='dropdown-overlay-container']/div/ul[starts-with(@class,'UnorderedList-sc-')]/li/button")

  def submit_rol_permit_w_duration(_duration)
    BrowserActions.scroll_down(rol_duration_element)
    rol_duration
    durations_elements[(_duration.to_i - 1)].click
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
