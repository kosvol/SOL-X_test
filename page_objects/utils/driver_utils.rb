# frozen_string_literal: true

# utils for driver action
module DriverUtils
  TIMEOUT = 10
  WAIT = Selenium::WebDriver::Wait.new(timeout: TIMEOUT)
  RETRY_LIMIT = 5

  def click(xpath)
    WAIT.until { @driver.find_element(:xpath, xpath).displayed? }
    @driver.find_element(:xpath, xpath).click
  end

  def scroll_click(xpath)
    WAIT.until { @driver.find_element(:xpath, xpath).displayed? }
    element = @driver.find_element(:xpath, xpath)
    @driver.execute_script('arguments[0].scrollIntoView({block: "center", inline: "center"})', element)
    element.click
  end

  def retrieve_text(xpath)
    WAIT.until { @driver.find_element(:xpath, xpath).displayed? }
    @driver.find_element(:xpath, xpath).text
  end

  def find_element(xpath)
    WAIT.until { @driver.find_element(:xpath, xpath).displayed? }
    @driver.find_element(:xpath, xpath)
  end

  def find_elements(xpath)
    WAIT.until { @driver.find_elements(:xpath, xpath).size.positive? }
    @driver.find_elements(:xpath, xpath)
  end

  def wait_until_enabled(xpath)
    WAIT.until { @driver.find_element(:xpath, xpath).enabled? }
    @driver.find_element(:xpath, xpath)
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

  def clear_text(xpath)
    key1 = "\ue009"
    key2 = 'a'
    key3 = "\ue017"
    @driver.find_element(:xpath, xpath).send_keys(key1 + key2 + key3)
  end

  private

  def scroll_by_dist(x_coordinate, y_coordinate)
    @driver.execute_script("window.scrollBy(#{x_coordinate},#{y_coordinate})", '')
  end

  def wait_until_text_update(element, text_to_update)
    wait = 0
    until element.text != text_to_update
      sleep 0.5
      wait += 1
      break if wait > 10
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

  def retrieve_elements_text_list(xpath)
    list = []
    elements = @driver.find_elements(:xpath, xpath)
    elements.each do |element|
      list << element.text
    end
    list
  end
end
