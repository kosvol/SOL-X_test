# frozen_string_literal: true

require_relative 'base_page'

# Navigation Drawer object
class NavigationDrawerPage < BasePage
  include EnvUtils
  NAVIGATION = {
    heading_text: "//nav[starts-with(@class,'NavigationDrawer__Drawer')]",
    menu_categories: "//a[starts-with(@class,'NavigationDrawer__DrawerLink')]",
    category: "//a[contains(text(),'%s')]",
    settings_btn: "//a[contains(text(),'Settings')]",
    back_arr: "//button[@aria-label='Go back']",
    go_back_btn: "//*[@id='root']/div/nav/header/button",
    view_button: "//button[contains(text(),'View')]",
    entry_states: "(//a[contains(.,'%s')])/parent::li",
    menu_show_more: "//button[contains(.,'Show More')]",
    menu_show_less: "//button[contains(.,'Show Less')]",
    ptw: "//h3[contains(., 'Permit to Work')]/following::li[contains(., '%s')]",
    pre: "//h3[contains(., 'Pump Room Entry')]/following::li[contains(., '%s')]",
    entry: "//h3[contains(., 'Entry')]/following::li[contains(., '%s')]",
    dashboard: "//li[contains(., '%s')]"
  }.freeze

  def initialize(driver)
    super
    find_element(NAVIGATION[:heading_text])
    sleep 1.5
  end

  def verify_base_menu
    menu_categories = YAML.load_file('data/menu.yaml')['Menu base']
    menu_elements = @driver.find_elements(:xpath, NAVIGATION[:menu_categories])
    menu_elements.each_with_index do |element, index|
      compare_string(menu_categories[index], element.text)
    end
  end

  def click_back_arrow
    click(NAVIGATION[:back_arr])
  end

  def click_go_back
    click(NAVIGATION[:go_back_btn])
  end

  def click_settings_btn
    click(NAVIGATION[:settings_btn])
  end

  def click_view_button
    click(NAVIGATION[:view_button])
  end

  def expand_all_menu_items
    find_element(NAVIGATION[:heading_text])
    scroll_click(NAVIGATION[:menu_show_more])
    scroll_click(NAVIGATION[:menu_show_more])
  end

  def hide_menu_items
    scroll_click(NAVIGATION[:menu_show_less])
    scroll_click(NAVIGATION[:menu_show_less])
  end

  def navigate_to_ptw(page)
    link = format(NAVIGATION[:ptw], page)
    click(link.to_s)
  end

  def navigate_to_entry(page)
    link = format(NAVIGATION[:entry], page)
    click(link.to_s)
  end

  def navigate_to_dashboard(page)
    link = format(NAVIGATION[:dashboard], page)
    click(link.to_s)
  end
end
