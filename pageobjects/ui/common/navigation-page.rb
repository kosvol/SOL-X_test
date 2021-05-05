# frozen_string_literal: true

require './././support/env'

class NavigationPage < CommonFormsPage
  include PageObject

  button(:hamburger_menu, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button")
  elements(:menu_categories, xpath: "(//a[starts-with(@class,'NavigationDrawer__DrawerLink')])")
  buttons(:show_more, xpath: "//button[contains(text(),'Show More')]")
  buttons(:save_and_next_btn, xpath: "//button[contains(.,'Save & Next')]")
  button(:next_btn, xpath: "//button[contains(.,'Next')]")
  @@menu_categories_base = ["SmartForms","Created","Pending Approval","Updates Needed","Active","Pending Withdrawal","Withdrawn","Deleted","Created","Pending Approval","Updates Needed","Active","Scheduled","Terminated","Deleted","Settings"]
  @@which_category = "//a[contains(text(),'%s')]"

  def click_hamburger_menu
    BrowserActions.poll_exists_and_click(hamburger_menu_element)
  end

  def get_menu_categories
    @@menu_categories_base
  end

  def toggle_to_section(_which_section)
    (1..get_total_steps_to_section6(_which_section)).each do |_i|
      click_next
    end
  end

  def select_nav_category(_category,_which_category)
    sleep 1
    begin
      click_nav_category(_category,_which_category)
    rescue
      click_show_more(_which_category) if _category != "Settings"
      click_nav_category(_category,_which_category)
    end
  end

  def click_show_more(_which_category)
    _which_category === "forms" ? BrowserActions.poll_exists_and_click(show_more_elements.first) : BrowserActions.poll_exists_and_click(show_more_elements.last)
  end

  def click_next
    sleep 1
    BrowserActions.js_click("//button[contains(.,'Next')]")
  rescue StandardError
    BrowserActions.js_click("//button[contains(.,'Save & Next')]")
  end

  def get_total_steps_to_section6(_which_section)
    case _which_section
    when '6'
      10
    when '7'
      11
    when '7b'
      12
    when '8'
      13
    when '4a'
      6
    when '3a'
      2
    when '3b'
      3
    when '3c'
      4
    when '3d'
      5
    when '4b'
      8
    when '5'
      9
    when '2'
      1
    end
  end

  private
  
  def click_nav_category(_category,_which_category)
    if _which_category === "forms"
      @browser.find_element(:xpath, @@which_category%[_category]).click
    elsif (_which_category === "PRE" || _which_category === "CRE")
      category_objs = @browser.find_elements(:xpath, @@which_category%[_category])
      category_objs.size === 2 ? category_objs.last.click : category_objs.first.click
    elsif _which_category === "setting"
      BrowserActions.js_click("//a[contains(text(),'Settings')]")
      # @browser.execute_script(%(document.evaluate("//a[contains(text(),'Settings')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
    else
      @browser.find_element(:xpath, @@which_category%[_category]).click
    end
  end

end
