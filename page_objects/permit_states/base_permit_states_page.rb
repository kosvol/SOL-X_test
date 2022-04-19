# frozen_string_literal: true

require_relative '../base_page'

# BasePermitStatesPage object
class BasePermitStatesPage < BasePage
  include EnvUtils

  def wait_for_permit_display(xpath)
    wait = 0
    begin
      element = @driver.find_element(:xpath, xpath)
    rescue StandardError
      retry_refresh(xpath, wait)
    end
    element
  end

  private

  def retry_refresh(xpath, wait)
    @logger.debug("wait for permit xpath display #{xpath}, retrying #{wait} times")
    sleep 1
    @driver.navigate.refresh
    wait += 1
    raise 'time out waiting for permit display' if wait > 10
  end
end
