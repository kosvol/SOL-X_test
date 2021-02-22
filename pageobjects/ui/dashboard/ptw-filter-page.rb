# frozen_string_literal: true

require './././support/env'

class PtwFilterPage < CreatedPermitToWorkPage
  include PageObject

  span(:pending_approval, xpath: "//span[@data-testid='pendingApproval-stat']")
  span(:pending_update, xpath: "//span[@data-testid='updatesNeeded-stat']")
  span(:active, xpath: "//span[@data-testid='active-stat']")
  span(:pending_termination, xpath: "//span[@data-testid='pendingTermination-stat']")

  def does_permit_counter_match
    get_permits_counter
    ($total_pending_approval.to_s === pending_approval) && ($total_update_needed.to_s === pending_update) && ($total_active.to_s === active) && ($total_terminal.to_s === pending_termination)
  end

  def is_permit_listing_count?(_which_filter)
    scroll_multiple_times(8)
    Log.instance.info("\n\nActual: #{parent_container_elements.size}\n\n")
    case _which_filter
    when 'pending approval'
      Log.instance.info("\n\nExpected: #{$total_pending_approval}\n\n")
      parent_container_elements.size === $total_pending_approval
    when 'update needed'
      Log.instance.info("\n\nExpected: #{$total_update_needed}\n\n")
      parent_container_elements.size === $total_update_needed.to_i
    when 'active'
      Log.instance.info("\n\nExpected: #{$total_active}\n\n")
      parent_container_elements.size === $total_active.to_i
    when 'pending withdrawal'
      Log.instance.info("\n\nExpected: #{$total_terminal}\n\n")
      parent_container_elements.size === $total_terminal.to_i
    end
  end

  def get_permits_counter
    form_stats_response = ServiceUtil.get_response_body['data']['formStats']
    $total_pending_approval = form_stats_response['pendingOfficerApproval'] + form_stats_response['pendingOfficeApproval'] + form_stats_response['pendingMasterApproval'] + form_stats_response['pendingMasterReview']
    $total_update_needed = form_stats_response['approvalUpdatesNeeded'] + form_stats_response['activeUpdatesNeeded'] + form_stats_response['terminationUpdatesNeeded']
    $total_active = form_stats_response['active']
    $total_terminal = form_stats_response['pendingTermination']
  end
end
