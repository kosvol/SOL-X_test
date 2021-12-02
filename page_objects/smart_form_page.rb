# frozen_string_literal: true

require_relative 'base_page'
require_relative 'pin_entry_page'
require_relative 'signature_location_page'

# SmartFormsPage object
class SmartFormsPage < BasePage
  include EnvUtils

  SMART_FORMS = {
    click_create_permit_btn: "//button[contains(.,'Create Permit To Work')]",
    create_new_pre_btn: "//span[contains(.,'Pump Room')]",
    create_new_cre_btn: "//span[contains(.,'Compressor/Motor')]",
    hamburger_menu_btn: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button",
    show_more_btn: "//button[contains(text(),'Show More')]",
    menu_categories: "(//a[starts-with(@class,'NavigationDrawer__DrawerLink')])",
    category: "//a[contains(text(),'%s')]",
    settings_btn: "//a[contains(text(),'Settings')]",
    main_page: "//*[@id='root']/div/main",
    pump_room_display_setting: "//span[contains(.,'Pump Room')]",
    compressor_room_display_setting: "//span[contains(.,'Compressor/Motor Room')]"
  }.freeze

  def open_page
    @driver.get(retrieve_env_url)
    find_element(SMART_FORMS[:hamburger_menu_btn])
  end

  def click_create_permit_to_work
    scroll_click(SMART_FORMS[:click_create_permit_btn])
  end

  def click_create_new_pre_btn
    click(SMART_FORMS[:create_new_pre_btn])
  end

  def click_create_new_cre_btn
    click(SMART_FORMS[:create_new_cre_btn])
  end

  def click_hamburger_menu_btn
    click(SMART_FORMS[:hamburger_menu_btn])
  end

  def click_show_more_btn(which_category)
    if which_category.downcase == 'forms'
      @driver.find_elements(:xpath, SMART_FORMS[:show_more_btn]).first.click
    else
      @driver.find_elements(:xpath, SMART_FORMS[:show_more_btn]).last.click
    end
  end

  def verify_base_menu
    menu_categories = YAML.load_file('data/menu.yml')['Menu base']
    menu_elements = @driver.find_elements(:xpath, SMART_FORMS[:menu_categories])
    menu_elements.each_with_index do |element, index|
      compare_string(menu_categories[index], element.text)
    end
  end

  def navigate_to_page(page, category)
    select_category(page, category)
  rescue StandardError
    click_show_more(page) if category.downcase != 'settings'
    select_category(page, category)
  end

  def wait_until_permit_activate(permit_type)
    attempt = 0
    until return_background_color == 'rgba(67, 160, 71, 1)'
      navigate_to_display_page(permit_type)
      enter_pin('C/O')
      sign_off_first_zone_area
      attempt += 1
      break if attempt == 6
    end
  end

  private

  def navigate_to_display_page(permit_type)
    click_hamburger_menu_btn
    navigate_to_page('Settings', 'setting')
    click(SMART_FORMS[:pump_room_display_setting]) if permit_type.downcase == 'pre'
    click(SMART_FORMS[:compressor_room_display_setting]) if permit_type.downcase == 'cre'
  end

  def return_background_color
    find_element(SMART_FORMS[:main_page]).css_value('background-color')
  end

  def select_category(page, category)
    case category.downcase
    when 'pre', 'cre'
      category_objs = find_elements(format(SMART_FORMS[:category], page))
      category_objs.size == 2 ? category_objs.last.click : category_objs.first.click
    when 'settings'
      click(SMART_FORMS[:settings_btn])
    else
      click(format(SMART_FORMS[:category], page))
    end
  end
end
