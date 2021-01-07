# frozen_string_literal: true

require './././support/env'

class NavigationPage
  include PageObject

  button(:hamburger_menu, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button")
  elements(:menu_categories, xpath: "(//a[starts-with(@class,'NavigationDrawer__DrawerLink')])")
  buttons(:show_more, xpath: "//button[contains(text(),'Show More')]")
  @@menu_categories_base = ["SmartForms","Created","Pending Approval","Updates Needed","Active","Pending Withdrawal","Withdrawn","Deleted","Created","Pending Approval","Updates Needed","Active","Scheduled","Terminated","Deleted","Settings"]
  @@which_category = "//a[contains(text(),'%s')]"
  # @@root_PRE = "//h3[contains(text(),'Pump Room Entry')]/following::a[contains(text(),'%s')]"

  def get_menu_categories
    @@menu_categories_base
  end
  ##### to refactor

  # def select_pre_nav_category(_category)#, pre = false, show_more = false)
  #   # unless @already_opened_show_more_for_pre
  #     # if show_more and pre
  #       # @already_opened_show_more_for_pre = true
  #       sleep 1
        
  # end
    # unless @already_opened_show_more
    #   if show_more and !pre
    #     @already_opened_show_more = true
    #     @browser.find_elements(:xpath, @@show_more)[0].click
    #     sleep 1
    #   end
    # end

    # if !pre
    #   @browser.find_element(:xpath, @@setting_link%[_category]).click
    # else
    #   @browser.find_element(:xpath, @@root_PRE%[_category]).click
    # end
  # end

  def select_nav_category(_category,_which_category)
    sleep 1
    begin
      click_nav_category(_category,_which_category)
    rescue
      click_show_more(_which_category)
      click_nav_category(_category,_which_category)
    end
  end

  def click_show_more(_which_category)
    _which_category === "forms" ? BrowserActions.poll_exists_and_click(show_more_elements.first) : BrowserActions.poll_exists_and_click(show_more_elements.last)
  end

  private
  
  def click_nav_category(_category,_which_category)
    if _which_category === "forms"
      @browser.find_element(:xpath, @@which_category%[_category]).click
    elsif _which_category === "PRE"
      category_objs = @browser.find_elements(:xpath, @@which_category%[_category])
      category_objs.size === 2 ? category_objs.last.click : category_objs.first.click
    else
      @browser.find_element(:xpath, @@which_category%[_category]).click
    end
  end

end
