# frozen_string_literal: true

require './././support/env'

class NewEntrantPage
  include PageObject

  element(:main_clock, xpath: "//h3[@data-testid='main-clock']")
  element(:back_arrow, xpath: "//button/*[@data-testid='arrow']")
  element(:shield_icon, xpath: "//img/*[@data-testid='shield-icon']")
  element(:title_permit, xpath: "//class[contains(.,'Permit Activated')]")
  element(:permit_valid_until, xpath: "//class[contains(.,'Permit Valid Until')]")
  element(:valid_until_date, xpath: "//div[starts-with(@class,'PermitValidUntil__ValidUntilDate')]")
  element(:valid_title, xpath: "//div[starts-with(@class,'PermitValidUntil__TextSmall')]")
  element(:valid_text_subtitle, xpath: "//div[starts-with(@class,'PermitValidUntil__BoldText')]")
  element(:valid_header_text, xpath: "//div[starts-with(@class,'PermitValidUntil__SecondaryHeaderText')]")
  element(:valid_, xpath: "//div[starts-with(@class,'PermitValidUntil__BoldText')]")
  element(:enclosed_space, xpath: "//class[contains(.,'Enclosed Space')]")
  element(:en_workshop, xpath: "//div[starts-with(@class,'ActivePermitDetails__TextWhite')]")
  element(:new_entry_bn, xpath: "//span[contains(text(),'New Entry')]")
  button(:home_button, xpath: "//button[contains(.,'Home')]")
  element(:entry_log_btn, xpath: "//*[starts-with(@class,'TabNavigator__TabItem')][2]/a/span")

end
