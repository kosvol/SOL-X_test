# frozen_string_literal: true

require './././support/env'

class Section3DPage
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  element(:signing_canvas, xpath: '//canvas[@data-testid="signature-canvas"]')
  button(:sign_btn, xpath: "//div[@class='buttons']/button[2]")

  def sign
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
    sleep 1
    sign_btn
  end
end
