# frozen_string_literal: true

require './././support/env'

class CrewListPage
  include PageObject

  elements(:crew_table_header, xpath: '//*/tr/th')
  elements(:crew_list, xpath: '//*/tbody/tr')
  elements(:crew_pin_list, xpath: "//tbody[starts-with(@class, 'CrewList__TableBody')]/tr/td[6]")
  span(:crew_count, xpath: "//span[@data-testid='total-on-board']")
  elements(:crew_details, xpath: "//tbody[starts-with(@class, 'CrewList__TableBody')]/tr")

  def get_crew_table_headers
    data_collector = []
    crew_table_header_elements.each do |header|
      data_collector << header.text
    end
    data_collector
  end

  def is_pin_hidden
    crew_pin_list_elements.all? do |pin|
      pin.text === '••••'
    end
  end

  def get_crew_details
    crew_details = YAML.load_file('data/crew-details.yml')

    crew_details_elements.each_with_index.all? do |crew, _index|
      Log.instance.info("Expected: #{crew.text.to_s.gsub!(/\s+/, ' ')}")
      Log.instance.info("Actual: #{crew_details['crew'][_index]}")
      crew.text.to_s.gsub!(/\s+/, ' ') === crew_details['crew'][_index]
    end
  end
end
