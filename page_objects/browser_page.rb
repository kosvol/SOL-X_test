# frozen_string_literal: true

# BrowserPage object
class BrowserPage
  def initialize(driver)
    @driver = driver
    @logger = Logger.new($stdout)
  end

  def open_new_page
    @driver.execute_script('window.open()')
  end

  def switch_browser_tab(condition)
    case condition
    when 'last'
      @driver.switch_to.window(@driver.window_handles.last)
    when 'first'
      @driver.switch_to.window(@driver.window_handles.first)
    else
      raise "Wrong condition >>> #{condition}"
    end
  end

  def refresh_page
    @driver.navigate.refresh
    sleep 0.5
  end

  def switch_window(window)
    window_number = window - 1
    @driver.switch_to.window(@driver.window_handles[window_number])
  end

  def open_second_window
    @driver.manage.new_window(:window)
    sleep 0.5
    @driver.switch_to.window(@driver.window_handles[1])
  end
end
