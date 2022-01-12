# frozen_string_literal: true

require_relative '../base_page'

# BasePermitStatesPage object
class BasePermitStatesPage < BasePage
  include EnvUtils

  def wait_for_permit_display(xpath)
    wait = 0
    element = find_element(xpath)
    until element.displayed?
      sleep 0.5
      @driver.navigate.refresh
      wait += 1
      raise 'time out waiting for permit display' if wait > 10
    end
  end
end
