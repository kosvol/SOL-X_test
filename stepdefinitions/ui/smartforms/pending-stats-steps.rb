# frozen_string_literal: true

Then (/^I should see (.+) button$/) do |state|
  if state === 'Office Approval'
    is_equal(on(PendingStatePage).get_button_text, 'Office Approval')
  elsif state === 'Master Approval'
    is_equal(on(PendingStatePage).get_button_text, 'Master Approval')
  elsif state === 'Master Review'
    is_equal(on(PendingStatePage).get_button_text, 'Master Review')
  end
end
