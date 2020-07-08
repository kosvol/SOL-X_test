# frozen_string_literal: true

module BrowserActions
  class << self
    def scroll_up_by_dist
      $browser.execute_script('window.scrollBy(0,-350)', '')
    end

    def hide_keyboard
      $browser.hide_keyboard if %w[Android].include? ENV['PLATFORM']
    end

    def scroll_down(element = nil)
      # if ENV['PLATFORM'] === 'Android'
      #   scroll_down_by_dist
      # else

      scroll_down_by_distance(element)
    rescue StandardError
      scroll_down_by_dist
    end

    def get_attribute_value(xpath)
      $browser.find_element(:xpath, xpath).attribute('value').to_s
    end

    private

    def scroll_down_by_distance(_element)
      $browser.action.move_to(_element).perform
    end

    def scroll_down_by_dist
      $browser.execute_script('window.scrollBy(0,350)', '')
    end
  end
end
