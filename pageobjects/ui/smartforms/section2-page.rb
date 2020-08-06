# frozen_string_literal: true

require './././support/env'

class Section2Page < Section1Page
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  # text_field(:ship_approval, xpath: '//input[@id="shipsApproval"]')
  # text_field(:office_approval, xpath: '//input[@id="officeApproval"]')
  div(:maintenance_text, xpath: "//div[@id='2_subsection4']")
end
