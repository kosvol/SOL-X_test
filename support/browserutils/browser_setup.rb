# frozen_string_literal: true

$browser

class BrowserSetup
  # turn on fullreset=true, turn on no reset noreset=false
  def self.get_browser(os, platform, _noreset = false, _fullreset = true)
    $browser = case ENV['PLATFORM'].upcase
               when 'CHROME', 'CHROME_HEADLESS'
                 load_chrome(os)
               when 'ANDROID'
                 load_web_app(os, _noreset, _fullreset)
               else
                 raise "Invalid Platform => #{platform} for the OS => #{os}"
      end
    if ENV['APPLICATION'].upcase == 'WEBSITE' || ENV['APPLICATION'].upcase == 'MOBILEWEBSITE' || ENV['APPLICATION'].upcase == 'C2_PREVIEW'
      $browser.manage.delete_all_cookies
    end
    $browser.manage.timeouts.script_timeout = 35
    # $browser.manage.timeouts.page_load = 30
    $browser.manage.timeouts.implicit_wait = 30
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
      # options.add_argument('--incognito')
      # options.add_argument('--unsafely-treat-insecure-origin-as-secure=http://192.168.1.52:8080,http://23.97.50.121:8080,http://52.230.70.68:8080,http://104.215.192.113:8080,http://cloud-edge.dev.solas.magellanx.io:8080,http://cloud-edge.stage.solas.magellanx.io:8080,https://cloud-edge.stage.solas.magellanx.io:8443')
      # if ENV['DEVICE'] === 'dashboard' || ENV['DEVICE'] === 'tablet'
      #   options.add_argument('--user-data-dir=/data/user/0/com.android.chrome/app_chrome/Default/')
      # else
      if ENV['LOCAL'] === 'local'
        options.add_argument('--user-data-dir=/Users/slo-gx/Library/Application Support/Google/Chrome/Default/')
      end
      # end
      ENV['DEVICE'] === 'dashboard' ? options.add_argument('--window-size=2560,1440') : options.add_argument('--window-size=720,1280')

      begin
        if ENV['PLATFORM'] === 'chrome_headless'
          options.add_argument('--headless')
          caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' }) # , 'chromeOptions' => { 'args' => ['--unsafely-treat-insecure-origin-as-secure', '--ignore-certificate-errors', '--disable-web-security', '--allow-running-insecure-content'] }) # , 'localState' => '/Users/slo-gx/Library/Application Support/Google/Chrome/Default/Local State' })
        else
          caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs' => { browser: 'ALL' }) # 'chromeOptions' => { 'args' => ['--unsafely-treat-insecure-origin-as-secure', '--ignore-certificate-errors', '--disable-web-security', '--allow-running-insecure-content'] }) # , 'localState' => '/Users/slo-gx/Library/Application Support/Google/Chrome/Default/Local State' })
        end
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: $client, options: options
      rescue StandardError
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: $client, options: options
      end
    else
      # windows
    end
  end

  def self.load_web_app(_os, noreset, _fullreset)
    p '*********************************************************'
    @device = if ENV['DEVICE'] === 'dashboard'
                YAML.load_file('config/devices.yml')['dashboard_chrome']
              elsif ENV['DEVICE'] === 'tablet'
                YAML.load_file('config/devices.yml')['tablet_chrome']
              else
                YAML.load_file('config/devices.yml')[(ENV['DEVICE']).to_s]
              end
    # p "Test Started:: Invoking #{@device['platformName']}  #{ENV['OS']} APP..!"
    opts =
      {
        caps: {
          browserName: (@device['browserName']).to_s,
          platformName: (@device['platformName']).to_s,
          platformVersion: (@device['platformVersion']).to_s,
          deviceName: (@device['deviceName']).to_s,
          isHeadless: @device['isHeadless'],
          newCommandTimeout: 2400,
          adbExecTimeout: 60000,
          deviceReadyTimeout: 5,
          # chromeOptions: { args: ['--unsafely-treat-insecure-origin-as-secure=http://192.168.1.52:8080,http://23.97.50.121:8080,http://52.230.70.68:8080,http://104.215.192.113:8080,http://cloud-edge.dev.solas.magellanx.io:8080,http://cloud-edge.stage.solas.magellanx.io:8080', '--ignore-certificate-errors', '--disable-web-security', '--allow-running-insecure-content'] },
          chromeOptions: { args: ['--ignore-certificate-errors', '--disable-web-security', '--allow-running-insecure-content'] },
          # :fullReset => fullreset,
          noReset: noreset
        },
        appium_lib: { port: @device['port'], wait: 60 }
      }
    Appium::Driver.new(opts, true).start_driver
  end
end
