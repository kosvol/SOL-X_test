# frozen_string_literal: true

require_relative '../../../page_objects/add_crew_window'

And('AddCrew verify button availability') do |table|
  @add_crew_window ||= AddCrewWindow.new(@driver)
  params = table.hashes.first
  @add_crew_window.verify_button(params['button'], params['availability'])
end

And('AddCrew add crew member by id {string}') do |crew_id|
  @add_crew_window ||= AddCrewWindow.new(@driver)
  @add_crew_window.add_crew(crew_id)
end

And('AddCrew verify error message {string}') do |message|
  @add_crew_window ||= AddCrewWindow.new(@driver)
  @add_crew_window.verify_message(message)
end

And('AddCrew verify available rank list for {string} {string}') do |rank, group|
  @add_crew_window ||= AddCrewWindow.new(@driver)
  @add_crew_window.verify_rank_ddlist(rank, group)
end

And('AddCrew confirm add crew operation and save pin') do
  @add_crew_window ||= AddCrewWindow.new(@driver)
  @add_crew_window.view_crew_pin
  @saved_pin = @add_crew_window.save_pin
end
