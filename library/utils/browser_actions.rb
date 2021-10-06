# frozen_string_literal: true

module BrowserActions
  class << self
    def poll_exists_and_click(element)
      wait_until_is_visible(element) ? element.click : poll_exists_and_click(element)
    end

    def wait_until_is_visible(element)
      $wait.until { element.exists? }
    end

    def wait_until_is_displayed(element)
      $wait.until { element.present? }
    end

    def turn_wifi_off_on
      @browser.toggle_wifi
      sleep 10
    end

    def turn_on_wifi_by_default
      device = YAML.load_file('config/devices.yml')[(ENV['DEVICE']).to_s]

      $wifi_on_off = `adb -s #{device['deviceName']} shell settings get global wifi_on`
      p "Wifi Status: #{$wifi_on_off}"
      if $wifi_on_off.strip == '0'
        @browser.toggle_wifi
        sleep 10
      end
    end

    def scroll_click(element)
      sleep 1
      scroll_down_by_custom_dist(100)
      begin
        element.click
      rescue StandardError
        p 'Scrolling.....'
        scroll_down_by_custom_dist(100)
        element.click
      end
      sleep 1
    end

    def enter_text(field, text)
      field.send_keys(text)
      hide_keyboard
    end

    def hide_keyboard
      @browser.hide_keyboard if %w[Android].include? ENV['PLATFORM']
    end

    def scroll_up(element = nil)
      scroll_to_element(element)
    rescue StandardError
      scroll_up_by_dist
    end

    def scroll_down(element = nil)
      sleep 1
      begin
        scroll_to_element(element)
      rescue StandardError
        scroll_down_by_dist
      end
      sleep 1
    end

    def get_year
      Time.now.strftime('%Y')
    end

    def scroll_down_by_custom_dist(distance)
      @browser.execute_script("window.scrollBy(0,#{distance})", '')
    end

    def scroll_up_by_custom_dist(distance)
      @browser.execute_script("window.scrollBy(0,#{distance})", '')
    end

    def js_click(xpath)
      @browser.execute_script(%(document.evaluate("#{xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
    end

    def js_clicks(xpath, index)
      @browser.execute_script(%(document.evaluate("#{xpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem("#{index}").click()))
    end

    def open_new_page
      @browser.execute_script('window.open()')
      @browser.switch_to.window(@browser.window_handles.last)
    end

    def switch_browser_tab(condition)
      case condition
      when 'last'
        @browser.switch_to.window(@browser.window_handles.last)
      when 'first'
        @browser.switch_to.window(@browser.window_handles.first)
      else
        raise "Wrong condition >>> #{condition}"
      end
    end

    def poll_ui_update_by_attribute(locator, condition, attribute)
      count = 0
      tmp_ele = @browser.find_element(:xpath, locator).attribute(attribute)
      until tmp_ele.to_s == condition
        count += 1
        sleep 1
        break if count == 15
      end
      tmp_ele.to_s
    end

    def click_xpath_native(xpath)
      if wait_until_is_visible((el = @browser.find_element(:xpath, xpath)))
        el.click
      else
        poll_exists_and_click(@browser.find_element(:xpath, xpath))
      end
    end

    private

    def scroll_to_element(element)
      @browser.action.move_to(element).perform
    end

    def scroll_down_by_dist
      @browser.execute_script('window.scrollBy(0,250)', '')
    end

    def scroll_up_by_dist
      @browser.execute_script('window.scrollBy(0,-350)', '')
    end
  end
end
