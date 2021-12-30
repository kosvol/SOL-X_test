# frozen_string_literal: true

require_relative '../base_page'

# CreatedEntryPage object
class CreatedEntryPage < BasePage
  include EnvUtils
  CREATED_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    first_edit_btn: "(//button[contains(., 'Edit')])[1]",
    delete_btn: "//button[contains(.,'Delete')]",
    parent_container: "//ul[starts-with(@class,'FormsList__Container')]/li",
    ptw_id: 'header > h1',
    ptw_number: "//ul[starts-with(@class,'FormsList__Container')]/li/span"
  }.freeze

  def initialize(driver)
    super
    find_element(CREATED_ENTRY[:page_header])
  end

  def click_first_permit
    click(CREATED_ENTRY[:first_edit_btn])
  end

  def delete_current_permit
    click(CREATED_ENTRY[:delete_btn])
  end

  def verify_deleted_permit(permit_id)
    find_elements(CREATED_ENTRY[:parent_container]).each_with_index do |_permit, index|
      p(find_element("//ul[starts-with(@class,'FormsList__Container')]/li#{[index + 1]}/span").text)
      raise 'Verification failed' if find_element(
        "//ul[starts-with(@class,'FormsList__Container')]/li#{[index + 1]}/span"
      ).text == permit_id
      break if index > 10
    end
  end
end
