# frozen_string_literal: true

module BrowserActions
  class << self
    def scroll_down(_element)
      $browser.action.move_to(_element).perform
    end

    def scroll_up_by_dist
      $browser.execute_script('window.scrollBy(0,-350)', '')
    end

    def scroll_down_by_dist
      $browser.execute_script('window.scrollBy(0,350)', '')
    end

    def hide_keyboard
      $browser.hide_keyboard if %w[Android].include? ENV['PLATFORM']
    end
  end
end
