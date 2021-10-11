# frozen_string_literal: true

require './././support/env'

class CrewListPage < DashboardPage
  include PageObject

  elements(:crew_table_header, xpath: '//*/tr/th')
  elements(:crew_rank, xpath: "//tr/td[starts-with(@data-testid,'rank-')]")
  elements(:crew_list, xpath: '//*/tbody/tr')
  elements(:crew_pin_list, xpath: '//tbody/tr/td[5]')
  spans(:countdown, xpath: "//button[starts-with(@class,'Button__ButtonStyled-')]/span")
  span(:crew_count, xpath: "//span[@data-testid='total-on-board']")
  elements(:location_details, xpath: "//td[contains(@data-testid,'location-')]")
  button(:view_pin_btn, xpath: "//button[contains(.,'View PINs')]")
  button(:view_crew_pin_btn, xpath: "//button[contains(.,'View Pin')]")
  button(:add_new_crew_btn,
         xpath: "//main[starts-with(@class, 'Crew__Content')]/button[starts-with(@class,'Button__ButtonStyled')]")
  text_field(:crew_id, xpath: "//input[starts-with(@class, 'Input-')]")
  button(:retrieve_data_btn,
         xpath: "//div[starts-with(@class,'NewCrewDialog__Content')]/button[starts-with(@class,'Button__ButtonStyled')]")
  element(:duplicate_crew, xpath: "//div[starts-with(@class,'Input__InputContainer')]/div")
  buttons(:rank_list_selection, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  button(:rank_list_btn, xpath: "//button[@id='rank']")
  element(:pin_text_field, xpath: "//div[@class='pin-code']")
  @@location_indicator = "//div[@data-testid='location-indicator']"

  def is_rank_changed?
    rank_list.each_with_index do |rank, _index|
      next unless @@changed_rank == rank

      break
    end
  end

  def change_crew_rank
    rank_list_btn
    @@changed_rank = rank_list_selection_elements[0].text
    rank_list_selection_elements[0].click
    view_pin_btn
  end

  def is_pin_viewed?
    pin_text_field_element.text != '••••'
  end

  def rank_correctly_displayed?(current_rank)
    sleep 1
    rank_list_btn
    rank_list = return_sit_and_rank_yaml
    sleep 1
    rank_list.each_with_index do |rank, index|
      next unless current_rank == rank

      if current_rank != 'MAS'
        return (rank_list_selection_elements[0]
                  .text == rank_list[index - 1]) && (rank_list_selection_elements[2].text == rank_list[index + 1])
      end
      return (rank_list_selection_elements[1].text == rank_list[index + 1]) if current_rank == 'MAS'

      break
    end
  end

  def crew_sorted_desc_seniority?
    rank_arr = []
    crew_rank_elements.each do |x|
      rank_arr << x.text
    end
    rank_list = return_sit_and_rank_yaml
    Log.instance.info "Sorted Ranks: #{rank_arr.uniq}"
    Log.instance.info "YAML Ranks: #{rank_list['ranks_sorted_auto']}"
    rank_arr.uniq == rank_list['ranks_sorted_auto']
  end

  def crew_table_headers_list
    data_collector = []
    crew_table_header_elements.each do |header|
      data_collector << header.text
    end
    data_collector
  end

  def pin_hidden?
    sleep 1
    crew_pin_list_elements.first.text == '••••'
  end

  def pin_reviewed?
    sleep 1
    crew_pin_list_elements.all? do |pin|
      pin.text == '••••'
    end
  end

  ### "rgba(67, 160, 71, 1), 1)" - green
  ### "rgba(242, 204, 84, 1)" - yellow
  def activity_indicator_status?(color)
    element = @browser.find_element(:xpath, @@location_indicator)
    BrowserActions.scroll_down(_element)
    color == 'rgba(242, 204, 84, 1)' ? (sleep 297) : (sleep 150)
    element.css_value('background-color') == color
  end

  def location_details?(location = nil)
    sleep 1
    get_active_crew_details_frm_service = get_active_crew_details_frm_service(location)
    element = @browser.find_element(:xpath, @@location_indicator)
    BrowserActions.scroll_down(element)
    BrowserActions.scroll_down
    location_details_elements.each do |location|
      next if location.text == ''

      Log.instance.info("Expected: #{location.text.gsub!(/\s+/, ' ')}")
      Log.instance.info("Actual: #{get_active_crew_details_frm_service.first.first}")
      return (location.text.gsub!(/\s+/, ' ').to_s.include? get_active_crew_details_frm_service.first.first)
    end
  end

  private

  def get_active_crew_details_frm_service(location = nil)
    crew_details = []
    if location.nil?
      ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
        next if wearable['crewMember'].nil?

        crew_details << ["#{get_beacon_location} - "]
      end
    else
      crew_details << ["#{location} - Just now"]
    end
    p '>> stuck'
    crew_details
  end
end