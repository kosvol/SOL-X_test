# frozen_string_literal: true

require './././support/env'

class PinPadPage
  include PageObject

  buttons(:pin_pad, xpath: "//main/ol[@class='pin-entry']/li/button")
  # button(:cancel, xpath: "//button[@class='cancel']")
  element(:error_msg, xpath: "//section[@class='pin-indicators-section']/h2")

  def enter_pin(pin)
    
    format('%04d', pin).to_s.split('').each do |num|
      sleep 0.5
      index = num.to_i === 0 ? 10 : num
      query = "//ol[@class='pin-entry']/li[%s]/button"  
      query = query % [index.to_s]
      p ">> #{query}"
      @browser.execute_script(%(document.evaluate("#{query}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
      # query = query % [index.to_i-1]
      # p ">> #{query}"
      # p "#{pin_pad_elements[(index.to_i-1)].text}"
      # pin_pad_elements[(index.to_i-1)].click
    end
  end

  def backspace_once
    pin_pad_elements.last.click
  end

  def cancel_pinpad
    @browser.execute_script(%(document.evaluate("//button[@class='cancel']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
  end

  def get_pin_code(users, rank)
    users.each do |user|
      return user['pin'].to_i if user['crewMember']['rank'] == rank
    end
  end
end
