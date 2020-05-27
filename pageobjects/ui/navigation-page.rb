require "./././support/env"

class NavigationPage
  include PageObject

  element(:hamburger_menu, xpath: "//section[@class='title']//button//*[local-name()='svg']")
  list_items(:drilled_ham_menu, xpath: "//ul[1]//li")

  def tap_hamburger_menu
    hamburger_menu_element.click
    sleep 1 #too fast pausing for screenshot
  end

  def select_nav_section(section)
    drilled_ham_menu_elements.each do |xsection|
      xsection.click if xsection.text.strip === section.strip
    end
  end
end
