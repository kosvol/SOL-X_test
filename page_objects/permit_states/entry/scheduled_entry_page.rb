# frozen_string_literal: true

require_relative '../base_permit_states_page'

# ScheduledEntryPage object
class ScheduledEntryPage < BasePermitStatesPage
  SCHEDULED_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    view_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View')]",
    first_delete_btn: "(//button[contains(.,'Delete')])[1]"
  }.freeze

  def initialize(driver)
    super
    find_element(SCHEDULED_ENTRY[:page_header])
  end

  def click_view_btn(permit_id)
    permit_xpath = SCHEDULED_ENTRY[:view_terminate_btn] % permit_id
    click(permit_xpath)
  end

  def delete_first_permit(permit_id)
    permit_xpath = SCHEDULED_ENTRY[:first_delete_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def verify_deleted_permit(permit_id)
    verify_element_not_exist("//span[text()='#{permit_id}']")
  end
end
