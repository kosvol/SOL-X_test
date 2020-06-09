# frozen_string_literal: true

$browser

class BrowserSetup
  # turn on fullreset=true, turn on no reset noreset=false
  def self.get_browser(os, platform, _noreset = false, _fullreset = true)
    $browser = case ENV['PLATFORM'].upcase
               when 'CHROME', 'CHROME_HEADLESS'
                 load_chrome(os)
               # load_web_app(os,noreset,fullreset)
               # when 'CHROME_MEW',"CHROME_MEW_HEADLESS"
               #   load_chrome_mew(os)
               else
                 raise "Invalid Platform => #{platform} for the OS => #{os}"
      end
    if ENV['APPLICATION'].upcase == 'WEBSITE' || ENV['APPLICATION'].upcase == 'MOBILEWEBSITE'
      $browser.manage.delete_all_cookies
    end
    $browser.manage.timeouts.implicit_wait = 5
    $browser
  end

  def self.load_chrome(os)
    # p "*********************************************************"
    # p "Test Started:: Invoking Chrome #{ENV['DEVICE']}..!"
    if os.casecmp('mac').zero?
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--disable-web-security')
      options.add_argument('--allow-running-insecure-content')
      options.add_argument('--ignore-certificate-errors')
      # options.add_argument('--unsafely-treat-insecure-origin-as-secure=http://cloud-edge.stage.solas.magellanx.io:8080')
      # options.add_argument('--user-data-dir=/Users/slo-gx/Library/Application Support/Google/Chrome/Default/')

      ENV['DEVICE'] === 'dashboard' ? options.add_argument('--window-size=1920,1080') : options.add_argument('--window-size=720,1280')

      begin
        if ENV['PLATFORM'] === 'chrome_headless'
          options.add_argument('--headless')
          caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' }, 'chromeOptions' => { 'args' => ['--unsafely-treat-insecure-origin-as-secure', '--ignore-certificate-errors', '--disable-web-security', '--allow-running-insecure-content'] }) # , 'localState' => '/Users/slo-gx/Library/Application Support/Google/Chrome/Default/Local State' })
        else
          caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' }, 'chromeOptions' => { 'args' => ['--unsafely-treat-insecure-origin-as-secure', '--ignore-certificate-errors', '--disable-web-security', '--allow-running-insecure-content'] }) # , 'localState' => '/Users/slo-gx/Library/Application Support/Google/Chrome/Default/Local State' })
        end
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: $client, options: options
      rescue StandardError
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: $client, options: options
      end
    else
      # windows
    end
  end

  # def self.load_chrome_mew(os)
  #   # p "*********************************************************"
  #   # p "Test Started:: Invoking Chrome Mobile Emulation #{ENV['DEVICE']}..!"
  #   $extent_test.assign_category("UIAutomation - Chrome Mobile Website[#{ENV['DEVICE']}]")
  #   if os.casecmp('mac').zero?
  #     options = Selenium::WebDriver::Chrome::Options.new
  #     options.add_emulation(device_metrics: {widht: 1920, height:1080, pixelRatio: 1, touch: true}) if ENV['DEVICE'] === "dashboard"
  #     options.add_emulation(device_metrics: {widht: 1200, height:1920, pixelRatio: 1, touch: true}) if ENV['DEVICE'] === "tablet"
  #     if ENV['PLATFORM'] == "chrome_mew_headless"
  #       options.add_argument("--headless")
  #       caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions"], "useAutomationExtension" => false})
  #     else
  #       caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions"], "useAutomationExtension" => false})
  #     end
  #   else
  #     # windows
  #   end
  #   $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client, options: options
  # end

  def self.load_web_app(_os, noreset, _fullreset)
    p '*********************************************************'
    @device = YAML.load_file('config/devices.yml')['a_chrome']
    # p "Test Started:: Invoking #{@device['platformName']}  #{ENV['OS']} APP..!"
    opts =
      {
        caps: {
          browserName: (@device['browserName']).to_s,
          platformName: (@device['platformName']).to_s,
          platformVersion: (@device['platformVersion']).to_s,
          deviceName: (@device['deviceName']).to_s,
          isHeadless: @device['isHeadless'],
          # :fullReset => fullreset,
          noReset: noreset
        },
        appium_lib: { port: @device['port'], wait: 60 }
      }
    Appium::Driver.new(opts, true).start_driver
  end
end
