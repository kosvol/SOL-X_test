# frozen_string_literal: true

require './././support/env'

class Section3DPage < Section3CPage
  include PageObject

  divs(:rank_name_and_date, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div/div")
end
