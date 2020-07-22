# frozen_string_literal: true

require './././support/env'

class ActiveStatePage < CreatedPermitToWorkPage
  include PageObject

  def get_on_termination_btn(_permit_id)
    parent_container_elements.each_with_index do |_permit, _index|
      next unless ptw_id_elements[_index].text === _permit_id

      p ">> #{ptw_id_elements[_index].text}"
      return delete_permit_btn_elements[_index]
      # break
    end
  end
end
