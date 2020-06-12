# frozen_string_literal: true

require './././support/env'

class CrewListPage < DashboardPage
  include PageObject

  elements(:crew_table_header, xpath: '//*/tr/th')
  elements(:crew_rank, xpath: "//tr/td[starts-with(@data-testid,'rank-')]")
  elements(:crew_list, xpath: '//*/tbody/tr')
  elements(:crew_pin_list, xpath: "//tbody[starts-with(@class, 'CrewList__TableBody')]/tr/td[6]")
  span(:crew_count, xpath: "//span[@data-testid='total-on-board']")
  elements(:crew_details, xpath: "//tbody[starts-with(@class, 'CrewList__TableBody')]/tr")
  divs(:location_details, xpath: "//div[@data-testid='location']")
  button(:view_pin_btn, xpath: "//button[starts-with(@class, 'Button__ButtonStyled')]")
  @@location_indicator = "//div[@data-testid='location-indicator']"

  def is_crew_sorted_descending_seniority
    rank_arr = []
    crew_rank_elements.each do |x|
      rank_arr << x.text
    end
    rank_arr.uniq === $sit_rank_and_pin_yml['Ranks']
  end

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

  ### "rgba(67, 160, 71, 1), 1)" - green
  ### "rgba(242, 204, 84, 1)" - yellow
  def is_activity_indicator_status(color)
    color === 'rgba(242, 204, 84, 1)' ? (sleep 27) : (sleep 2)
    _element = $browser.find_element(:xpath, @@location_indicator)
    BrowserActions.scroll_down(_element)
    _element.css_value('background-color') === color
  end

  def is_location_details(_location = nil)
    _get_active_crew_details_frm_service = get_active_crew_details_frm_service(_location)
    location_details_elements.each do |location|
      next if location.text === ''

      Log.instance.info("Expected: #{location.text.gsub!(/\s+/, ' ')}")
      Log.instance.info("Actual: #{_get_active_crew_details_frm_service.first.first}")
      return (location.text.gsub!(/\s+/, ' ').to_s === _get_active_crew_details_frm_service.first.first)
    end
  end

  private

  def get_active_crew_details_frm_service(_location = nil)
    crew_details = []
    if _location.nil?
      ServiceUtil.get_response_body['data']['wearables'].each do |_wearable|
        next if _wearable['crewMember'].nil?

        crew_details << ["#{get_beacon_location} - Just now"]
      end
    else
      crew_details << ["#{_location} - Just now"]
    end

    crew_details
  end
end
