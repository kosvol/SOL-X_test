# frozen_string_literal: true

require './././support/env'

class SignaturePage < Section1Page
  include PageObject

  element(:signing_canvas, css: 'canvas[data-testid="signature-canvas"]')
  element(:signature, xpath: 'div.signature > img')

  def sign_and_done
    sleep 1
    sign_for_gas
    sleep 1
    select_location_of_work if zone_btn_element.text === 'Select'
    sleep 1
    done_btn_elements.first.click
  end

  def is_signature_pad?
    signature_element
    true
  rescue StandardError
    false
  end

  def sign_for_gas
    # tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    # sleep 1
    BrowserActions.poll_exists_and_click(signing_canvas_element)
    BrowserActions.poll_exists_and_click(signing_canvas_element)
    # signing_canvas_element.click
    # signing_canvas_element.click
    # $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]').click
    # $browser.action.click(tmp).perform
  end
end
