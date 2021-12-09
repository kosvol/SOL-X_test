# frozen_string_literal: true

require_relative 'base_page'
require_relative 'pin_entry_page'
require_relative 'signature_location_page'

# SmartFormsPage object
class NavigationDrawerPage < BasePage
  include EnvUtils
  NAVIGATION_PAGE = {
    heading_text: "//*[@id='root']/div/nav/header",
    hamburger_menu_btn: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button",
    show_more_btn: "//button[contains(text(),'Show More')]",
    menu_categories: "(//a[starts-with(@class,'NavigationDrawer__DrawerLink')])",
    category: "//a[contains(text(),'%s')]",
    settings_btn: "//a[contains(text(),'Settings')]",
    main_page: "//*[@id='root']/div/main",
    pump_room_display_setting: "//span[contains(.,'Pump Room')]",
    compressor_room_display_setting: "//span[contains(.,'Compressor/Motor Room')]",
    back_arrow: "//button/*[@data-testid='arrow']",
    go_back_btn: "//*[@id='root']/div/nav/header/button"
  }.freeze

  def initialize(driver)
    super
    find_element(NAVIGATION_PAGE[:heading_text])
  end

  def click_hamburger_menu_btn
    click(NAVIGATION_PAGE[:hamburger_menu_btn])
  end

  def click_show_more_btn(which_category)
    if which_category.downcase == 'forms'
      @driver.find_elements(:xpath, NAVIGATION_PAGE[:show_more_btn]).first.click
    else
      @driver.find_elements(:xpath, NAVIGATION_PAGE[:show_more_btn]).last.click
    end
  end

  def verify_base_menu
    menu_categories = YAML.load_file('data/menu.yml')['Menu base']
    menu_elements = @driver.find_elements(:xpath, NAVIGATION_PAGE[:menu_categories])
    menu_elements.each_with_index do |element, index|
      compare_string(menu_categories[index], element.text)
    end
  end

  def navigate_to_ptw(page)
    click_show_more_btn('forms')
    select_ptw_cat(page)
  end

  def navigate_to_settings
    select_settings_cat
  end

  def navigate_to_pre(page)
    click_show_more_btn('pre')
    select_pre_cre_cat(page)
  end

  def navigate_to_cre(page)
    click_show_more_btn('cre')
    select_pre_cre_cat(page)
  end

  def navigate_until_active_ptw(permit_type)
    attempt = 0
    until return_background_color == 'rgba(67, 160, 71, 1)'
      navigate_to_display_page(permit_type)
      enter_pin('C/O')
      sign_off_first_zone_area
      attempt += 1
      break if attempt == 6
    end
  end

  def click_back_arrow
    click(NAVIGATION_PAGE[:back_arrow])
  end

  def click_go_back
    click(NAVIGATION_PAGE[:go_back_btn])
  end

  private

  def navigate_to_display_page(permit_type)
    click_hamburger_menu_btn
    navigate_to_settings
    click(NAVIGATION_PAGE[:pump_room_display_setting]) if permit_type.downcase == 'pre'
    click(NAVIGATION_PAGE[:compressor_room_display_setting]) if permit_type.downcase == 'cre'
  end

  def return_background_color
    find_element(NAVIGATION_PAGE[:main_page]).css_value('background-color')
  end

  def select_pre_cre_cat(page)
    category_objs = find_elements(format(NAVIGATION_PAGE[:category], page))
    category_objs.size == 2 ? category_objs.last.click : category_objs.first.click
  end

  def select_settings_cat
    click(NAVIGATION_PAGE[:settings_btn])
  end

  def select_ptw_cat(page)
    click(format(NAVIGATION_PAGE[:category], page))
  end
end
