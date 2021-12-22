# frozen_string_literal: true

require_relative '../base_page'

# CreatedPTWPage object
class CreatedPTWPage < BasePage
  include EnvUtils
  CREATED_PTW = {
    page_header: "//h1[contains(.,'Created Permits to Work')]",
    first_edit_btn: "(//button[contains(., 'Edit')])[1]",
    delete_btn: "//button[contains(.,'Delete')]",
    parent_container: "//ul[starts-with(@class,'FormsList__Container')]/li",
    ptw_id: 'header > h1'
  }.freeze

  def initialize(driver)
    super
    find_element(CREATED_PTW[:page_header])
  end

  def click_first_permit
    click(CREATED_PTW[:first_edit_btn])
  end

  def delete_current_permit
    click(CREATED_PTW[:delete_btn])
  end

  def verify_deleted_permit
    find_elements(CREATED_PTW[:parent_container]).each_with_index do |_permit, index|
      raise 'Verification failed' unless @driver.find_elements(:css, CREATED_PTW[:ptw_id])[index]
                                                .text == CreateEntryPermitPage.permit_id
    end
  end
end
