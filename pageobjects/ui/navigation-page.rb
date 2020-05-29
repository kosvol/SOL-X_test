# frozen_string_literal: true

require './././support/env'

class NavigationPage
  include PageObject

  element(:hamburger_menu, xpath: "//section[@class='title']//button//*[local-name()='svg']")
  list_items(:drilled_ham_menu, xpath: '//ul[1]//li')

  def tap_hamburger_menu
    hamburger_menu_element.click
    sleep 1 # too fast pausing for screenshot
  end

  def select_nav_category(_category)
    drilled_ham_menu_elements.each do |category|
      category.click if category.text.strip === _category.strip
    end
  end
end
