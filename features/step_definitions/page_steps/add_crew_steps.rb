# frozen_string_literal: true

require_relative '../../../page_objects/add_crew_window'

And('AddCrew verify button availability') do |table|
  @add_crew_window ||= AddCrewWindow.new(@driver)
  params = table.hashes.first
  @add_crew_window.verify_button(params['button'], params['availability'])
end

And('AddCrew add crew member') do |table|
  @add_crew_window ||= AddCrewWindow.new(@driver)
  params = table.hashes.first
  @add_crew_window.add_crew(params['crew_id'])
end

And('AddCrew verify error message {string}') do |message|
  @add_crew_window ||= AddCrewWindow.new(@driver)
  @add_crew_window.verify_message(message)
end
