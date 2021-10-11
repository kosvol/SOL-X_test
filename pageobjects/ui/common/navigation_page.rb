# frozen_string_literal: true

require './././support/env'

class NavigationPage < CommonFormsPage
  include PageObject

  button(:hamburger_menu, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button")
  elements(:menu_categories, xpath: "(//a[starts-with(@class,'NavigationDrawer__DrawerLink')])")
  buttons(:show_more, xpath: "//button[contains(text(),'Show More')]")
  buttons(:save_and_next_btn, css: 'button.next')
  button(:previous_btn, xpath: "//button[contains(.,'Previous')]")
  button(:next_btn, xpath: "//button[contains(.,'Next')]")
  @@menu_categories_base = ['SmartForms', 'Created', 'Pending Approval', 'Updates Needed', 'Active',
                            'Pending Withdrawal', 'Withdrawn', 'Deleted', 'Created', 'Pending Approval',
                            'Updates Needed', 'Active', 'Scheduled', 'Terminated', 'Deleted', 'Settings']
  @@which_category = "//a[contains(text(),'%s')]"

  def click_hamburger_menu
    BrowserActions.poll_exists_and_click(hamburger_menu_element)
  end

  def get_menu_categories
    @@menu_categories_base
  end

  def toggle_to_section(which_section)
    (1..get_total_steps_to_section6(which_section)).each do |_i|
      click_next
    end
  end

  def select_nav_category(category, which_category)
    sleep 1
    begin
      click_nav_category(category, which_category)
    rescue StandardError
      click_show_more(which_category) if category != 'Settings'
      click_nav_category(category, which_category)
    end
  end

  def click_show_more(which_category)
    if which_category == 'forms'
      BrowserActions.poll_exists_and_click(show_more_elements.first)
    else
      BrowserActions.poll_exists_and_click(show_more_elements.last)
    end
  end

  def click_next
    sleep 1
    BrowserActions.poll_exists_and_click(next_btn_button)
  rescue StandardError
    sleep 1
    @browser.find_element(:xpath, "//button[contains(.,'Next')]").click
  rescue StandardError
    BrowserActions.js_click("//button[contains(.,'Next')]")
  end

  def click_new_or_previous(condition, times)
    sleep 1
    index = 1
    while index <= times.to_i
      # condition == 'next' ? click_next : BrowserActions.js_click("//button[contains(.,'Previous')]")
      condition == 'next' ? click_next : BrowserActions.poll_exists_and_click(previous_btn_button)
      index += 1
    end
  end

  def click_back_home
    sleep 2
    BrowserActions.poll_exists_and_click(back_to_home_btn_element)
  rescue StandardError
    sleep 1
    @browser.find_element(:xpath, "//button[contains(.,'Back to')]").click
  rescue StandardError
    @browser.find_element(:xpath, "//button[contains(.,'Home')]").click
  end

  def get_total_steps_to_section6(which_section)
    case which_section
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
    else
      raise "Wrong section number >>> #{which_section}"
    end
  end

  private

  def click_nav_category(category, which_category)
    case which_category
    when 'forms'
      @browser.find_element(:xpath, format(@@which_category, category)).click
    when 'PRE', 'CRE'
      category_objs = @browser.find_elements(:xpath, format(@@which_category, category))
      category_objs.size == 2 ? category_objs.last.click : category_objs.first.click
    when 'setting'
      BrowserActions.js_click("//a[contains(text(),'Settings')]")
    else
      @browser.find_element(:xpath, format(@@which_category, category)).click
    end
  end
end