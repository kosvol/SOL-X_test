# frozen_string_literal: true

require_relative '../base_page'

# Work with permit
class PermitActionsPage < CreateEntryPermitPage
  include EnvUtils

  PERMIT_ACTIONS = {
    heading_text: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3",
    terminate_btn: "//button[contains(.,'Terminate')]",
    request_update_btn: "//button[contains(.,'Request Updates')]",
    comment_box: '//textarea',
    submit_update_btn: "//button[contains(.,'Submit')]",
    edit_update_btn: "//button[contains(.,'Edit/Update')]",
    parent_container: "//ul[starts-with(@class,'FormsList__Container')]/li",
    submit_for_approval_btn: "//button[contains(.,'Submit For Approval')]",
    ptw_id: 'header > h1',
    view_btn: "//button[contains(.,'View')]",
    issued_time_date: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[2]/span[2]",
    update_btn: "//button[contains(.,'Updates Needed')]",
    close_btn: "//button[contains(.,'Close')]",
    purpose_of_entry: "//textarea[@id='reasonForEntry']",
  }.freeze

  def initialize(driver)
    super
    find_element(PERMIT_ACTIONS[:heading_text])
  end

  def terminate_permit
    click("//span[contains(text(),'#{permit_number}')]//following::span[contains(text(),'Submit for Termination')][1]")
  end

  def click_terminate_button
    click(PERMIT_ACTIONS[:terminate_btn])
  end

  def request_for_update
    click(PERMIT_ACTIONS[:request_for_update])
    enter_text(PERMIT_ACTIONS[:request_for_update], 'Test Automation')
    find_elements(PERMIT_ACTIONS[:submit_update_btn]).last.click
  end

  def click_edit_update
    click(PERMIT_ACTIONS[:edit_update_btn])
  end

  def click_edit_btn
    click("//span[contains(text(),'#{permit_number}')]//following::span[contains(text(),'Edit')][1]")
  end

  def click_submit_for_approval
    click(PERMIT_ACTIONS[:submit_for_approval_btn])
  end

  def open_ptw_for_view
    permit_index = retrieve_permit_index(permit_id)
    find_elements(PERMIT_ACTIONS[:view_btn])[permit_index].click
  end

  def save_time_date_ptw
    permit_index = retrieve_permit_index(permit_id)
    self.issue_time_date = find_elements(PERMIT_ACTIONS[:issued_time_date])[permit_index].text
  end

  def verify_buttons_not_ro
    verify_element_not_exist(PERMIT_ACTIONS[:submit_for_approval_btn])
    verify_element_not_exist(PERMIT_ACTIONS[:update_btn])
    raise 'Element disabled' unless find_element(PERMIT_ACTIONS[:close_btn]).enabled?
  end

  def click_close_button
    click(PERMIT_ACTIONS[:close_btn])
  end

  def verify_button_disabled(text)
    raise 'Element enabled' unless find_element("//*[contains(.,'#{text}')]").enabled?.eql?(false)
  end

  def verify_button_enabled(text)
    raise 'Element disabled' unless find_element("//*[contains(.,'#{text}')]").enabled?
  end

  def verify_purpose_of_entry(text)
    raise 'Verify failed' unless PERMIT_ACTIONS[:purpose_of_entry].text.eql?(text)
  end

  private

  def retrieve_permit_index(permit_id)
    permit_index = nil
    find_elements(PERMIT_ACTIONS[:parent_container]).each_with_index do |_permit, index|
      next unless @driver.find_elements(:css, PERMIT_ACTIONS[:ptw_id])[index].text == permit_id

      permit_index = index
      break
    end
    permit_index
  end

end
