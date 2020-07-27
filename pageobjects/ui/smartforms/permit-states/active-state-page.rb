# frozen_string_literal: true

require './././support/env'

class ActiveStatePage < CreatedPermitToWorkPage
  include PageObject

  spans(:permit_validity_timer, xpath: "//span[@data-testid='time-left']")

  def get_permit_validity_period(_index)
    permit_validity_timer_elements[_index].text
  end

  def get_termination_btn(_permit_id)
    parent_container_elements.each_with_index do |_permit, _index|
      next unless ptw_id_elements[_index].text === _permit_id

      p ">> #{ptw_id_elements[_index].text}"
      return delete_permit_btn_elements[_index]
      # break
    end
  end
end
