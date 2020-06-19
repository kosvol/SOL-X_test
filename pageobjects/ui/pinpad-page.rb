# frozen_string_literal: true

require './././support/env'

class PinPadPage
  include PageObject

  buttons(:pin_pad, xpath: "//ol[@class='pin-entry']/li/button")
  button(:cancel, xpath: "//button[@class='cancel']")
  element(:error_msg, xpath: "//section[@class='pin-indicators-section']/h2")

  def enter_pin(pin)
    pin.to_s.split('').each do |num|
      p num.to_i
      pin_pad_elements[num.to_i].click
    end
  end

  def backspace_once
    pin_pad_elements[10].click
  end
end
