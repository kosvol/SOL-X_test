# frozen_string_literal: true

require './././support/env'

class NavigationPage
  include PageObject

  button(:hamburger_menu, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button")
  @@setting_link = "//a[contains(text(),'%s')]"
  @@root_PRE = "//h3[contains(text(),'Pump Room Entry')]/following::a[contains(text(),'%s')]"
  @@show_more = "//button[contains(text(),'Show More')]"

  def tap_hamburger_menu
    sleep 1
    hamburger_menu
    sleep 1 # too fast pausing for screenshot
  end

  def select_nav_category(_category, pre = false, show_more = false)
    unless @already_opened_show_more_for_pre
      if show_more and pre
        @already_opened_show_more_for_pre = true
        @browser.find_elements(:xpath, @@show_more)[1].click
        sleep 1
      end
    end

    unless @already_opened_show_more
      if show_more and !pre
        @already_opened_show_more = true
        @browser.find_elements(:xpath, @@show_more)[0].click
        sleep 1
      end
    end

    if !pre
      @browser.find_element(:xpath, @@setting_link%[_category]).click
    else
      @browser.find_element(:xpath, @@root_PRE%[_category]).click
    end
  end
end
