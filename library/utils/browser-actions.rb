# frozen_string_literal: true

module BrowserActions
  class << self

    def turn_wifi_off_on
      # wifi_on_off = `adb shell settings get global wifi_on`
      $browser.toggle_wifi# if wifi_on_off.strip === "1"
      sleep 14
    end

    def click_element(_element)
      sleep 1
      _element.click
    end

    def scroll_click(_element)
      sleep 1
      # scroll_down
      scroll_down_by_custom_dist(100)
      sleep 1
      _element.click
      sleep 1
    rescue StandardError
      p 'Scrolling.....'
      scroll_down_by_custom_dist(100)
      sleep 1
      _element.click
      sleep 1
    end

    def enter_text(field, _text)
      field.send_keys(_text)
      hide_keyboard
    end

    def hide_keyboard
      $browser.hide_keyboard if %w[Android].include? ENV['PLATFORM']
    end

    def scroll_up(element = nil)
      scroll_to_element(element)
    rescue StandardError
      scroll_up_by_dist
    end

    def scroll_down(element = nil)
      scroll_to_element(element)
    rescue StandardError
      scroll_down_by_dist
    end

    def get_attribute_value(xpath)
      $browser.find_elementent(:xpath, xpath).attribute('value').to_s
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
