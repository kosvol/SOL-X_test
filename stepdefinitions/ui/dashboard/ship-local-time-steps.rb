# frozen_string_literal: true

When (/^I change local time$/) do
  on(ShipLocalTimePage).adjust_ship_local_time
end

And (/^I enter pin (.+)$/) do |pin|
  on(PinPadPage).enter_pin(pin)
end

Then (/^I should see ship local time updated$/) do
  step 'I get ship-local-time/base-get-current-time request payload'
  step 'I hit graphql'
  is_true(on(ShipLocalTimePage).is_update_ship_time)
end

Then (/^I should see base time is UTC$/) do
  puts ">>> #{on(ShipLocalTimePage).is_utc_time}"
end
