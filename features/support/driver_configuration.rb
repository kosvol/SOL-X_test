# frozen_string_literal: true

require 'selenium-webdriver'

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
    @driver.manage.delete_all_cookies
    BrowserActions.turn_on_wifi_by_default if @platform.upcase == 'Android'
    @driver
  end

  private

  def setup_selenium_driver
    @options = Selenium::WebDriver::Chrome::Options.new
    setup_options
    caps_chrome = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' })
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 60
    caps = [caps_chrome, @options]
    @driver = Selenium::WebDriver.for :chrome, http_client: client, capabilities: caps
    setup_chrome_window
    @driver
  end

  def setup_appium_driver
    device = YAML.load_file('config/devices.yml')[ENV['DEVICE']]
    appium_opts = {}
    appium_opts[:caps] = device
    appium_opts[:appium_lib] = { port: device['appiumPort'], wait: 180 }
    Appium::Driver.new(appium_opts, true).start_driver
  end

  def setup_options
    setup_chrome_mode
    setup_camera
    @options.add_option('excludeSwitches', ['enable-automation']) # to disable chrome info bar
  end

  def setup_chrome_window
    if ENV['DEVICE'] == 'dashboard'
      @driver.manage.window.resize_to(2560, 1440)
    else
      @driver.manage.window.resize_to(720, 1280)
    end
  end

  def setup_chrome_mode
    case ENV['PLATFORM']
    when 'chrome_headless'
      setup_headless
    when 'chrome_incognito'
      @options.add_argument('--incognito')
      @options.add_argument('--private')
    else
      raise "#{ENV['PLATFORM']} is not supported"
    end
  end

  def setup_camera
    @options.add_argument('--use-fake-device-for-media-stream')
    @options.add_argument('--use-fake-ui-for-media-stream')
  end

  def setup_headless
    @options.headless!
    @options.add_argument('--no-sandbox')
    @options.add_argument('--disable-extensions')
    @options.add_argument('--disable-dev-shm-usage')
    @options.add_argument('--allow-insecure-localhost')
  end
end
