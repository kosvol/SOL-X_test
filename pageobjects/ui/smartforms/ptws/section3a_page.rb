# frozen_string_literal: true

require './././support/env'

class Section3APage < Section2Page
  include PageObject

  button(:view_edit_btn, xpath: "//button[contains(.,'View/Edit Hazards')]")
  button(:add_hazard_btn, xpath: "//button[contains(.,'Add Hazard')]")
  buttons(:delete_btn, xpath: "//button[contains(.,'Delete')]")
  button(:save_dra, xpath: "//button[contains(.,'Save DRA')]")
  elements(:add_additional_measure_btn, xpath: "//span[contains(.,'Add Additional Measures')]")

  buttons(:add_measure_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div[7]/div/button")
  text_areas(:description, xpath: "//div[starts-with(@class,'Textarea__Container')]/textarea")
  # to change to generic_data
  elements(:method_detail, xpath: "//p[starts-with(@class,'AnswerComponent__Answer-')]")
  buttons(:date_and_time_fields, xpath: "//button[@id='draCreatedDate']")
  spans(:likelihood, xpath: "//span[@data-testid='likelihood']")
  spans(:consequence, xpath: "//span[@data-testid='consequence']")
  elements(:risk_indicator, xpath: "//div[starts-with(@class,'RiskIndicator__Indicator')]")
  buttons(:likelihood_btn, xpath: "//div[starts-with(@class,'RiskCalculator__Container-')]/div[1]/div/button")
  buttons(:consequence_btn, xpath: "//div[starts-with(@class,'RiskCalculator__Container-')]/div[2]/div/button")
  elements(:active_risk, xpath: "//div[starts-with(@data-testid,'combo-box-with-buttons-sheet')]/div[2]/div/ul/li")
  elements(:options_text, css: 'div.option-text')
  buttons(:cancel_btn,
          xpath: "//div[starts-with(@class,'ComboBoxWithButtons__Content-')]/div[starts-with(@class,'buttons')][1]/button[1]")
  elements(:identified_hazard_name, xpath: "//label[@data-testid='identified-hazard']")

  elements(:ih_details2, xpath: "//div[contains(@class,'row-wrapper')][1]/div[contains(@class,'row-container')]")
  elements(:ecm_details, xpath: "//div[contains(@class,'row-wrapper')][3]/div[contains(@class,'row-container')]")
  elements(:hazard_risk_details, xpath: "//div[contains(@class,'RiskCalculator__Container-')]")
  elements(:hazard_risk_details1, xpath: "//div[contains(@class,'ViewRiskCalculator__ViewContainer')]")

  elements(:hazard_existing_control_details, xpath: "//div[contains(@class,'Hazard__Container')]//textarea")

  elements(:total_textarea, xpath: '//textarea')
  elements(:total_p, xpath: '//p')
  @@add_hazard_btn = "//button/span[contains(.,'Add Hazard')]"

  def navigate_front_back
    BrowserActions.scroll_click(previous_btn_elements.first)
    BrowserActions.scroll_click(next_btn_element)
    BrowserActions.scroll_click(next_btn_element)
    BrowserActions.scroll_click(previous_btn_elements.first)
    sleep 1
  end

  def is_additional_hazard_saved?
    view_edit_btn
    sleep 1
    scroll_multiple_times_with_direction(3, 'down')
    description_elements[2].text == 'Test Automation'
  end

  def is_new_hazard_added?
    p ">> #{ecm_details_elements[10].text}"
    tmp = ih_details2_elements[10].text
    p ">> #{tmp}"
    begin
      p ">> #{hazard_risk_details_elements[23].text}"
      p ">> #{hazard_risk_details_elements[24].text}"
      (tmp == "Test Automation\nDelete" && ecm_details_elements[10]
              .text == "Existing Control Measures\nTest Automation" &&
              hazard_risk_details_elements[23]
              .text == "Likelihood\n1 - Remotely Likely\nConsequence\n1 - Insignificant\nLow Risk" &&
              hazard_risk_details_elements[24]
                .text == "Likelihood\n1 - Remotely Likely\nConsequence\n1 - Insignificant\nLow Risk")
    rescue StandardError
      p ">> #{hazard_risk_details1_elements[23].text}"
      p ">> #{hazard_risk_details1_elements[24].text}"
      (tmp == 'Test Automation' && ecm_details_elements[10]
              .text == "Existing Control Measures\nTest Automation" &&
        hazard_risk_details1_elements[23]
              .text == "Likelihood\n1 - Remotely Likely\nConsequence\n1 - Insignificant\nLow Risk" &&
        hazard_risk_details1_elements[24]
              .text == "Likelihood\n1 - Remotely Likely\nConsequence\n1 - Insignificant\nLow Risk")
    end
  end

  def scroll_to_new_hazard
    tmp = @browser.find_element(:xpath, @@add_hazard_btn)
    BrowserActions.scroll_down(tmp)
    scroll_multiple_times_with_direction(2, 'down')
    sleep 1
  end

  def add_new_hazard
    view_edit_btn
    sleep 2
    scroll_to_new_hazard
    add_hazard_btn
    BrowserActions.enter_text(description_elements.last, 'Test Automation')
    BrowserActions.enter_text(description_elements[(description_elements.size - 2)], 'Test Automation')
    sleep 1
    toggle_likelihood_consequence_matrix_add_hazard(1, 1)
    save_dra
  end

  def toggle_likelihood_consequence_matrix_add_hazard(_likelihood, _consequence)
    # for without applying measure
    # scroll_multiple_times(1)
    # likelihood_btn_elements[(likelihood_btn_elements.size - 2)].click
    # select_dra_risk(1)
    # sleep 1
    # consequence_btn_elements[(consequence_btn_elements.size - 2)].click
    # select_dra_risk(1)
    # sleep 1

    # for existing control measure
    scroll_multiple_times_with_direction(2, 'down')
    likelihood_btn_elements.last.click
    sleep 1
    select_dra_risk(1)
    sleep 1
    consequence_btn_elements.last.click
    sleep 1
    select_dra_risk(1)
  end

  def toggle_likelihood_consequence_matrix_without_applying_measure(likelihood, consequence)
    view_edit_btn
    sleep 2
    BrowserActions.wait_until_is_visible(likelihood_btn_elements[0])
    scroll_multiple_times_with_direction(1, 'down')
    likelihood_btn_elements[0].click
    select_dra_risk(likelihood)
    sleep 1
    consequence_btn_elements[0].click
    select_dra_risk(consequence)
  end

  def toggle_likelihood_consequence_matrix_existing_control_measure(likelihood, consequence)
    view_edit_btn
    sleep 1
    BrowserActions.wait_until_is_visible(likelihood_btn_elements[0])
    scroll_multiple_times_with_direction(3, 'down')
    sleep 1
    likelihood_btn_elements[1].click
    select_dra_risk(likelihood)
    sleep 1
    consequence_btn_elements[1].click
    select_dra_risk(consequence)
  end

  def toggle_likelihood_consequence_matrix_addition_hazard(likelihood, consequence)
    sleep 2
    if @@swap_flag == 'evaluation_matrix'
      scroll_multiple_times_with_direction(1, 'down')
    else
      scroll_multiple_times_with_direction(2, 'down')
    end
    BrowserActions.js_clicks("//span[contains(.,'Add Additional Measures')]", 0)
    scroll_multiple_times_with_direction(2, 'down')
    likelihood_btn_elements[2].click
    select_dra_risk(likelihood)
    consequence_btn_elements[2].click
    select_dra_risk(consequence)
  end

  def risk_indicator_color?(measure, status)
    risk_indicators = @browser.find_elements(:xpath, "//div[starts-with(@class,'RiskIndicator__Indicator-')]")
    base_color = color_code(status)
    case measure
    when 'without applying measure'
      risk_indicators[0].css_value('background-color') == base_color
    when 'existing control measure'
      risk_indicators[1].css_value('background-color') == base_color
    when 'additional hazard'
      risk_indicators[2].css_value('background-color') == base_color
    else
      raise "Wrong measure >>> #{measure}"
    end
  end

  def evaluation_matrix(color, color1, color2)
    risk_indicators = @browser.find_elements(:xpath, "//div[starts-with(@class,'RiskIndicator__Indicator-')]")
    (risk_indicators[risk_indicators.size - 3]
       .css_value('background-color') == color_code(color) && risk_indicators[risk_indicators.size - 2]
        .css_value('background-color') == color_code(color1) && risk_indicators[risk_indicators.size - 1]
         .css_value('background-color') == color_code(color2))
  end

  private

  def color_code(color)
    case color
    when 'low'
      'rgba(118, 210, 117, 1)'
    when 'medium'
      'rgba(242, 204, 84, 1)'
    when 'high'
      'rgba(216, 75, 75, 1)'
    when 'very high'
      'rgba(160, 16, 35, 1)'
    else
      raise "Wrong color >>> #{color}"
    end
  end

  def select_dra_risk(risk)
    sleep 1
    if active_risk_elements[(risk.to_i - 1)].attribute('class').to_s != 'active'
      options_text_elements[(risk.to_i - 1)].click
    end
    confirm_btn_elements.first.click
  end
end
