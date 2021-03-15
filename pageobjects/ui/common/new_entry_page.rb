require './././support/env'

class NewEntryPage < PreDisplay
  include PageObject

  element(:input_field, xpath: "//div[starts-with(@class,'Input')]")
  element(:entrant_select_btn, xpath: "//span[contains(text(),'Select Entrants - Required')]")
  @@entrants_arr = []
  elements(:person_checkbox, xpath: "//div[@class='checkbox']")
  element(:confirm_btn, xpath: "//span[contains(text(),'Confirm')]")
  element(:send_report, xpath: "//span[contains(text(),'Send Report')]")
  buttons(:send_report_btn, xpath: "//button[contains(.,\"Send Report\")]")
  buttons(:checkbox_text, xpath: "//li[@class='button']")

  def select_entrants(entrants)
    while entrants > 0
      person_checkbox_elements[entrants].click
      entrants = entrants - 1
    end
  end

  def entrants(entrants)
    while entrants > 0
      member_name_btn_elements[entrants].click
      entrants = entrants - 1
    end
  end

  def set_entrants(entrants)
    @@entrants_arr = entrants
  end

  def get_entrants()
    @@entrants_arr
  end

  def save_entrants_to_file(entrants)
    entr_arr = []
    while entrants > 0
      entr_arr.push($browser.
        find_element(:xpath,
                     "//*[starts-with(@class,'UnorderedList')]/li[#{entrants+1}]/button").text)
      entrants = entrants - 1
    end
    p "first"
    p entr_arr.to_s
    set_entrants(entr_arr)
  end

  def save_to_file(entrants, name)
    File.delete(name) if File.exist?(name)
    file = File.join(File.dirname('../tmp'), name)
    File.open(file, 'w') { |f| f.puts entrants }
  end
end