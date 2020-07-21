# frozen_string_literal: true

require './././support/env'

class Section7Page < Section6Page
  include PageObject

  buttons(:non_oa_buttons, xpath: "//form[starts-with(@class,'FormComponent__Form-')]//button")
end
