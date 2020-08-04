# frozen_string_literal: true

require './././support/env'

class Section3DPage < Section3CPage
  include PageObject

  element(:signing_canvas, xpath: '//canvas[@data-testid="signature-canvas"]')
  button(:sign_btn, xpath: "//div[@class='buttons']/button[2]")
  button(:sign_btn1, xpath: "//div[starts-with(@class,'ResponsibilityBox__ButtonContainer')]/button[2]")

  def get_filled_section3d
    tmp = []
    filled_data = $browser.find_elements(:xpath, '//input')
    filled_data.each_with_index do |_data, index|
      tmp << filled_data[index].attribute('value')
    end
    tmp
  end

  def sign
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
    sleep 1
    begin
      sign_btn
    rescue StandardError
      sign_btn1
    end
  end
end
