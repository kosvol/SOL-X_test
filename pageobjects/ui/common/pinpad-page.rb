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

  def enter_pin_for_rank(rank)
    puts "role >> #{rank}"
    member_id = get_member_id(rank)
    pin_by_id = get_pin_by_id(member_id).to_i
    puts "pin >> #{pin_by_id}"
    enter_pin(pin_by_id)
  end

  private

  def get_member_id(rank)
    p ENV['env']

    url = $obj_env_yml['pin_management'][$current_environment]['db'] + "crew_members/_find"
    vessel = $obj_env_yml['pin_management'][$current_environment]['vessel']

    request = HTTParty.post(url, {
        headers: {'content-Type' => 'application/json'},
        body: {selector: {vesselId: vessel, rank: rank}}.to_json
    })
    if !(JSON.parse request.to_s)['docs'].empty?
      (JSON.parse request.to_s)['docs'][0]['_id']
    else
      abort("the element does not exist. table 'crew_members' >> #{rank}")
    end
  end

  def get_pin_by_id(member_id)
    url = $obj_env_yml['pin_management'][$current_environment]['db'] + "users/_find"

    request = HTTParty.post(url, {
        headers: {'Content-Type' => 'application/json'},
        body: {
            "selector": {
                "_id": member_id,
            }
        }.to_json
    })

    if !(JSON.parse request.to_s)['docs'].empty?
      (JSON.parse request.to_s)['docs'][0]['pin']
    else
      abort("the element does not exist. table 'users' >> #{member_id}")
    end
  end
end
