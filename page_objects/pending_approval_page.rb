# frozen_string_literal: true

require_relative 'base_page'

# Pending Approval page object
class PendingApprovalPage < BasePage

  def click_officer_approval_btn
    xpath_str = "//span[contains(text(),#{permit_id})]//following::span[contains(text(),'Officer Approval)][1]"
    click(xpath_str)
  end
end
