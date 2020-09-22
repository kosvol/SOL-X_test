# frozen_string_literal: true

require './././support/env'

class PinPadPage
  include PageObject

  buttons(:pin_pad, xpath: "//ol[@class='pin-entry']/li/button")
  button(:cancel, xpath: "//button[@class='cancel']")
  element(:error_msg, xpath: "//section[@class='pin-indicators-section']/h2")

  def enter_pin(pin)
    format('%04d', pin).to_s.split('').each do |num|
      index = num.to_i === 0 ? 10 : num
      p index.to_i
      pin_pad_elements[(index.to_i - 1)].click
    end
  end

  def backspace_once
    pin_pad_elements[10].click
  end

  def enter_pin_by_rank(rank)

    puts "role >> #{rank}"
    member_id = get_member_id(url, vessel, rank)
    pin_by_id = get_pin_by_id(member_id)
    enter_pin(pin_by_id)
  end

  private

  def get_member_id(rank)
    url = $obj_env_yml['pin_management']ENV['env']['db']+"crew_members/_find"
    vessel = $obj_env_yml['pin_management']ENV['env']['vessel']

    request = HTTParty.post(url, {
        headers: { 'content-Type' => 'application/json' },
        body: { selector: { vesselId: vessel, rank: rank } }.to_json
    })
    (JSON.parse request.to_s)['docs'][0]['_id']
  end

  def get_pin_by_id(member_id)
    url = $obj_env_yml['pin_management']ENV['env']['db']+"users/_find"

    request = HTTParty.post(url, {
        headers: { 'Content-Type' => 'application/json' },
        body: {
            "selector": {
                "_id": member_id,
            }
        }.to_json
    })
    (JSON.parse request.to_s)['docs'][0]['pin']
  end

end
