# frozen_string_literal: true

module BrowserActions
  class << self
    def scroll_down(_element)
      $browser.action.move_to(_element).perform
    end
  end
end
