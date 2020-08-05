# frozen_string_literal: true

And (/^I terminate the permit via service with (.+) status$/) do |_status|
  on(BypassPage).submit_permit_for_termination_wo_eic_normalization(_status)
end

Then (/^I should (.+) as task status$/) do |_status|
  is_equal(on(PendingWithdrawalPage).get_task_status_text(on(ActiveStatePage).get_permit_index(CommonPage.get_permit_id)), _status)
end
