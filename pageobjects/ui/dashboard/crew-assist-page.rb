# frozen_string_literal: true

require './././support/env'

class CrewAssistPage < DashboardPage
  include PageObject

  divs(:crew_assist_details, xpath: "//div[starts-with(@class,'CrewAssistModal__CrewDatumRow')]/div")
  divs(:crew_assist_dialogs, xpath: "//div[@role='dialog']/div")
  element(:acknowledge_btn, xpath: "//div[starts-with(@class, 'CrewAssistModal__Content')]/button/span")

  def is_crew_assist_dialog_details
    list_of_dialog_details = []
    crew_assist_details_elements.each do |detail|
      list_of_dialog_details << detail.text
    end
    get_crew_details_from_response
    Log.instance
       .info("\n\n#{list_of_dialog_details[1]}\n\n#{list_of_dialog_details[3]}\n\n#{list_of_dialog_details[5]}")
    list_of_dialog_details[1] == @crew_rank &&
      list_of_dialog_details[3] == @crew_name &&
      list_of_dialog_details[5] == @crew_location
  end

  def is_crew_location_indicator_green
    @browser.find_element(:xpath, "//div[starts-with(@class,'CrewListItem__Indicator')]")
            .css_value('background-color')
            .to_s == 'rgba(216, 75, 75, 1)'
  end

  private

  def get_crew_details_from_response
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      next if wearable['crewMember'].nil?

      @crew_rank = wearable['crewMember']['rank']
      @crew_name = "#{wearable['crewMember']['firstName']} #{wearable['crewMember']['lastName']}"
      @crew_location = get_beacon_location
    end
    Log.instance.info("\n\n#{@crew_rank}\n\n#{@crew_name}\n\n#{@crew_location}")
  end
end
