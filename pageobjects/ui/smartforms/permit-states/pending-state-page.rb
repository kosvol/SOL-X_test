# frozen_string_literal: true

require './././support/env'

class PendingStatePage < CreatedPermitToWorkPage
  include PageObject

  def get_button_text
    edit_permit_btn_elements.first.text
  end
end
