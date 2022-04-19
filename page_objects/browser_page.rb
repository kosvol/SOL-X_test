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
end
