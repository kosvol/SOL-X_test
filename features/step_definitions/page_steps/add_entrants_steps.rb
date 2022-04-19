# frozen_string_literal: true

require_relative '../../../page_objects/add_entrants_page'

And('AddEntrants add new entrants') do |table|
  @add_entrants = AddEntrantsPage.new(@driver)
  @add_entrants.add_entrants(table)
end

And('AddEntrants click send report button') do
  @add_entrants = AddEntrantsPage.new(@driver)
  @add_entrants.click_send_report_btn
end

And('AddEntrants verify rank exclude in other entrants menu') do |table|
  @add_entrants = AddEntrantsPage.new(@driver)
  @add_entrants.verify_rank_exclude(table)
end
