$browser

class BrowserSetup

  # turn on fullreset=true, turn on no reset noreset=false
  def self.get_browser(os, platform,noreset=false,fullreset=true)
    $browser = case ENV['PLATFORM'].upcase
      when 'CHROME','CHROME_HEADLESS'
        load_chrome(os)
        # load_web_app(os,noreset,fullreset)
      # when 'CHROME_MEW',"CHROME_MEW_HEADLESS"
      #   load_chrome_mew(os)
      else
        raise "Invalid Platform => #{platform} for the OS => #{os}"
    end
    $browser.manage.delete_all_cookies if ENV['APPLICATION'].upcase == 'WEBSITE' || ENV['APPLICATION'].upcase == 'MOBILEWEBSITE'
    $browser.manage.timeouts.implicit_wait = 5
    $browser
  end

  def self.load_chrome(os)
    # p "*********************************************************"
    # p "Test Started:: Invoking Chrome #{ENV['DEVICE']}..!"
    if os.casecmp('mac').zero?
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument("--disable-web-security");
      options.add_argument("--allow-insecure-localhost");
      options.add_argument("--allow-running-insecure-content")
      options.add_argument("--unsafely-allow-protected-media-identifier-for-domain=http://cloud-edge.stage.solas.magellanx.io:8080")
      options.add_argument("--unsafely-treat-insecure-origin-as-secure=http://cloud-edge.stage.solas.magellanx.io:8080")
      # options.add_argument("--user-data-dir=/Users/slo-gx/Library/Application Support/Google/Chrome/Default/")
      options.add_argument("--user-data-dir=/home/solas/.config/google-chrome")

      options.add_argument("--window-size=1920,1080") if ENV['DEVICE'] === "dashboard"
      # options.add_argument("--window-size=2560,1264") if ENV['DEVICE'] === "dashboard"
      options.add_argument("--window-size=720,1280") if ENV['DEVICE'] === "tablet"
      begin
        if ENV['PLATFORM'] === "chrome_headless"
          options.add_argument("--headless")
          caps=Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions"], "useAutomationExtension" => false, "--unsafely-treat-insecure-origin-as-secure" => true, "localState" => "/Users/slo-gx/Library/Application Support/Google/Chrome/Default/Local State"})
        else
          caps=Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions"], "useAutomationExtension" => false, "--unsafely-treat-insecure-origin-as-secure" => true, "localState" => "/Users/slo-gx/Library/Application Support/Google/Chrome/Default/Local State"})
        end
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client, options: options
      rescue
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client, options: options
      end
    else
     #windows
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

  def self.load_web_app(os,noreset,fullreset)
    p "*********************************************************"
    @device = YAML.load_file('config/devices.yml')["a_chrome"]
    # p "Test Started:: Invoking #{@device['platformName']}  #{ENV['OS']} APP..!"
    opts =
    {
      caps:
      {
        :browserName => "#{@device['browserName']}",
        :platformName => "#{@device['platformName']}",
        :platformVersion => "#{@device['platformVersion']}",
        :deviceName => "#{@device['deviceName']}",
        :isHeadless => @device['isHeadless'],
        # :fullReset => fullreset,
        :noReset => noreset
      },
      appium_lib: {:port => @device['port'],wait:60}
    }
    return Appium::Driver.new(opts,true).start_driver
  end
end
