# frozen_string_literal: true

module BrowserActions
  class << self

    ### new methods

    def poll_exists_and_click(_element)
      (wait_until_is_visible(_element)) ? _element.click : poll_exists_and_click(_element)
    end

    def wait_until_is_visible(_element)
      $wait.until { _element.exists? }
      # sleep 1 until _element.exists?
    end

    def turn_wifi_off_on
      # wifi_on_off = `adb shell settings get global wifi_on`
      $browser.toggle_wifi# if wifi_on_off.strip === "1"
      p "WIFI turned on/off"
      sleep 9
    end

    ### end

    def scroll_click(_element)
      sleep 1
      scroll_down_by_custom_dist(100)
      begin
        _element.click
      rescue StandardError
        p 'Scrolling.....'
        scroll_down_by_custom_dist(100)
        _element.click
      end
      sleep 1
    end

    def enter_text(field, _text)
      field.send_keys(_text)
      hide_keyboard
    end

    def hide_keyboard
      $browser.hide_keyboard if %w[Android].include? ENV['PLATFORM']
    end

    def scroll_up(_element = nil)
      begin
        scroll_to_element(_element)
      rescue StandardError
        scroll_up_by_dist
      end
    end

    def scroll_down(_element = nil)
      begin
        scroll_to_element(_element)
      rescue StandardError
        scroll_down_by_dist
      end
    end

    def get_attribute_value(xpath)
      $browser.find_elemente(:xpath, xpath).attribute('value').to_s
    end

    def get_year
      Time.now.strftime('%Y')
    end

    def scroll_down_by_custom_dist(_distance)
      $browser.execute_script("window.scrollBy(0,#{_distance})", '')
    end

    def scroll_up_by_custom_dist(_distance)
      $browser.execute_script("window.scrollBy(0,#{_distance})", '')
    end

    def js_click(_xpath)
      $browser.execute_script(%(document.evaluate("#{_xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
    end

    private

    def scroll_to_element(_element)
      $browser.action.move_to(_element).perform
    end

    def scroll_down_by_dist
      $browser.execute_script('window.scrollBy(0,250)', '')
    end

    def scroll_up_by_dist
      $browser.execute_script('window.scrollBy(0,-350)', '')
    end
  end
end
