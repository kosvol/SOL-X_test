# frozen_string_literal: true

module BrowserActions
  class << self
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
      $browser.find_element(:xpath, xpath).attribute('value').to_s
    end

    def get_year
      Time.now.strftime('%Y')
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
