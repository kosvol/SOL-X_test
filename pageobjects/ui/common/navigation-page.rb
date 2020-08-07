# frozen_string_literal: true

require './././support/env'

class NavigationPage
  include PageObject

  button(:hamburger_menu, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button")
  # element(:hamburger_menu, xpath: "//button/*[@data-testid='hamburger']")
  list_items(:drilled_ham_menu, xpath: '//ul[1]//li')

  def tap_hamburger_menu
    sleep 1
    hamburger_menu
    sleep 1 # too fast pausing for screenshot
  end

  def select_nav_category(_category)
    drilled_ham_menu_elements.each do |category|
      if category.text.strip === _category.strip
        category.click
        break
      end
    end
  end
end
