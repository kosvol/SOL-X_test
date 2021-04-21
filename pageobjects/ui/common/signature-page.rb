# frozen_string_literal: true

require './././support/env'

class SignaturePage < Section1Page
  include PageObject

  element(:signing_canvas, xpath: '//canvas[@data-testid="signature-canvas"]')
  element(:signature, xpath: "//div[@class='signature']/img")

  def sign_and_done
    sleep 1
    sign_for_gas
    sleep 1
    select_location_of_work if zone_btn_element.text === "Select"
    BrowserActions.poll_exists_and_click(done_btn_elements.first)
  end

  def sign_for_gas
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
  end

  def is_signature_pad?
    signature_element
    true
  rescue StandardError
    false
  end
end
