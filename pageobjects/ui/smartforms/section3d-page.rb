# frozen_string_literal: true

require './././support/env'

class Section3DPage < Section3CPage
  include PageObject

  element(:signing_canvas, xpath: '//canvas[@data-testid="signature-canvas"]')

  def sign
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
    sleep 1
    done_btn
  end
end
