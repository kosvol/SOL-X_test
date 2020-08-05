# frozen_string_literal: true

require './././support/env'

class CreatedPermitToWorkPage < SmartFormsPermissionPage
  include PageObject

  elements(:parent_container, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li")
  spans(:ptw_id, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/span")
  spans(:created_by, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div/span[1]")
  spans(:created_date_time, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[1]/span[2]")
  spans(:issued_date_time, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[2]/span[2]")
  buttons(:edit_permit_btn, xpath: '//button[@data-testid="action-button"]')
  buttons(:delete_permit_btn, xpath: "//ul[@class='note-row']/li[@class='button-container'][2]/button")

  def is_created_permit_deleted?
    parent_container_elements.each_with_index do |_permit, _index|
      if ptw_id_elements[_index].text === get_section1_filled_data[1]
        return false
      else
        return true
      end
    end
  end

  def delete_created_permit
    parent_container_elements.each_with_index do |_permit, _index|
      if ptw_id_elements[_index].text === get_section1_filled_data[1]
        return delete_permit_btn_elements[_index]
      end
    end
  end

  def select_created_permit_with_param(_permit_id)
    edit_permit_btn_elements[get_permit_index(_permit_id)]
  end

  def get_permit_index(_permit_id)
    parent_container_elements.each_with_index do |_permit, _index|
      next unless ptw_id_elements[_index].text === _permit_id

      p ">> #{ptw_id_elements[_index].text}"
      return _index
      # break
    end
  end
end
