require './././support/env'

class NewEntryPage < PreDisplay
  include PageObject

  element(:input_field, xpath: "//div[starts-with(@class,'Input')]")
  element(:entrant_select_btn, xpath: "//span[contains(text(),'Select Entrants - Required')]")
  @@button = "//button[contains(.,'%s')]"
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

  def save_entrants(entrants)
    entr_arr = Array.new(entrants)
    while entrants > 0
      entr_arr.push(checkbox_text_elements[entrants].text)
      entrants = entrants - 1
    end
    p entr_arr[0]
    p entr_arr[1]
    p entr_arr[2]
    p entr_arr[3]

  end

end