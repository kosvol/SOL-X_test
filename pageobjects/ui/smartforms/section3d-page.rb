# frozen_string_literal: true

require './././support/env'

class Section3DPage < Section3BPage
  include PageObject

  element(:signing_canvas, xpath: '//canvas[@data-testid="signature-canvas"]')
  button(:sign_btn, xpath: "//div[@class='buttons']/button[2]")

  def sign
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
    sleep 1
    sign_btn
  end
end
