# frozen_string_literal: true

require_relative '../../base_page'
require_relative '../../../service/utils/index_db_utils'

# CreatedEntryPage object
class CreatedEntryPage < BasePage
  include EnvUtils
  include IndexDBUtils

  CREATED_ENTRY = {
    page_header: "//h1[contains(.,'Created')]",
    edit_btn: "//*[span='%s']/*[@class='note-row']/button",
    first_edit_btn: "(//button[contains(., 'Edit')])[1]",
    first_delete_btn: "(//button[contains(.,'Delete')])[1]",
    first_permit_id: "(//ul[starts-with(@class,'FormsList__FormsListContainer')]/li/span)[1]"
  }.freeze

  def initialize(driver)
    super
    find_element(CREATED_ENTRY[:page_header])
  end

  def delete_first_permit
    click(CREATED_ENTRY[:first_delete_btn])
  end

  def verify_deleted_permit(permit_id)
    verify_element_not_exist("//*[text()='#{permit_id}']")
  end

  def verify_temp_permit(temp_id)
    permit_id = retrieve_id_by_temp(temp_id)
    find_element(CREATED_ENTRY[:edit_btn] % permit_id)
  end

  def save_first_permit_id
    retrieve_text(CREATED_ENTRY[:first_permit_id])
  end

  def click_first_permit
    click(CREATED_ENTRY[:first_edit_btn])
  end
end
