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
    true?(element.enabled?)
  end

  def element_disabled?(xpath, value)
    xpath_value = format(xpath, value)
    element = @driver.find_element(:xpath, xpath_value)
    false?(element.enabled?)
  end

  def scroll_times_direction(time, direct)
    time.times do
      scroll_down_by_dist if direct == 'down'
      scroll_up_by_dist if direct == 'up'
    end
  end

  def fill_all_text_areas(input, text)
    tmp_elements = find_elements(input)
    tmp_elements.each do |element|
      element.send_keys(text)
    end
  end

  def checkbox_click(xpath, text)
    click(format(xpath, text).to_s)
  end

  def true?(element)
    expect(element).to be true
  end

  def false?(element)
    expect(element).to be false
  end

  private

  def scroll_down_by_dist
    @driver.execute_script('window.scrollBy(0,250)', '')
  end

  def scroll_up_by_dist
    @driver.execute_script('window.scrollBy(0,-350)', '')
  end
end
