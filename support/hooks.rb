# frozen_string_literal: true

'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''
'' ' DO NOT TOUCH THIS WHEN UNSURE ' ''
'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''
AfterConfiguration do |config|
  unless %w[MAC WINDOWS Android iOS iOS-web Android-web].include? (ENV['OS']).to_s
    raise "Invalid OS => #{ENV['OS']}"
  end

  $client = Selenium::WebDriver::Remote::Http::Default.new
  $client.read_timeout = 180
  $tag = config.tag_expressions.join("'_'")
  $timestamp = Time.now.strftime('%Y_%m_%d-%IH_%MM_%SS_%LS_%p')
  $folder_name = "#{$tag}_#{$timestamp}"
  $extent = RelevantCodes::ExtentReports.new('testreport/reports/extent_report.html')
  $examples_count = 0
end

Before('@skip') do
  skip_this_scenario
end

Before do |scenario|
  @step = 0
  @current_feature = scenario.respond_to?('scenario_outline') ? scenario.scenario_outline : scenario.feature
  @all_steps = ReportUtils.get_steps(@current_feature, scenario)
  $extent_test = $extent.start_test(scenario.name, @current_feature.name)
  ReportUtils.output_tag(scenario, $extent_test)
  @log = Log.instance.start_new(scenario.name.gsub(' ', '_'))
  @log.instance_variable_set(:@cucumber_world, self)
  # refactor maybe
  # @reset_flag_counter = 0
  # device = YAML.load_file('config/devices.yml')["#{ENV['DEVICE']}"]
  # scenario.source_tag_names.each do |tag|
  #   if tag === "@disable_reset"
  #     @browser = BrowserSetup.get_browser(ENV['OS'], ENV['PLATFORM'],true,false)
  #     @reset_flag_counter = 1
  #     break
  #   end
  # end
  @browser = BrowserSetup.get_browser(ENV['OS'], ENV['PLATFORM']) # ,false,true) if @reset_flag_counter == 0
end

After do |scenario|
  if scenario.failed?
    begin
      @log.info("Exception: #{scenario.exception}")
      $extent_test.info(:fail, "Step #{@step + 1}: #{@all_steps[@step]}", "Executed #{@all_steps[@step]} - ERROR: #{scenario.exception}", scenario.name.gsub(' ', '_'), @browser)
    rescue Exception => e
      $extent_test.info(:fatal, 'Exception Raised', e, @browser)
    end
  end
  @log.info("Chrome Console Log: #{$browser.manage.logs.get(:browser)}")
  @browser.quit
  $extent.end_test($extent_test)
end

AfterStep do |scenario|
  $extent_test.info(:pass, "Step #{@step + 1}: #{@all_steps[@step]}", "Executed #{@all_steps[@step]} successfully", scenario, @browser)
  @step += 1
end

at_exit do
  $extent.append_desc(Formatter::HtmlFormatter.examples)
  $extent.flush
  ReportUtils.make_folder($folder_name)
  # ReportUtils.get_steps_for_examples("./testreport/jsonreports/json_report.json")
end
