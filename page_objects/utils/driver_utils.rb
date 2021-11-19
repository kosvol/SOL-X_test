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

  def element_disabled?(xpath, value)
    xpath_value = format(xpath, value)
    element = @driver.find_element(:xpath, xpath_value)
    element.enabled?
  end

  def scroll_times_direction(time, direct)
    time.times do
      scroll_by_dist(0, 250) if direct == 'down'
      scroll_by_dist(0, -350) if direct == 'up'
    end
  end

  private

  def scroll_by_dist(x_coordinate, y_coordinate)
    @driver.execute_script("window.scrollBy(#{x_coordinate},#{y_coordinate})", '')
  end
end
