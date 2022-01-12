# frozen_string_literal: true

# utils for driver action
module DriverUtils
  TIMEOUT = 10
  WAIT = Selenium::WebDriver::Wait.new(timeout: TIMEOUT)
  RETRY_LIMIT = 5

  def click(xpath)
    element = @driver.find_element(:xpath, xpath)
    WAIT.until { element.displayed? }
    element.click
  end

  def scroll_click(xpath)
    element = @driver.find_element(:xpath, xpath)
    element.location_once_scrolled_into_view
    element.click
  end

  def retrieve_text(xpath)
    element = @driver.find_element(:xpath, xpath)
    WAIT.until { element.displayed? }
    element.text
  end

  def find_element(xpath)
    element = @driver.find_element(:xpath, xpath)
    WAIT.until { element.displayed? }
    element
  end

  def find_elements(xpath)
    elements = @driver.find_elements(:xpath, xpath)
    WAIT.until { elements.size.positive? }
    elements
  end

  def verify_element_not_exist(xpath)
    @driver.manage.timeouts.implicit_wait = 0
    raise "#{xpath} element should not displayed" if @driver.find_elements(xpath: xpath).size.positive?

    @driver.manage.timeouts.implicit_wait = TIMEOUT
  end

  def compare_string(expected, actual)
    raise "verify failed, expected: #{expected}, actual:#{actual}" unless expected == actual
  end

  def scroll_times_direction(time, direct)
    time.to_i.times do
      scroll_by_dist(0, 250) if direct == 'down'
      scroll_by_dist(0, -350) if direct == 'up'
    end
  end

  def enter_text(xpath, text)
    @driver.find_element(:xpath, xpath).send_keys(text)
  end

  private

  def scroll_by_dist(x_coordinate, y_coordinate)
    @driver.execute_script("window.scrollBy(#{x_coordinate},#{y_coordinate})", '')
  end

  def wait_for_update(actual, expected, timeout = 5)
    wait = 0
    until actual == expected
      sleep 0.5
      wait += 1
      raise "wait time out for #{actual} to #{expected}" if wait > timeout
    end
  end

  def verify_btn_availability(xpath, option)
    btn_element = find_element(xpath)
    if option == 'enabled'
      raise "#{xpath} btn is disabled" unless btn_element.enabled?
    elsif btn_element.enabled?
      raise "#{xpath} btn is enabled"
    end
  end
end
