# frozen_string_literal: true

require './././support/env'

class SignaturePage < Section1Page
  include PageObject

  element(:signing_canvas, css: 'canvas[data-testid="signature-canvas"]')
  elements(:signature, xpath: 'div.signature > img')

  def sign_and_done
    sign_and_select_location
    done_btn_elements.first.click
  end

  def sign_and_select_location
    sleep 1
    sign_on_canvas
    sleep 1
    select_location_of_work if zone_btn_element.text === 'Select'
    sleep 1
  end

  def is_signature_pad?
    signature_elements.first
    true
  rescue StandardError
    false
  end

  def sign_on_canvas
    BrowserActions.poll_exists_and_click(signing_canvas_element)
    BrowserActions.poll_exists_and_click(signing_canvas_element)
  end
end
