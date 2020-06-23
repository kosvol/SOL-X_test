# frozen_string_literal: true

require './././support/env'

class Section2Page
  include PageObject

  element(:heading_text, xpath: "//form[starts-with(@class,'FormFactory__Form')]/section/h2")
end
