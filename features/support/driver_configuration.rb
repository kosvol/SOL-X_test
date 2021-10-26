# frozen_string_literal: true

# Initialize the driver setup
class DriverConfiguration
  def initialize
    @env = ENV['ENVIRONMENT']
    @application = ENV['APPLICATION']
    @platform = ENV['PLATFORM']
  end

  def setup_driver
    @driver = if @platform == 'Android'
                setup_appium_driver
              else
                setup_selenium_driver
              end
    setup_browser_timeouts
    @driver.manage.delete_all_cookies
    BrowserActions.turn_on_wifi_by_default if @platform.upcase == 'Android'
    @driver
  end

  private

  def setup_selenium_driver
    @options = Selenium::WebDriver::Chrome::Options.new
    setup_chrome_window
    setup_chrome_mode
    caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' })
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 60
    Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: client, options: @options
  end

  def setup_appium_driver
    device = YAML.load_file('config/devices.yml')[ENV['DEVICE']]
    appium_opts = {}
    appium_opts[:caps] = device
    appium_opts[:appium_lib] = { port: device['appiumPort'], wait: 180 }
    Appium::Driver.new(appium_opts, true).start_driver
  end

  def setup_browser_timeouts
    @driver.manage.timeouts.script_timeout = 10
    @driver.manage.timeouts.page_load = 10
    @driver.manage.timeouts.implicit_wait = 10
  end

  def setup_chrome_window
    if ENV['DEVICE'] == 'dashboard'
      @options.add_argument('--window-size=2560,1440')
    else
      @options.add_argument('--window-size=720,1280')
    end
  end

  def setup_chrome_mode
    case ENV['PLATFORM']
    when 'chrome_headless'
      @options.add_argument('--headless')
    when 'chrome_incognito'
      @options.add_argument('--incognito')
      @options.add_argument('--private')
    else
      raise "#{ENV['PLATFORM']} is not supported"
    end
  end
end
