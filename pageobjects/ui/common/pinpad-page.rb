# frozen_string_literal: true

require './././support/env'

class PinPadPage
  include PageObject

  buttons(:pin_pad, css: "ol.pin-entry > li > button")
  button(:cancel, css: "button.cancel")
  element(:error_msg, xpath: "//section[@class='pin-indicators-section']/h2")

  def enter_pin(pin)
    Log.instance.info "Pin >> #{pin}"
    sleep 1
    pin.split('').each do |num|
      index = num.to_i.zero? ? 10 : num
      pin_pad_elements[index.to_i-1].click
    end
  end

  def backspace_once
    pin_pad_elements.last.click
  end

  def cancel_pinpad
    cancel
  end

  def get_pin_code(users, rank)
    users.each do |user|
      return user['pin'].to_i if user['crewMember']['rank'] == rank
    end
  end
end
