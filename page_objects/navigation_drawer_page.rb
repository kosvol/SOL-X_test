# frozen_string_literal: true

require_relative 'base_page'

# Navigation Drawer object
class NavigationDrawerPage < BasePage
  include EnvUtils
  NAVIGATION = {
    heading_text: "//nav[starts-with(@class,'NavigationDrawer__Drawer')]",
    show_more_btn: "//button[contains(text(),'Show More')]",
    menu_categories: "(//a[starts-with(@class,'NavigationDrawer__DrawerLink')])",
    category: "//a[contains(text(),'%s')]",
    settings_btn: "//a[contains(text(),'Settings')]",
    main_page: "//*[@id='root']/div/main",
    back_arrow: "//button/*[@data-testid='arrow']",
    back_arr: "//button/*[@aria-label='Go back']",
    go_back_btn: "//*[@id='root']/div/nav/header/button",
    view_button: "//button[contains(text(),'View')]",
    entry_states: "(//a[contains(.,'%s')])/parent::li",
    entry_show_more: "(//*[contains(.,'Show More')][2])",
    show_more: "//button[starts-with(@class,'CollapsibleButton__Button')][2]"
  }.freeze

  def initialize(driver)
    super
    find_element(NAVIGATION[:heading_text])
  end

  def click_show_more_btn(which_category)
    if which_category.downcase == 'forms'
      @driver.find_elements(:xpath, NAVIGATION[:show_more_btn]).first.click
    else
      @driver.find_elements(:xpath, NAVIGATION[:show_more_btn]).last.click
    end
  end

  def verify_base_menu
    menu_categories = YAML.load_file('data/menu.yaml')['Menu base']
    menu_elements = @driver.find_elements(:xpath, NAVIGATION[:menu_categories])
    menu_elements.each_with_index do |element, index|
      compare_string(menu_categories[index], element.text)
    end
  end

  def navigate_to_ptw(page)
    click_show_more_btn('forms')
    select_ptw_cat(page)
  end

  def navigate_to_entry(state)
    scroll_click(NAVIGATION[:show_more])
    click(NAVIGATION[:entry_states] % state)
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

  private

  def return_background_color
    find_element(NAVIGATION[:main_page]).css_value('background-color')
  end

  def select_ptw_cat(page)
    click(format(NAVIGATION[:category], page))
  end
end
