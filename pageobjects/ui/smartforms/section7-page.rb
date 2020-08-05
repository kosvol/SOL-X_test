# frozen_string_literal: true

require './././support/env'

class Section7Page < Section6Page
  include PageObject

  buttons(:non_oa_buttons, xpath: "//form[starts-with(@class,'FormComponent__Form-')]//button")

  def activate_permit
    sign
    set_current_time
    reset_data_collector
    @@created_permit_data = set_section1_filled_data
  end
end
