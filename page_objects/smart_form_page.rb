# frozen_string_literal: true

require_relative 'base_page'

# SmartFormsPage object
class SmartFormsPage < BasePage
  include EnvUtils

  SMART_FORMS = {
    click_create_permit_btn: "//button[contains(.,'Create Permit To Work')]",
    create_new_pre_btn: "//span[contains(.,'Pump Room')]",
    create_new_cre_btn: "//span[contains(.,'Compressor/Motor')]",
    hamburger_menu_btn: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button",
    show_more_btn: "//button[contains(text(),'Show More')]",
    menu_categories: "(//a[starts-with(@class,'NavigationDrawer__DrawerLink')])"
  }.freeze

  def open_page
    @driver.get(retrieve_env_url)
  end

  def click_create_permit_to_work
    click(SMART_FORMS[:click_create_permit_btn])
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
    @driver.find_elements(:xpath, SMART_FORMS[:menu_categories]).each_with_index do |element, index|
      compare_string(menu_categories[index], element.text)
    end
  end
end
