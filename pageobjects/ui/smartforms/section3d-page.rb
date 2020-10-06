# frozen_string_literal: true

require './././support/env'

class Section3DPage < Section3CPage
  include PageObject

  element(:signing_canvas, xpath: '//canvas[@data-testid="signature-canvas"]')
  element(:signature, xpath: "//div[@class='signature']/img")

  def sign
    sign_for_gas
    sleep 1
    done_btn
  end

  def sign_for_gas
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
  end
end
