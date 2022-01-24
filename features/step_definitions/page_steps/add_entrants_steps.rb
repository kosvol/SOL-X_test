# frozen_string_literal: true

require_relative '../../../page_objects/add_entrants_page'

And('AddEntrants add new entrants') do |table|
  parms = table.hashes.first
  @add_entrants = AddEntrantsPage.new(@driver)
  @add_entrants.add_optional_entrants(parms['entrants_number']) if parms['type'] == 'optional'
  @add_entrants.add_required_entrants(parms['entrants_number']) if parms['type'] == 'required'
end

And('AddEntrants click confirm button') do
  @add_entrants = AddEntrantsPage.new(@driver)
  @add_entrants.click_confirm_btn
end

And('AddEntrants click send report button') do
  @add_entrants = AddEntrantsPage.new(@driver)
  @add_entrants.click_send_report_btn
end
