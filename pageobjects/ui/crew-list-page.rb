# frozen_string_literal: true

require './././support/env'

class CrewListPage
  include PageObject

  elements(:crew_table_header, xpath: '//*/tr/th')
  elements(:crew_list, xpath: '//*/tbody/tr')

  def get_crew_table_headers
    data_collector = []
    crew_table_header_elements.each do |header|
      data_collector << header.text
    end
    data_collector
  end
end
