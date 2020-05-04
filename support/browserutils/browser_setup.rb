$browser

class BrowserSetup

  # turn on fullreset=true, turn on no reset noreset=false
  def self.get_browser(os, platform,noreset=false,fullreset=true)
    $browser = case ENV['PLATFORM'].upcase
      when 'CHROME','CHROME_HEADLESS'
        load_chrome(os)
      when 'CHROME_MEW',"CHROME_MEW_HEADLESS"
        load_chrome_mew(os)
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
      options.add_argument("--window-size=1920,1080") if ENV['DEVICE'] === "dashboard"
      options.add_argument("--window-size=1200,1920") if ENV['DEVICE'] === "tablet"
      begin
        if ENV['PLATFORM'] === "chrome_headless"
          options.add_argument("--headless")
          caps=Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions", "--disable-web-security"], "useAutomationExtension" => true})
        else
          caps=Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions", "--disable-web-security"], "useAutomationExtension" => true})
        end
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client, options: options
      rescue
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client, options: options
      end
    else
     #windows
    end
  end

  def self.load_chrome_mew(os)
    # p "*********************************************************"
    # p "Test Started:: Invoking Chrome Mobile Emulation #{ENV['DEVICE']}..!"
    $extent_test.assign_category("UIAutomation - Chrome Mobile Website[#{ENV['DEVICE']}]")
    if os.casecmp('mac').zero?
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_emulation(device_metrics: {widht: 1920, height:1080, pixelRatio: 1, touch: true}) if ENV['DEVICE'] === "dashboard"
      options.add_emulation(device_metrics: {widht: 1200, height:1920, pixelRatio: 1, touch: true}) if ENV['DEVICE'] === "tablet"
      if ENV['PLATFORM'] == "chrome_mew_headless"
        options.add_argument("--headless")
        caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions"], "useAutomationExtension" => false})
      else
        caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions"], "useAutomationExtension" => false})
      end
    else
      # windows
    end
    $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client, options: options
  end
end
