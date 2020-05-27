require "./././support/env"

class PinPadPage
  include PageObject

  buttons(:pin_pad, xpath: "//ol[@class='pin-entry']/li/button")
  button(:cancel, xpath: "//button[@class='cancel']")

  def enter_pin(pin)
    pin.split("").each do |num|
      pin_pad_elements[num.to_i].click
    end
  end
end
