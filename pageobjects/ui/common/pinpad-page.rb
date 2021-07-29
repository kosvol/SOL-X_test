# frozen_string_literal: true

require './././support/env'

class PinPadPage
  include PageObject

  buttons(:pin_pad, xpath: "//main/ol[@class='pin-entry']/li/button[starts-with(@class,'Button__')]")
  element(:error_msg, xpath: "//section[@class='pin-indicators-section']/h2")

  def enter_pin(pin)
    p "pin >> #{pin}"
    pin.split('').each do |num|
      index = num.to_i.zero? ? 10 : num
      query = "//ol[@class='pin-entry']/li[%s]/button[starts-with(@class,'Button__')]"
      query = format(query, index.to_s)
      BrowserActions.wd_get_by_xpath_element_click(query)
    end
  end

  def backspace_once
    pin_pad_elements.last.click
  end

  def cancel_pinpad
    BrowserActions.wd_get_by_xpath_element_click("//button[@class='cancel']")
    # BrowserActions.js_click("//button[@class='cancel']")
  end

  def get_pin_code(users, rank)
    users.each do |user|
      return user['pin'].to_i if user['crewMember']['rank'] == rank
    end
  end
end
