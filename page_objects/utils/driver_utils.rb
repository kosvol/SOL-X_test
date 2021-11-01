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

  def click_css(css)
    element = @driver.find_element(:css, css)
    WAIT.until { element.displayed? }
    element.click
  end

  def scroll_click(xpath)
    element = find_element(xpath)
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
    WAIT.until { elements.first.displayed? }
    elements
  end

  def find_elements_css(css)
    elements = @driver.find_elements(:css, css)
    WAIT.until { elements.first.displayed? }
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

  def element_displayed?(xpath, value)
    xpath_value = format(xpath, value)
    element = @driver.find_element(:xpath, xpath_value)
    element.location_once_scrolled_into_view
    element.displayed?
  end

  def element_enabled?(xpath, value)
    xpath_value = format(xpath, value)
    element = @driver.find_element(:xpath, xpath_value)
    element.location_once_scrolled_into_view
    is_true(element.enabled?, true)
  end

  def element_disabled?(xpath, value)
    xpath_value = format(xpath, value)
    element = @driver.find_element(:xpath, xpath_value)
    is_false(element.enabled?, true)
  end

  def scroll_times_direction(time, direct)
    time.times do
      scroll_down_by_dist if direct == 'down'
      scroll_up_by_dist if direct == 'up'
    end
  end

  private

  def scroll_down_by_dist
    @driver.execute_script('window.scrollBy(0,250)', '')
  end

  def scroll_up_by_dist
    @driver.execute_script('window.scrollBy(0,-350)', '')
  end
end
