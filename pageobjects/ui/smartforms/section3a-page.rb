# frozen_string_literal: true

require './././support/env'

class Section3APage
  include PageObject

  elements(:hazard_cards, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div")
  buttons(:delete_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div[1]/div/button")
  buttons(:add_measure_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div[7]/div/button")
  button(:add_hazard_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/button")
  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  text_fields(:identify_hazard, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div[1]/div/input")
  text_areas(:existing_measure, xpath: "//div[starts-with(@class,'Textarea__Container')]/textarea")
  buttons(:wo_applying_measures_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div[3]/div/div/div/div/button")
  buttons(:existing_control_measure_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/div/div[5]/div/div/div/button")
  elements(:risk_indicator, xpath: "//div[starts-with(@class,'Section__Description')]/div//div//div/div/div[3]")

  def is_dra_contents
    p "size: #{hazard_cards_elements.size}"
    dra_contents = dra_mapping(@@selected_level2_permit)
    get_identify_hazard_name
    get_wo_applying_measure_risk
    get_risk_indicator
    get_existing_measure
    get_existing_control_measure_risk
  end

  private

  def dra_mapping(permit)
    case permit
    when 'Maintenance on Anchor'
      yml_name = '23.Maint on Anchor'
    when 'Maintenance on Emergency Fire Pump'
      yml_name = '20.Maint on Emergency Fire Pump'
    when 'Maintenance on Emergency Generator'
      yml_name = '19.Maint on Emergency Generator'
    when 'Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment'
      yml_name = '27.Maint Emergency Switch Engine'
    when 'Maintenance on Fire Detection Alarm System'
      yml_name = '25.Maint on Fire Detection Alarm System'
    when 'Maintenance on Fixed Fire Fighting System'
      yml_name = '21.Maint on Fixed Fire Fighting System'
    when 'Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel'
      yml_name = '31.Maint Fuel Lub Oil Tank'
    when 'Maintenance on Life/Rescue Boats and Davits'
      yml_name = '36.Maint on Life Boats and Davits'
    when 'Maintenance on Lifeboat Engine'
      yml_name = '22.Maint on Lifeboat Engine'
    when 'Maintenance on Critical Equipment - Magnetic Compass'
      yml_name = '35.Maint on magnetic compass'
    when 'Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device'
      yml_name = '29.Maint on Boiler and GE'
    when 'Maintenance on Critical Equipment - Main Propulsion System - Shutdown Alarm & Tripping Device'
      yml_name = '28.Maint Main Propulsion'
    when 'Maintenance on Oil Discharging Monitoring Equipment'
      yml_name = '38.Maint on oil discharge monitoring equip'
    when 'Maintenance on Oil Mist Detector Monitoring System'
      yml_name = '30.Maint on Oil Mist Detector Monitoring Sys'
    when 'Maintenance on Oily Water Separator'
      yml_name = '37.Maint on Oily water Separator'
    when 'Maintenance on P/P Room Gas Detection Alarm System'
      yml_name = '26.Maint on Rrm Gas Detect Alarm Sys'
    when 'Maintenance on Radio Battery'
      yml_name = '24.Maint on Radio Battery'
    when 'Underwater Operation during daytime without any simultaneous operations'
      yml_name = '2.Underwater Operation during daytime without any simultenous operation'
    when 'Simultaneous underwater operation during daytime with other operation'
      yml_name = '48.Underwater Sim operation during daytime with other operation'
    when 'Underwater Operation at night'
      yml_name = '1.Underwater Operations at Night'
    when 'Use of Non-Intrinsically Safe Camera'
      yml_name = '10.Use of Non-Intrinsically Safe Camera'
    when 'Use of ODME in Manual Mode'
      yml_name = '15.Use of ODME on manual mode'
    when 'Enclosed Space Entry'
      yml_name = '8.Enclosed Space Entry'
    when 'Working Aloft / Overside'
      yml_name = '9.Working Aloft Overside'
    when 'Work on pressure pipelines/pressure vessels'
      yml_name = '11.Work on pressure pipelines pressure vessels'
    when 'Personnel Transfer by Transfer Basket'
      yml_name = '12.Personnel Transfer by Transfer Basket'
    when 'Helicopter Operation'
      yml_name = '13.Helicopter Operation'
    when 'Use of Portable Power Tools'
      yml_name = '14.Use of Portable Power Tools'
    when 'Use of Hydro blaster/working with High-pressure tools'
      yml_name = '18.Use of Hydroblaster'
    when 'Working on Electrical Equipment - Low/High Voltage'
      yml_name = '16.Working on Elect Equip'
    when 'Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard'
      yml_name = '41.CW Blanking & deblanking of pipelines and other openings'
    when 'Cold Work - Cleaning Up of Spills'
      yml_name = '43.CW Cleaning up of spills'
    when 'Cold Work - Connecting and Disconnecting Pipelines'
      yml_name = '39.CW Connecting and disconnecting pipelines'
    when 'Working on Closed Electrical Equipment and Circuits'
      yml_name = '42.CW Working on Closed Electrical Equipment and Circuits'
    when 'Cold Work - Maintenance Work on Machinery'
      yml_name = '45.CW Maint work on machinery'
    when 'Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds'
      yml_name = '40.CW Removing and fitting of valves blanks spades or blinds'
    when 'Cold Work - Working in Hazardous or Dangerous Area'
      yml_name = '44.CW Working in hazardous or dangerous area'
    when 'Hot Work Level-2 outside E/R (Ballast Passage)'
      yml_name = '3.Hot Work Level - 2 outside ER (Ballast Passage)'
    when 'Hot Work Level-2 outside E/R (Loaded Passage)'
      yml_name = '3.Hot Work Level - 2 outside ER (Ballast Passage)'
    when 'Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage)'
      yml_name = '5.Hot Work Level - 2 outside ER within (Loaded & Ballast Passage)'
    when 'Hot Work in E/R Workshop Level-2 (Loaded & Ballast Passage)'
      yml_name = '6.Hot Work Level - 2  in ER (Loaded & Ballast Passage)'
    when 'Hot Work Level-1 (Loaded & Ballast Passage)'
      yml_name = '7.Hot Work Level - 1 (Loaded & Ballast Passage)'
    when 'Working on Deck During Heavy Weather'
      yml_name = '47.Working on deck during heavy weather'
    when 'Rigging of Pilot/Combination Ladder'
      yml_name = '46.RIGGING OF GANGWAY & PILOT LADDER'
    end
    permits_arr = YAML.load_file("dra/#{yml_name}.yml")
  end

  def get_identify_hazard_name
    identify_hazard_elements.each_with_index do |_element, _index|
      Log.instance.info("Identify Hazard: #{_element.value}")
    end
  end

  def get_existing_measure
    existing_measure_elements.each_with_index do |_element, _index|
      Log.instance.info("\n\nExisting Measure: #{_element.text}\n\n")
    end
  end

  def get_risk_indicator
    risk_indicator_elements.each_with_index do |_element, _index|
      Log.instance.info("Risk Indicator: #{_element.text}")
    end
  end

  def get_wo_applying_measure_risk
    wo_applying_measures_btn_elements.each_with_index do |_element, _index|
      Log.instance.info("Without Applying Measure Risk: #{_element.text}")
    end
  end

  def get_existing_control_measure_risk
    existing_control_measure_btn_elements.each_with_index do |_element, _index|
      Log.instance.info("Existing Control Measure Risk: #{_element.text}")
    end
  end
end
