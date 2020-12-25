# frozen_string_literal: true

require './././support/env'

class NavigationPage
  include PageObject

  button(:hamburger_menu, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button")
  @@setting_link = "//a[contains(text(),'%s')]"

  def select_nav_category(_category)
    sleep 1
    @browser.find_element(:xpath, @@setting_link%[_category]).click
  end
end
