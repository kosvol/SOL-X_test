# frozen_string_literal: true
$browser

class BrowserSetup
  # turn on fullreset=true, turn on no reset noreset=false
  def self.get_browser(os, platform, noreset = false, fullreset = true)
    $browser = case ENV['PLATFORM'].upcase
               when 'CHROME', 'CHROME_HEADLESS', 'CHROME_INCOGNITO'
                 load_chrome(os)
               when 'ANDROID'
                 load_web_app(os, noreset, fullreset)
               else
                 raise "Invalid Platform => #{platform} for the OS => #{os}"
               end
    $wait = Selenium::WebDriver::Wait.new(timeout: 10)
    $browser.manage.timeouts.script_timeout = 10
    $browser.manage.timeouts.page_load = 10
    $browser.manage.timeouts.implicit_wait = 10

    if $current_application
       .upcase == 'WEBSITE' || $current_application
       .upcase == 'MOBILEWEBSITE' || $current_application
       .upcase == 'C2_PREVIEW'
      $browser.manage.delete_all_cookies
    end

    if $current_platform
       .upcase != 'CHROME' && $current_platform
       .upcase != 'CHROME_HEADLESS' && $current_platform
       .upcase != 'CHROME_INCOGNITO'
      BrowserActions.turn_on_wifi_by_default
    end
    $browser
  end

  def self.load_chrome(os)
    # p "*********************************************************"
    # p "Test Started:: Invoking Chrome #{ENV['DEVICE']}..!"
    if os.casecmp('mac').zero?
      options = Selenium::WebDriver::Chrome::Options.new
      if ENV['DEVICE'] == 'dashboard'
        options
          .add_argument('--window-size=2560,1440')
      else
        options
          .add_argument('--window-size=720,1280')
      end
      begin
        case ENV['PLATFORM']
        when 'chrome_headless'
          options.add_argument('--headless')
        when 'chrome_incognito'
          options.add_argument('--incognito')
          options.add_argument('--private')
        else
          puts 'Browser setup without added arguments'
        end
        caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' })
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: $client, options: options
      rescue StandardError
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: $client, options: options
      end
    else
      # windows
      Selenium::WebDriver::Chrome::Service
        .driver_path = File
                       .join(File.absolute_path('../../../../', File.dirname(__FILE__)),
                             '/Downloads/chromedriver.exe')
      if ENV['DEVICE'] == 'tablet'
        caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' })
      end
      if ENV['DEVICE'] == 'dashboard'
        caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' },
                                                                'chromeOptions' => {
                                                                  w3c: false, args: ['start-maximized']
                                                                })
      end
      $browser = Selenium::WebDriver.for :remote, url: 'http://127.0.0.1:9515/', desired_capabilities: caps,
                                                  http_client: $client, options: options
    end
  end

  def self.load_web_app(_os, noreset, _fullreset)
    p '*********************************************************'
    @device = case ENV['DEVICE']
              when 'dashboard'
                YAML.load_file('config/devices.yml')['dashboard_chrome']
              when 'tablet'
                YAML.load_file('config/devices.yml')['tablet_chrome']
              else
                YAML.load_file('config/devices.yml')[(ENV['DEVICE']).to_s]
              end

    # p "Test Started:: Invoking #{@device['platformName']}  #{ENV['OS']} APP..!"
    if ENV['RESOLUTION'] == 'tablet_b' || ENV['RESOLUTION'] == 'dashboard'
      opts =
        {
          caps: {
            browserName: (@device['browserName']).to_s,
            platformName: (@device['platformName']).to_s,
            platformVersion: (@device['platformVersion']).to_s,
            deviceName: (@device['deviceName']).to_s,
            # udid: (@device['deviceName']).to_s,
            isHeadless: @device['isHeadless'],
            automationName: 'UiAutomator2',
            newCommandTimeout: 300_000,
            adbExecTimeout: 700_000,
            uiautomator2ServerLaunchTimeout: 300_000,
            chromedriverPort: @device['chromedriverPort'],
            systemPort: @device['port'],
            udid: @device['udid'],
            # adbPort: @device['adbPort'],
            # skipUnlock: false,
            # unlockType: 'pin',
            # unlockKey: '1111',
            skipLogcatCapture: true,
            chromeOptions: {
              args: %w[--ignore-certificate-errors --disable-web-security --allow-running-insecure-content
                       --no-sandbox]
            },
            # :fullReset => fullreset,
            noReset: noreset
          },
          appium_lib: { port: @device['appiumPort'], wait: 180 }
        }
    end

    if ENV['RESOLUTION'] == 'tablet_a'
      opts =
        {
          caps: {
            browserName: (@device['browserName']).to_s,
            platformName: (@device['platformName']).to_s,
            platformVersion: (@device['platformVersion']).to_s,
            deviceName: (@device['deviceName']).to_s,
            isHeadless: @device['isHeadless'],
            automationName: 'UiAutomator2',
            newCommandTimeout: 300_000,
            adbExecTimeout: 700_000,
            systemPort: @device['port'],
            udid: @device['udid'],
            skipLogcatCapture: true,
            uiautomator2ServerLaunchTimeout: 300_000,
            chromedriverPort: @device['chromedriverPort'],
            # chromeOptions: { args: ['--ignore-certificate-errors', '--disable-web-security',
            # '--allow-running-insecure-content', '--no-sandbox'] },
            chromeOptions: { args: %w[--ignore-certificate-errors --disable-web-security
                                      --allow-running-insecure-content --no-sandbox] },
            noReset: noreset
          },
          appium_lib: { port: @device['appiumPort'], wait: 180 }
        }
    end

    Appium::Driver.new(opts, true).start_driver
  end
end
