# frozen_string_literal: true

require './././support/env'

class Section3DPage < Section3CPage
  include PageObject

  # element(:signing_canvas, xpath: '//canvas[@data-testid="signature-canvas"]')
  # element(:signature, xpath: "//div[@class='signature']/img")

  # def sign
  #   sleep 1
  #   sign_for_gas
  #   BrowserActions.poll_exists_and_click(done_btn_elements.first)
  # end

  # def sign_for_gas
  #   tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
  #   $browser.action.click(tmp).perform
  # end
end
