# frozen_string_literal: true

require './././support/env'

class Section4APage < Section3APage
  include PageObject

  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  elements(:yes_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]")
  @@yes_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]/span"
  elements(:no_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]")
  @@na_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]/span"
  spans(:checklist_name, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/span")
  button(:enter_pin_btn, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer')]/button[1]")
  element(:rank_and_name_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]")
  element(:date_and_time_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]")

  def is_signed_user_details?(_entered_pin)
    BrowserActions.scroll_down(rank_and_name_stamp)
    time_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    rank_and_name = get_user_details_by_pin(_entered_pin)
    p ">> Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}"
    p ">> Date & Time #{Time.new.strftime('%d/%b/%Y')} #{main_clock_element.text} LT (GMT+#{time_offset})"
    (("Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}" === rank_and_name_stamp_element.text) && ("Date & Time #{Time.new.strftime('%d/%b/%Y')} #{main_clock_element.text} LT (GMT+#{time_offset})" === date_and_time_stamp_element.text))
  end

  # ##Blue rgba(24, 144, 255, 1)
  # ##White rgba(255, 255, 255, 1)
  def is_checklist_preselected(_checklist)
    element_yes = get_yes_elements
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      return (element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)') && (get_na_elements[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)')
    end
  end

  def is_hazardous_substance_checklist
    element_yes = get_yes_elements
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === 'Work on Hazardous Substances'

      BrowserActions.scroll_down(element_yes[_index])
      return (checklist.text === 'Work on Hazardous Substances') && (element_yes[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)') && (get_na_elements[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)')
    end
  end

  def select_checklist(_checklist)
    element_yes = get_yes_elements
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      element_yes[_index].click
    end
  end

  private

  def get_yes_elements
    $browser.find_elements(:xpath, @@yes_input)
  end

  def get_na_elements
    $browser.find_elements(:xpath, @@na_input)
  end

  def get_user_details_by_pin(entered_pin)
    tmp_payload = JSON.parse JsonUtil.read_json('get_user_detail_by_pin')
    tmp_payload['variables']['pin'] = entered_pin.to_s
    JsonUtil.create_request_file('mod_get_user_detail_by_pin', tmp_payload)
    ServiceUtil.post_graph_ql('mod_get_user_detail_by_pin')
    tmp_arr = []
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['rank']
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['firstName']
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['lastName']
    tmp_arr
  end
end
