# frozen_string_literal: true

require './././features/support/env'

class ActiveStatePage < CreatedPermitToWorkPage
  include PageObject

  spans(:permit_validity_timer, xpath: "//span[@data-testid='time-left']")
  buttons(:view_btn, xpath: "//button[contains(.,'View')]")
  buttons(:terminate_permit_btn, xpath: "//button[contains(.,'View / Terminate')]")
  buttons(:add_gas_btn, xpath: "//button[contains(.,'Gas Test')]")
  buttons(:new_entrant_btn, xpath: "//button[contains(.,'New Entrant')]")

  def get_permit_validity_period(index)
    permit_validity_timer_elements[index].text
  end

  def get_termination_btn(permit_id)
    parent_container_elements.each_with_index do |_permit, index|
      next unless ptw_id_elements[index].text == permit_id

      p ">> #{ptw_id_elements[index].text}"
      return terminate_permit_btn_elements[index]
      # break
    end
  end
end
