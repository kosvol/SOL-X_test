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
    (@total_pending_approval.to_s == pending_approval) && (@total_update_needed.to_s == pending_update) && (@total_active.to_s == active) && (@total_terminal.to_s == pending_termination)
  end

  def is_permit_listing_count?(which_filter)
    permit_counter_arr = get_permits_counter
    scroll_multiple_times_with_direction(10, 'down')
    Log.instance.info("\n\nActual: #{parent_container_elements.size}\n\n")

    case which_filter
    when 'pending approval'
      match_permit_counter(permit_counter_arr.first, @total_pending_approval)
    when 'update needed'
      match_permit_counter(permit_counter_arr[1], @total_update_needed)
    when 'active'
      match_permit_counter(permit_counter_arr[2], @total_active)
    when 'pending withdrawal'
      match_permit_counter(permit_counter_arr.last, @total_terminal)
    end
  end

  private

  def get_permits_counter
    form_stats_response = ServiceUtil.get_response_body['data']['formStats']
    @total_pending_approval = form_stats_response['pendingOfficerApproval'] + form_stats_response['pendingOfficeApproval'] + form_stats_response['pendingMasterApproval'] + form_stats_response['pendingMasterReview']
    @total_update_needed = form_stats_response['approvalUpdatesNeeded'] + form_stats_response['activeUpdatesNeeded'] + form_stats_response['terminationUpdatesNeeded']
    @total_active = form_stats_response['active']
    @total_terminal = form_stats_response['pendingTermination']
    return [@total_pending_approval, @total_update_needed, @total_active, @total_terminal]
  end

  def match_permit_counter(compare, expected)
    if compare.to_i != 0
      Log.instance.info("\n\nExpected: #{expected}\n\n")
      parent_container_elements.size == expected
    else
      to_exists(no_permits_found_element)
    end
  end
end
