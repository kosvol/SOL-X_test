# frozen_string_literal: true

require_relative '../../base_page'

# BasePermitStatesPage object
class BasePermitStatesPage < BasePage
  include EnvUtils

  def wait_for_permit_display(xpath)
    wait = 0
    until @driver.find_elements(:xpath, xpath).size.positive?
      @logger.debug("wait for permit xpath display #{xpath}, retrying #{wait} times")
      sleep 0.5
      @driver.navigate.refresh
      wait += 1
      raise 'time out waiting for permit display' if wait > 10
    end
  end
end
