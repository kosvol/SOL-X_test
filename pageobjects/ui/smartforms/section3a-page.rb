# frozen_string_literal: true

require './././support/env'

class Section3APage < Section2Page
  include PageObject

  button(:view_edit_btn, xpath: "//button[contains(.,'View/Edit Hazards')]")
  element(:add_hazard_btn, xpath: "//span[contains(.,'Add Hazard')]")
  buttons(:add_additional_measure_btn, xpath: "//button[contains(.,'Add Additional Measures')]")
  buttons(:delete_btn, xpath: "//button[contains(.,'Delete')]")
  button(:save_and_close, xpath: "//button[contains(.,'Save DRA')]")
  buttons(:confirm_btn, xpath: "//button[contains(.,'Confirm')]")
  buttons(:add_measure_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div[7]/div/button")
  # button(:add_hazard_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/button")
  text_areas(:description, xpath: "//div[starts-with(@class,'Textarea__Container')]/textarea")
  # button(:save_and_close, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer-')]/button")
  buttons(:date_and_time_fields, xpath: "//button[@id='draCreatedDate']")
  spans(:likelihood, xpath: "//span[@data-testid='likelihood']")
  spans(:consequence, xpath: "//span[@data-testid='consequence']")
  elements(:risk_indicator, xpath: "//div[starts-with(@class,'RiskIndicator__Indicator')]")
  @@risk_indicator = "//div[starts-with(@class,'RiskIndicator__Indicator')]"
  buttons(:likelihood_btn, xpath: "//div[starts-with(@class,'RiskCalculator__Container-')]/div[1]/div/button")
  buttons(:consequence_btn, xpath: "//div[starts-with(@class,'RiskCalculator__Container-')]/div[2]/div/button")
  elements(:level_to_choose, xpath: "//div[starts-with(@class,'ComboBoxWithButtons__Content-')]/div[starts-with(@class,'items')][1]/ul[1]/li/button")
  buttons(:cancel_btn, xpath: "//div[starts-with(@class,'ComboBoxWithButtons__Content-')]/div[starts-with(@class,'buttons')][1]/button[1]")
  # buttons(:confirm_btn, xpath: "//div[starts-with(@class,'ComboBoxWithButtons__Content-')]/div[starts-with(@class,'buttons')][1]/button[2]")
  # elements(:identified_hazard_row, xpath: "//div[starts-with(@class,'row-wrapper')]")
  elements(:identified_hazard_name, xpath: "//label[@data-testid='identified-hazard']")

  def is_additional_hazard_saved
    view_edit_btn
    description_elements[2].text === 'Test Automation'
  end

  def add_new_hazard
    view_edit_btn
    sleep 1
    BrowserActions.scroll_down_by_custom_dist(800)
    multiple_scroll(12)
    sleep 3
    add_hazard_btn_element.click
    BrowserActions.scroll_up_by_custom_dist(-400)
    BrowserActions.enter_text(description_elements.last, 'Test Automation')
    BrowserActions.enter_text(description_elements[(description_elements.size - 2)], 'Test Automation')
    sleep 1
    toggle_likelihood_consequence_matrix_add_hazard(1, 1)

    save_and_close
  end

  def is_new_hazard_added?
    (description_elements.last.text === 'Test Automation') && (description_elements[(description_elements.size - 2)].text === 'Test Automation')
  end

  def toggle_likelihood_consequence_matrix_add_hazard(_likelihood, _consequence)
    # for without applying measure
    likelihood_btn_elements[(likelihood_btn_elements.size - 2)].click
    sleep 1
    level_to_choose_elements[80].click
    confirm_btn_elements[16].click
    sleep 1
    consequence_btn_elements[(consequence_btn_elements.size - 2)].click
    sleep 1
    level_to_choose_elements[85].click
    confirm_btn_elements[17].click
    sleep 1

    multiple_scroll(2)
    # for existing control measure
    likelihood_btn_elements.last.click
    sleep 1
    level_to_choose_elements[90].click
    confirm_btn_elements[18].click
    sleep 1
    consequence_btn_elements.last.click
    sleep 1
    level_to_choose_elements[95].click
    confirm_btn_elements[19].click
  end

  def add_additional_hazard
    sleep 1
    view_edit_btn
    toggle_likelihood_consequence_matrix_addition_hazard(1, 1)
    BrowserActions.enter_text(description_elements[2], 'Test Automation')
    save_and_close
  end

  def toggle_likelihood_consequence_matrix_without_applying_measure(_likelihood, _consequence)
    view_edit_btn
    sleep 1
    BrowserActions.scroll_down
    sleep 1
    likelihood_btn_elements.first.click
    sleep 1
    level_to_choose_elements[(_likelihood.to_i - 1)].click
    confirm_btn_elements.first.click
    sleep 1
    consequence_btn_elements.first.click
    sleep 1
    level_to_choose_elements[(_consequence.to_i + 4)].click
    confirm_btn_elements[1].click
  end

  def toggle_likelihood_consequence_matrix_existing_control_measure(_likelihood, _consequence)
    view_edit_btn
    sleep 1
    multiple_scroll(3)
    sleep 1
    likelihood_btn_elements[1].click
    sleep 1
    level_to_choose_elements[(_likelihood.to_i + 9)].click
    confirm_btn_elements[2].click
    sleep 1
    consequence_btn_elements[1].click
    sleep 1
    level_to_choose_elements[(_consequence.to_i + 14)].click
    confirm_btn_elements[3].click
  end

  def toggle_likelihood_consequence_matrix_addition_hazard(_likelihood, _consequence)
    # view_edit_btn
    sleep 1
    multiple_scroll(2)
    sleep 1
    add_additional_measure_btn_elements.first.click
    BrowserActions.scroll_down
    sleep 1
    likelihood_btn_elements[2].click
    sleep 1
    level_to_choose_elements[((level_to_choose_elements.size - 11) + _likelihood.to_i)].click
    confirm_btn_elements[confirm_btn_elements.size - 2].click
    sleep 1
    consequence_btn_elements[2].click
    sleep 1
    level_to_choose_elements[((level_to_choose_elements.size - 6) + _consequence.to_i)].click
    confirm_btn_elements.last.click
  end

  def is_risk_indicator_green?(_measure)
    risk_indicators = $browser.find_elements(:xpath, "//div[starts-with(@class,'RiskIndicator__Indicator-')]")
    case _measure
    when 'without applying measure'
      risk_indicators[0].css_value('background-color') === 'rgba(118, 210, 117, 1)'
    when 'existing control measure'
      risk_indicators[1].css_value('background-color') === 'rgba(118, 210, 117, 1)'
    when 'additional hazard'
      risk_indicators[2].css_value('background-color') === 'rgba(118, 210, 117, 1)'
    end
  end

  def is_risk_indicator_yellow?(_measure)
    risk_indicators = $browser.find_elements(:xpath, "//div[starts-with(@class,'RiskIndicator__Indicator-')]")
    case _measure
    when 'without applying measure'
      risk_indicators[0].css_value('background-color') === 'rgba(242, 204, 84, 1)'
    when 'existing control measure'
      risk_indicators[1].css_value('background-color') === 'rgba(242, 204, 84, 1)'
    when 'additional hazard'
      risk_indicators[2].css_value('background-color') === 'rgba(242, 204, 84, 1)'
    end
  end

  def is_risk_indicator_red?(_measure)
    risk_indicators = $browser.find_elements(:xpath, "//div[starts-with(@class,'RiskIndicator__Indicator-')]")
    case _measure
    when 'without applying measure'
      risk_indicators[0].css_value('background-color') === 'rgba(216, 75, 75, 1)'
    when 'existing control measure'
      risk_indicators[1].css_value('background-color') === 'rgba(216, 75, 75, 1)'
    when 'additional hazard'
      risk_indicators[2].css_value('background-color') === 'rgba(216, 75, 75, 1)'
    end
  end

  def is_risk_indicator_veryred?(_measure)
    risk_indicators = $browser.find_elements(:xpath, "//div[starts-with(@class,'RiskIndicator__Indicator-')]")
    case _measure
    when 'without applying measure'
      risk_indicators[0].css_value('background-color') === 'rgba(160, 16, 35, 1)'
    when 'existing control measure'
      risk_indicators[1].css_value('background-color') === 'rgba(160, 16, 35, 1)'
    when 'additional hazard'
      risk_indicators[2].css_value('background-color') === 'rgba(160, 16, 35, 1)'
    end
  end

  def evaluation_matrix(color, _color1, _color2)
    risk_indicators = $browser.find_elements(:xpath, "//div[starts-with(@class,'RiskIndicator__Indicator-')]")
    risk_indicators[risk_indicators.size - 3].css_value('background-color') === get_color_code(color)
    risk_indicators[risk_indicators.size - 2].css_value('background-color') === get_color_code(_color1)
    risk_indicators[risk_indicators.size - 1].css_value('background-color') === get_color_code(_color2)
  end

  def multiple_scroll(_number_of_times)
    (1.._number_of_times).each do |_i|
      sleep 2
      BrowserActions.scroll_down
    end
  end

  private

  # def click_add_additional_hazard
  #   view_edit_btn
  # rescue StandardError
  # end

  def get_color_code(color)
    case color
    when 'low'
      'rgba(118, 210, 117, 1)'
    when 'medium'
      'rgba(242, 204, 84, 1)'
    when 'high'
      'rgba(216, 75, 75, 1)'
    when 'very high'
      'rgba(160, 16, 35, 1)'
    end
  end
end
