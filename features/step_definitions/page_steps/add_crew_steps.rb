# frozen_string_literal: true

require_relative '../../../page_objects/add_crew_window'

And('AddCrew verify window elements') do
  @add_crew_window ||= AddCrewWindow.new(@driver)
  @add_crew_window.verify_elements
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

And('AddCrew verify new pin is shown') do
  @add_crew_window ||= AddCrewWindow.new(@driver)
  @add_crew_window.view_crew_pin
  @add_crew_window.verify_new_pin
end
