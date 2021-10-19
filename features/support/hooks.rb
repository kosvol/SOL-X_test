# frozen_string_literal: true

#########################################################
############ DO NOT TOUCH THIS WHEN UNSURE ##############
#########################################################

AfterConfiguration do
  raise "Invalid OS => #{ENV['OS']}" unless %w[MAC WINDOWS Android iOS iOS-web Android-webWIN].include? (ENV['OS']).to_s
end

Before do
  $client = Selenium::WebDriver::Remote::Http::Default.new
  $client.read_timeout = 60
  @browser = BrowserSetup.get_browser(ENV['OS'], $current_platform)
end

Before('@skip') do
  skip_this_scenario
end

After do |scenario|
  if scenario.failed?
    encoded_img = @browser.screenshot_as(:base64)
    embed(encoded_img, 'image/png;base64')
  end
end
