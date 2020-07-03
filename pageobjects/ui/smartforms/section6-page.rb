# frozen_string_literal: true

require './././support/env'

class Section6Page
  include PageObject

  # element(:heading_text, xpath: "//form[starts-with(@class,'FormFactory__Form')]/section/h2")
  button(:save_and_next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button")
  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  buttons(:submit_btn, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer')]/button")
  # text_field(:ship_approval, xpath: '//input[@id="shipsApproval"]')
  # text_field(:office_approval, xpath: '//input[@id="officeApproval"]')

  def toggle_to_section(_select_permit, _which_section)
    # if ['Hot Work Level-2 outside E/R (Ballast Passage)', 'Hot Work Level-2 outside E/R (Loaded Passage)', 'Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage)'].include? _select_permit
    #   x = 8
    # else
    #   x = 9
    # end
    case _which_section
    when '6'
      x = 9
    when '4a'
      x = 5
    end
    (1..x).each do |_i|
      sleep 1
      next_btn
    end
  end
end
