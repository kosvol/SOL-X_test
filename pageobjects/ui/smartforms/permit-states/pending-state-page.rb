# frozen_string_literal: true

require './././support/env'

class PendingStatePage < Section9Page
  include PageObject

  buttons(:master_review_btn, xpath: "//button[contains(.,'Master Review')]")
  buttons(:master_approval_btn, xpath: "//button[contains(.,'Master Approval')]")
  buttons(:office_approval_btn, xpath: "//button[contains(.,'Office Approval')]")
  buttons(:edit_update_btn, xpath: "//button[contains(.,'Edit/Update')]")
  element(:update_comment_box, xpath: "//textarea[@id='updatesNeededComment']")
  elements(:action_required_note, xpath: "//li/div/div[@class='note-row']/div[2]/span[2]")
  elements(:pending_approval_status_btn, xpath: '//button[@data-testid="action-button"]')
  element(:x_btn, css: 'div[data-testid="repeat-sign-btn"]')

  def set_update_comment
    request_update_btn
    sleep 1
    BrowserActions.enter_text(update_comment_box_element, 'Test Automation')
    submit_update_btn_elements.first.click
  end
end
