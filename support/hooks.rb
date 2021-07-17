# frozen_string_literal: true

'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''
'' ' DO NOT TOUCH THIS WHEN UNSURE ' ''
'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''

AfterConfiguration do |config|
  unless %w[MAC WINDOWS Android iOS iOS-web Android-web].include? (ENV['OS']).to_s
    raise "Invalid OS => #{ENV['OS']}"
  end

  $client = Selenium::WebDriver::Remote::Http::Default.new
  $client.read_timeout = 60
  $tag = config.tag_expressions.join("'_'")
  $timestamp = Time.now.strftime('%Y_%m_%d-%IH_%MM_%SS_%LS_%p')
  $test_report = 'finalreport'
  $documentation = 'documentation'
  $extent = RelevantCodes::ExtentReports.new('testreport/reports/extent_report.html')
  # $living_documentation = RelevantCodes::ExtentReports.new('testreport/documentation/livingdoc/living_documentation.html')
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
  # $living_test = $living_documentation.start_test(scenario.name, @current_feature.name)
  ReportUtils.output_tag(scenario, $extent_test)
  @log = Log.instance.start_new(scenario.name.gsub(' ', '_'))
  @log.instance_variable_set(:@cucumber_world, self)

  @browser = BrowserSetup.get_browser(ENV['OS'], $current_platform)
end

After do |scenario|
  begin
    if scenario.failed?
      # @log.info("Exception: #{scenario.exception}")
      $extent_test.info(:fail, "Step #{@step + 1}: #{@all_steps[@step]}", "Executed #{@all_steps[@step]} - ERROR: #{scenario.exception}", scenario.name.gsub(' ', '_'), @browser)
    elsif scenario.status.to_s == "undefined"
      $extent_test.info(:undefined, "Step #{@step + 1}: #{@all_steps[@step]}", "Executed #{@all_steps[@step]} - ERROR: #{scenario.status}", scenario.name.gsub(' ', '_'), @browser)
    end
  rescue Exception => e
    $extent_test.info(:fail, 'Exception raised from after scenario rescue', scenario, @browser)
  end
  
  begin
    @log.info("Chrome Console Log: #{$browser.manage.logs.get(:browser)}")
  rescue StandardError
  end

  $browser.close
  $extent.end_test($extent_test)
end

AfterStep do |scenario|
  begin
    if scenario.passed?
      $extent_test.info(:pass, "Step #{@step + 1}: #{@all_steps[@step]}", "Executed #{@all_steps[@step]} successfully", scenario, @browser)
      @step += 1
    else
      $extent_test.info(:fail, "Step #{@step + 1}: #{@all_steps[@step]}", "Executed #{@all_steps[@step]} - ERROR: Undefined Step", scenario, @browser)
    end
  rescue Exception => e
    $extent_test.info(:fail, 'Exception raised from after step rescue', scenario, @browser)
  end
end

at_exit do
  $extent.append_desc(Formatter::HtmlFormatter.examples)
  $extent.flush_extent_report
  ReportUtils.make_folder_test($test_report)
end
