When (/^I change local time$/) do
  on(DashboardPage).adjust_ship_local_time
end

And (/^I enter pin (.+)$/) do |pin|
  on(PinPadPage).enter_pin(pin)
end

Then (/^I should see ship local time updated$/) do
  step 'I get ship-local-time/base-get-current-time request payload'
  step 'I hit graphql'
  is_true(on(DashboardPage).is_update_ship_time)
end