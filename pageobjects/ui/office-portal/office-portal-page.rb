# frozen_string_literal: true

require './././support/env'

class OfficePortalPage
  include PageObject

  button(:op_login_btn, xpath: "//button[contains(@class,'LoginButton')]")
  element(:topbar_header, xpath: "//nav[contains(@class,'NavigationBar')]//h3")
  element(:portal_name, xpath: "//h1[contains(@class,'Heading__HeadingLarge')]")
  element(:remember_checkbox, xpath: "//span[@class='checkbox']/::after")
  text_field(:op_password, xpath: "//input[@type='password']")
  element(:warning_message_text, xpath: "//div[contains(text(),'Incorrect Password')]")
  element(:vessels_list_header, xpath: "//h2[contains(text(),'All Vessels')]")
  button(:home_btn, xpath: "//nav[contains(@class,'NavigationBar')]//button")
  element(:permit_list, xpath: "//div[contains(@class,'PermitList__Container')]")
  element(:permit_list_cross_btn, xpath: "//div[contains(@class,'PermitList__Header')]//a")
  element(:permits_list_name, xpath: "(//h2[contains(@class,'Heading')])[2]")
  button(:all_permits_btn, xpath: "//span[contains(text(),'All Permits')]/parent::button")

  def select_vessel(_vesselName)
    $browser.find_element(:xpath, "//h3[contains(text(),'%s')]"%_vesselName).click
  end

  def vessel_card_permits_number(_formNumber)
    $browser.find_element(:xpath, "//h3[contains(text(), '%s')]/parent::div/following-sibling::div//span[contains(@class,'value')]"%_formNumber).text
  end
end