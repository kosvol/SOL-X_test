# frozen_string_literal: true

require_relative '../base_page'

# TerminatedEntryPage object
class TerminatedEntryPage < BasePage
  TERMINATED_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    view_btn: "//button[contains(.,'View')]"
  }.freeze


  def initialize(driver)
    super
    find_element(TERMINATED_ENTRY[:page_header])
  end

  def open_ptw_for_view
    permit_index = retrieve_permit_index(CreateEntryPermitPage.permit_id)
    find_elements(TERMINATED_ENTRY[:view_btn])[permit_index].click
  end

end