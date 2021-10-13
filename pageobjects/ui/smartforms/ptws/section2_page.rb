# frozen_string_literal: true

require './././support/env'

class Section2Page < Section1Page
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  div(:maintenance_text, xpath: "//div[@id='2_subsection4']")
end
