$browser

class BrowserSetup

  # turn on fullreset=true, turn on no reset noreset=false
  def self.get_browser(os, platform,noreset=false,fullreset=true)
    $browser = case ENV['PLATFORM'].upcase
      when 'CHROME','CHROME_HEADLESS'
        load_chrome(os)
      # when 'FIREFOX'
      #   load_firefox(os)
      # when 'IE'
      #   load_ie(os)
      # when 'SAFARI'
      #   load_safari(os)
      when 'CHROME_MEW',"CHROME_MEW_HEADLESS"
        load_chrome_mew(os)
      when 'WEB_APP'
        load_web_app(os,noreset,fullreset)
      when 'MOBILE_APP'
        load_mobile_app(os,noreset,fullreset)
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
      begin
        if ENV['PLATFORM'] == "chrome_headless"
          caps=Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions", "--disable-web-security", "start-maximized", "--headless", "window-size=1500,1500"], "useAutomationExtension" => false})
        else
          caps=Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions", "--disable-web-security", "start-maximized", "window-size=1500,1500"], "useAutomationExtension" => false})
        end
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client 
      rescue
        $browser = Selenium::WebDriver.for :chrome, desired_capabilities: caps,http_client: $client 
      end
    else
      Selenium::WebDriver::Chrome.driver_path = File.join(File.absolute_path('../', File.dirname(__FILE__)), '/drivers/chromedriver.exe')
      caps=Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["disable-extensions", "start-maximized", "--headless", "-disable-gpu", "window-size=1500,1500"], "useAutomationExtension" => false})
      $browser = Selenium::WebDriver.for :remote, url: 'http://10.65.42.253:4444/wd/hub', desired_capabilities: caps,http_client: $client 
    end
  end

  # def self.load_firefox(os)
  #   p "*********************************************************"
  #   p "Test Started:: Invoking Firefox $browser..!"
  #   if os.downcase == 'mac'
  #     # Selenium::WebDriver::Firefox::Binary.path = "/Users/user/Applications/Firefox 46.app/Contents/MacOS/firefox-bin"
  #     caps = Selenium::WebDriver::Remote::Capabilities.firefox
  #     $browser = Selenium::WebDriver.for :firefox, :desired_capabilities => caps
  #   else
  #     $browser = Selenium::WebDriver.for :firefox
  #   end
  # end

  # def self.load_ie(os)
  #   p "*********************************************************"
  #   p "Test Started:: Invoking IE $browser..!"
  #   $browser = Selenium::WebDriver.for :ie
  # end

  # def self.load_safari(os)
  #   p "*********************************************************"
  #   p "Test Started:: Invoking Safari #{ENV['PLATFORM']}..!"
  #   $browser = Selenium::WebDriver.for :safari
  # end

  def self.load_chrome_mew(os)
    p "*********************************************************"
    p "Test Started:: Invoking Chrome Mobile Emulation #{ENV['DEVICE']}..!"
    $extent_test.assign_category("UIAutomation - Chrome Mobile Website[#{ENV['DEVICE']}]")
    if os.downcase == 'mac'
      mobile_emulation = {"deviceName" => "#{ENV['DEVICE']}"}
      if ENV['PLATFORM'] == "chrome_mew_headless"
        caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"mobileEmulation" => mobile_emulation, "args" => ["disable-extensions", "--headless"], "useAutomationExtension" => false})
      else
        caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"mobileEmulation" => mobile_emulation, "args" => ["disable-extensions"], "useAutomationExtension" => false})
      end
    else
      mobile_emulation = {"deviceName" => "#{ENV['DEVICE']}"}
      Selenium::WebDriver::Chrome.driver_path = File.join(File.absolute_path('../', File.dirname(__FILE__)), "/drivers/chromedriver.exe")
      caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"mobileEmulation" => mobile_emulation, "args" => ["disable-extensions"], "useAutomationExtension" => false})
    end
    $browser = Selenium::WebDriver.for :remote, url: 'http://10.65.42.253:4444/wd/hub', desired_capabilities: caps,http_client: $client 
    $browser
  end

  def self.load_web_app(os,noreset,fullreset)
    p "*********************************************************"
    @device = YAML.load_file('config/devices.yml')["#{ENV['DEVICE']}"] if ENV['JENKINS'].to_s === "no"
    @device = YAML.load_file('config/devices_jenkins.yml')["#{ENV['DEVICE']}"] if ENV['JENKINS'].to_s === "yes"
    p "Test Started:: Invoking #{@device['platformName']}  #{ENV['OS']} APP..!"
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

  def self.load_mobile_app(os,noreset,fullreset)
    p "*********************************************************"
    @device = YAML.load_file('config/devices.yml')["#{ENV['DEVICE']}"] if ENV['JENKINS'].to_s === "no"
    @device = YAML.load_file('config/devices_jenkins.yml')["#{ENV['DEVICE']}"] if ENV['JENKINS'].to_s === "yes"
    p "Test Started:: Invoking #{@device['platformName']}  #{ENV['OS']} APP..!"
    opts =
        {
            caps:
                {
                    :app => "#{@device['app']}",
                    #:derivedDataPath => "#{@device['derivedDataPath']}",
                    :platformName => "#{@device['platformName']}",
                    :platformVersion => "#{@device['platformVersion']}",
                    :deviceName => "#{@device['deviceName']}",
                    :automationName => "#{@device['automationName']}",
                    # :fullReset => fullreset,
                    :isHeadless => @device['isHeadless'],
                    :noReset => noreset,
                    :udid => "#{@device['udid']}",
                    :connectHardwareKeyboard => false,
                    :clearSystemFiles => true
                    # :xcodeOrgId => "QFUHAANNP5",
                    # :xcodeSigningId => "iPhone Developer",
                    # :bundleId => "dev.nf.YaboX"
                    # :updatedWDABundleId => ""
                },
            appium_lib: {:port => @device['port'],wait:60}
        }
    return Appium::Driver.new(opts,true).start_driver
  end
end
