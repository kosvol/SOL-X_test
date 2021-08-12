# frozen_string_literal: true

require './././support/env'

class CreatedPermitToWorkPage < Section9Page
  include PageObject

  elements(:parent_container, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li")
  spans(:ptw_id, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/span")
  spans(:created_by, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div/span[1]")
  spans(:created_date_time, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[1]/span[2]")
  spans(:issued_date_time, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[2]/span[2]")
  buttons(:delete_permit_btn, xpath: "//button[contains(.,'Delete')]")
  buttons(:edit_permit_btn, xpath: "//button[contains(.,'Edit')]")

  def is_created_permit_deleted?
    parent_container_elements.each_with_index do |_permit, _index|
      if ptw_id_elements[_index].text === CommonPage.get_permit_id
        return false
      end
    end
    true
  end

  # def delete_created_permit
  #   # parent_container_elements.each_with_index do |_permit, _index|
  #   # if ptw_id_elements[_index].text === get_section1_filled_data[1]
  #   delete_permit_btn_elements.first.click
  #   # end
  #   # end
  # end

  def select_created_permit_with_param(_permit_id)
    sleep 1
    edit_permit_btn_elements[get_permit_index(_permit_id)]
  end

  def get_permit_index(permit_id)
    @tmp_index = nil
    sleep 1
    parent_container_elements.each_with_index do |permit, index|
      next unless ptw_id_elements[index].text === permit_id
      Log.instance.info "Permit ID: #{ptw_id_elements[index].text} ::: #{permit_id}"
      Log.instance.info "Index: #{index}"
      @tmp_index = index
      break
    end
    @tmp_index
  end
end
