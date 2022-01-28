# frozen_string_literal: true

require_relative '../base_page'

# Entry display object
class EntryDisplayLog < BasePage
  include EnvUtils

  attr_accessor :entrants, :time

  ENTRY_DISPLAY = {
    heading_text: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3",
    input_field: "//div[starts-with(@class,'Input')]",
    purpose_of_entry: "//textarea[@id='reasonForEntry']",
    entrant_names_dd: "//span[contains(.,'Select Other Entrants - Optional')]",
    header_cell: "//div[starts-with(@class,'header-cell')]",
    list_name: "//div[starts-with(.,'EntrantListItem__ListItem')]",
    show_signature_display: "//button[@data-testid='show-signature-display']",
    sign_out_btn: "//span[contains(text(),'Sign Out')]",
    cross_btn: "//button[contains(@class,'Button__ButtonStyled-')]/span",
    options_text: 'div.option-text',
    clock: '//*[@id="permitActiveAt"]/span',
    confirm_btn: "//button[contains(.,'Confirm')]"
  }.freeze


  def initialize(driver)
    super
    find_element(ENTRY_DISPLAY[:heading_text])
  end

  def signout_entrants_by_order(entrants)
    find_elements(ENTRY_DISPLAY[:sign_out_btn]).first.click
    signout_by_order(entrants)
    self.time = ENTRY_DISPLAY[:clock].text
  end

  def signout_entrants_by_name(entrants)
    find_elements(ENTRY_DISPLAY[:sign_out_btn]).first.click
    signout_by_name(entrants)
    self.time = ENTRY_DISPLAY[:clock].text
  end

  def entered_entrant_listed?(entrant)
    click(ENTRY_DISPLAY[:entrant_names_dd])
    @driver.find_elements(css: ENTRY_DISPLAY[:options_text]).each do |crew|
      return false if entrant == crew.text
    end
    true
  end

  def additional_entrant(entrant_count)
    entrants = []
    click(ENTRY_DISPLAY[:entrant_names_dd])
    add_entrants(entrant_count, entrants)
    self.entrants = entrants
    find_elements(ENTRY_DISPLAY[:confirm_btn]).first.click
  end

  def required_entrants(entrant_count)
    entrants = []
    while entrant_count.positive?
      find_element("//*[starts-with(@class,'UnorderedList')]/li[#{entrant_count + 1}]/label/label/span").click
      new_entrant = find_element("//*[starts-with(@class,'UnorderedList')]/li[#{entrant_count + 1}]/label/div")
                      .text
      entrants.push(new_entrant)
      entrant_count -= 1
    end
    self.entrants = entrants
  end

  private

  def add_entrants(entrant_count, entrants)
    while entrant_count.positive?
      @driver.find_elements(css: ENTRY_DISPLAY[:options_text])[entrant_count].click
      new_entrant = @driver.find_elements(css: ENTRY_DISPLAY[:options_text])[entrant_count].text
      entrants.push(new_entrant)
      entrant_count -= 1
    end
  end

  def signout_by_order(entrants)
    (1..entrants.to_i).each do |i|
      find_elements(ENTRY_DISPLAY[:cross_btn])[i].click
      find_elements(ENTRY_DISPLAY[:sign_out_btn]).last.click
    end
  end

  def signout_by_name(entrants)
    entrants.split(',').each do |i|
      find_element("//*[contains(.,'#{i}')]/button").click
      find_elements(ENTRY_DISPLAY[:sign_out_btn]).last.click
      entrants.delete(i)
    end
  end
end
