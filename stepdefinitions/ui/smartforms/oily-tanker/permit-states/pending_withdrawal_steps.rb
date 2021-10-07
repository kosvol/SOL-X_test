# frozen_string_literal: true

And(/^I terminate the permit via service with (.+) status$/) do |status|
  on(BypassPage).submit_permit_for_termination_wo_eic_normalization(status)
end

Then(/^I should (.+) as task status$/) do |status|
  is_equal(on(PendingWithdrawalPage)
             .task_status_text(on(ActiveStatePage).get_permit_index(CommonPage.get_permit_id)), status)
end
