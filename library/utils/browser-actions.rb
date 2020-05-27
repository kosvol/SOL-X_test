module BrowserActions
  class << self
    def scroll_down(dist, browser)
      browser.execute_script("window.scrollBy(0,#{dist})")
    end

    def scroll_and_click(e, browser = "")
      begin
        e.click
      rescue
        scroll_down(300, @browser)
        e.click
      end
    end

    def perform_action(element, browser)
      WebElement x = browser.execute_script("return window.getComputedStyle(arguments[0], ':before').getPropertyValue('background-color');", element)
      x.click
    end

    def click_menu_element(elements, which_menu)
      elements.each do |element|
        return element if element.text.downcase == which_menu.downcase
      end
    end
  end
end
