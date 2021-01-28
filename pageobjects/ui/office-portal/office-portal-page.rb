# frozen_string_literal: true

require './././support/env'

class OfficePortalPage
  include PageObject

  button(:op_login_btn, xpath: "//button[contains(@class,'LoginButton')]")
  element(:topbar_header, xpath: "(//h3[contains(@class,'Heading__HeadingSmall')])[1]")
  element(:portal_name, xpath: "//h1[contains(@class,'Heading__HeadingLarge')]")
  element(:remember_checkbox, xpath: "//span[@class='checkbox']")
  text_field(:op_password, xpath: "//input[@type='password']")
  element(:warning_message_text, xpath: "//div[contains(text(),'Incorrect Password')]")
  element(:vessels_list_header, xpath: "//h2[contains(text(),'All Vessels')]")
  button(:home_btn, xpath: "//nav[contains(@class,'NavigationBar')]//header//button")
end