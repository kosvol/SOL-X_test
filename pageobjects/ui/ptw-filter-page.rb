# frozen_string_literal: true

require './././support/env'

class PtwFilterPage
  include PageObject

  span(:pending_approval, xpath: "//span[@data-testid='pendingApproval-stat']")
  span(:pending_update, xpath: "//span[@data-testid='updatesNeeded-stat']")
  span(:active, xpath: "//span[@data-testid='active-stat']")
  span(:pending_termination, xpath: "//span[@data-testid='pendingTermination-stat']")

  def click_create_permit_btn
    form_stats_response = ServiceUtil.get_response_body['data']['smartFormStats']
    total_pending_approval = form_stats_response['pendingOfficerApproval'] + form_stats_response['pendingOfficeApproval'] + form_stats_response['pendingMasterApproval'] + form_stats_response['pendingMasterReview']
    total_update_needed = form_stats_response['approvalUpdatesNeeded'] + form_stats_response['activeUpdatesNeeded'] + form_stats_response['terminationUpdatesNeeded']
    total_active = form_stats_response['active']
    total_terminal = form_stats_response['pendingTermination']
    (total_pending_approval.to_s === pending_approval) && (total_update_needed.to_s === pending_update) && (total_active.to_s === active) && (total_terminal.to_s === pending_termination)
  end
end
