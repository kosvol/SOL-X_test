# frozen_string_literal: true

require_relative '../base_permit_states_page'

# CreatedPTWPage object
class CreatedPTWPage < BasePermitStatesPage
  include EnvUtils
  CREATED_PTW = {
    page_header: "//h1[contains(.,'Created Permits to Work')]",
    first_edit_btn: "(//button[contains(., 'Edit')])[1]",
    first_delete_btn: "(//button[contains(., 'Delete')])[1]",
    first_permit_id: "(//*[starts-with(@class,'Text__TextSmall')])[1]",
    edit_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Edit')]"
  }.freeze

  def initialize(driver)
    super
    find_element(CREATED_PTW[:page_header])
  end

  def click_first_permit
    click(CREATED_PTW[:first_edit_btn])
  end

  def delete_first_permit
    click(CREATED_PTW[:first_delete_btn])
  end

  def save_first_permit_id
    retrieve_text(CREATED_PTW[:first_permit_id])
  end

  def click_edit_btn(permit_id)
    permit_xpath = CREATED_PTW[:edit_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def verify_permit_is_deleted(permit_id)
    verify_element_not_exist("//span[text()='#{permit_id}']")
  end
end
