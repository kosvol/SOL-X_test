module GasReading
  include PageObject
  text_field(:gas_equipment_input, xpath: "//input[@id='gasEquipment']")
  text_field(:gas_sr_number_input, xpath: "//input[@id='gasSrNumber']")
  button(:last_calibration_btn, id: 'gasLastCalibrationDate')

  text_field(:o2_input, xpath: "//input[@id='o2']")
  text_field(:hc_input, xpath: "//input[@id='hc']")
  text_field(:h2s_input, xpath: "//input[@id='h2s']")
  text_field(:co_input, xpath: "//input[@id='co']")

  text_field(:gas_name_input, xpath: "//input[@id='gasName']")
  text_field(:threshold_input, xpath: "//input[@id='threshold']")
  text_field(:reading_input, xpath: "//input[@id='reading']")
  text_field(:unit_input, xpath: "//input[@id='unit']")

  button(:del_row_stage1, xpath: "//button[@aria-label = 'Delete']")
  button(:del_row_stage2, xpath: "//span[contains(text(),'Remove')]//..")
  elements(:toxic_gas_rows, xpath: "//li[starts-with(@class,'GasReadingListItem')]")


  @@test_gas_data = {
      :o2 => "20.9",
      :hc => "1",
      :h2s => "5",
      :co => "25",

      :gas_name => "benzene",
      :threshold => "25",
      :reading => "5",
      :unit => "PPM"
  }

  def parse_gas_data
    #from pages with gas reading
    names = @browser.find_elements(:xpath, "//div[@data-testid='gas-header']")
    arr_name = []
    names.each do |name|
      arr_name.push(name.text)
    end

    values = @browser.find_elements(:xpath, "//div[@data-testid='gas-reading']")
    arr_values = []
    values.each do |value|
      arr_values.push(value.text)
    end
    Hash[arr_name.zip(arr_values)]
  end

  def fill_up_section(section)
    if section == "Gas Test Record"
      o2_input_element.send_keys(@@test_gas_data[:o2])
      hc_input_element.send_keys(@@test_gas_data[:hc])
      h2s_input_element.send_keys(@@test_gas_data[:h2s])
      co_input_element.send_keys(@@test_gas_data[:co])

    elsif section == "Other Toxic Gases"
      gas_name_input_element.send_keys(@@test_gas_data[:gas_name])
      threshold_input_element.send_keys(@@test_gas_data[:threshold])
      reading_input_element.send_keys(@@test_gas_data[:reading])
      unit_input_element.send_keys(@@test_gas_data[:unit])
    end
  end

  def toxic_gas_del_row
    if toxic_gas_rows_elements.size === 1
      del_row_stage1
      del_row_stage2
    end
  end

  def toxic_gas_rows
    toxic_gas_rows_elements.size
  rescue StandardError
    0
  end

  def sign
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
    sleep 1
  end


end


