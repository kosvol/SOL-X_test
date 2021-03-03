# frozen_string_literal: true

require './././support/env'

class OfficePortalPage
  include PageObject

  button(:op_login_btn, xpath: "//button[contains(@class,'LoginButton')]")
  button(:home_btn, xpath: "//nav[contains(@class,'NavigationBar')]//button")
  button(:all_permits_btn, xpath: "//span[contains(text(),'All Permits')]/parent::button")
  button(:view_permit_btn, xpath: "//span[contains(text(),'View Selected Permit')]/parent::button")
  button(:add_filter_btn, xpath: "//span[contains(text(),'Add Filter')]/parent::button")
  button(:print_permit_btn, xpath: "//span[contains(text(),'Print Permit')]/parent::button")

  element(:topbar_header, xpath: "//nav[contains(@class,'NavigationBar')]//h3")
  element(:portal_name, xpath: "//h1[contains(@class,'Heading__HeadingLarge')]")
  element(:warning_message_text, xpath: "//div[contains(text(),'Incorrect Password')]")
  element(:vessels_list_header, xpath: "//h2[contains(text(),'All Vessels')]")
  element(:permit_list, xpath: "//div[contains(@class,'PermitList__Container')]")
  element(:permit_list_cross_btn, xpath: "//div[contains(@class,'PermitList__Header')]//a")
  element(:permits_list_name, xpath: "(//h2[contains(@class,'Heading')])[2]")
  element(:remember_box, xpath: "//span[@class='checkbox']")
  element(:bottom_bar_permits_quantity, xpath: "//span[contains(@class,'BottomBar')]/span")
  element(:permit_approved_on, xpath: "//div[contains(@class,'ApprovedTagWrapper')]")
  element(:first_permit_with_time, xpath: "(//span[contains(text(),'GMT')])[1]/parent::div")
  elements(:permit_check_box, xpath: "//span[@class='checkbox']")
  elements(:vessel_card_name, xpath: "//div[contains(@class,'VesselItem')]/h3")
  elements(:filter_permit_type, xpath: "//div[contains(@class,'PermitType__Container')]//span")
  elements(:permit_section_header, xpath: "//h2[contains(text(),'Section')]")

  checkbox(:remember_checkbox, xpath: "//input[@type='checkbox']")
  checkboxes(:permit_checkbox, xpath: "//input[@type='checkbox']")
  text_field(:op_password, xpath: "//input[@type='password']")

  def select_vessel(_vesselName)
    $browser.find_element(:xpath, "//h3[contains(text(),'%s')]"%_vesselName).click
  end

  def vessel_card_permits_quantity(_formsQuantity)
    $browser.find_element(:xpath, "//h3[contains(text(), '%s')]/parent::div/following-sibling::div//span[contains(@class,'value')]"%_formsQuantity).text
  end

  def get_permit_number(_permitNumber)
    $browser.find_element(:xpath, "//div[%s][contains(@class,'PermitItem')]/span[1]"%_permitNumber).text
  end

  def get_permit_name(_permitName)
    $browser.find_element(:xpath, "//div[%s][contains(@class,'PermitItem')]/span[2]"%_permitName).text
  end

  def get_approved_date_time
    $browser.find_element(:xpath, "//h4[contains(text(),'Date/Time:')]/following-sibling::p").text
  end
end