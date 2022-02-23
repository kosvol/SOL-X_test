# frozen_string_literal: true

require_relative 'base_page'

# DRAPage object
class DRAPage < BasePage
  include EnvUtils
  DRA = {
    section_header: "//h3[contains(.,'DRA - Edit Method & Hazards')]",
    likelihood_btn: "//div[starts-with(@class,'RiskCalculator__Container-')]/div[1]/div/button",
    consequence_btn: "//div[starts-with(@class,'RiskCalculator__Container-')]/div[2]/div/button",
    ddl_option: "(//*[starts-with(@class,'UnorderedList')]/li/button)[%s]",
    confirm_btn: "//button[contains(.,'Confirm')]",
    risk_indicator: "//*[starts-with(@class,'RiskIndicator')]",
    residual_risks: '//*[@class="indicator-wrapper"]/div',
    addition_measures: "//button[contains(.,'Add Additional Measures')]",
    additional_measures_textarea: '//textarea[@placeholder="Enter additional measures"]',
    save_dra_btn: "//button[contains(., 'Save DRA')]",
    delete_btn: "//button[contains(., 'Delete')]",
    add_hazard: "//button[contains(., 'Add Hazard')]",
    extra_hazard_textarea: '(//*[@placeholder="Enter hazard description"])[last()]'
  }.freeze

  def initialize(driver)
    super
    find_element(DRA[:section_header])
  end

  def select_likelihood(type, likelihood)
    likelihood_elements = find_elements(DRA[:likelihood_btn])
    element_index = retrieve_element_index(type)
    @driver.execute_script('arguments[0].scrollIntoView({block: "center", inline: "center"})',
                           likelihood_elements[element_index])
    likelihood_elements[element_index].click
    scroll_click(DRA[:ddl_option] % likelihood) unless option_active?(likelihood)
    click(DRA[:confirm_btn])
  end

  def select_consequence(type, consequence)
    element_index = retrieve_element_index(type)
    consequence_elements = find_elements(DRA[:consequence_btn])
    consequence_elements[element_index].location_once_scrolled_into_view
    consequence_elements[element_index].click
    scroll_click(DRA[:ddl_option] % consequence) unless option_active?(consequence)
    click(DRA[:confirm_btn])
  end

  def edit_hazards(type, likelihood, consequence)
    if type == 'Additional Control Measures'
      scroll_click(DRA[:addition_measures])
      sleep 0.5
    end
    select_likelihood(type, likelihood)
    select_consequence(type, consequence)
  end

  def verify_risk_indicator(type, expected)
    element_index = retrieve_element_index(type)
    risk_indicator_elements = find_elements(DRA[:risk_indicator])
    compare_string(expected, risk_indicator_elements[element_index].text)
  end

  def verify_residual_risk(without_measures, after_measures, residual_risk)
    elements = find_elements(DRA[:residual_risks])
    compare_string(without_measures, elements[0].text)
    compare_string(after_measures, elements[1].text)
    compare_string(residual_risk, elements[2].text)
  end

  def add_additional_measures
    scroll_click(DRA[:addition_measures])
    sleep 1 # to prevent ui failed
    find_element(DRA[:additional_measures_textarea]).send_keys('Test Automation')
  end

  def save_dra
    scroll_click(DRA[:save_dra_btn])
  end

  def verify_measures_text
    actual_text = @driver.find_element(:xpath, DRA[:additional_measures_textarea]).attribute('value')
    compare_string('Test Automation', actual_text)
  end

  def delete_hazard
    element = find_element(DRA[:delete_btn])
    @driver.execute_script('arguments[0].scrollIntoView({block: "center", inline: "center"})', element)
    element.click
    click("//*[starts-with(@class,'ConfirmationModal')]/div/button[2]")
  end

  def verify_hazard_deleted
    actual_first_hazard = retrieve_text('(//label[@data-testid="identified-hazard"])[1]')
    compare_string('Personal injury', actual_first_hazard)
  end

  def add_extra_hazard
    scroll_click(DRA[:add_hazard])
    sleep 1 # to prevent ui failed
    find_element(DRA[:extra_hazard_textarea]).send_keys('Test Automation')
  end

  def verify_extra_hazard
    actual_text = @driver.find_element(:xpath, DRA[:extra_hazard_textarea]).attribute('value')
    compare_string('Test Automation', actual_text)
  end

  private

  def retrieve_element_index(type)
    case type
    when 'Without Applying Measures'
      0
    when 'Existing Control Measures'
      1
    when 'Additional Control Measures'
      2
    else
      "#{type} is not supported"
    end
  end

  def option_active?(index)
    find_element("(//*[starts-with(@class,'UnorderedList')]/li)[#{index}]").attribute('class').to_s == 'active'
  end
end
