require "page-object"
require "selenium-webdriver"
require "yaml"
require "httparty"
require "page-object/page_factory"
require "require_all"
require "rubygems"
require "rspec/expectations"
require "cucumber"
require "appium_lib"
require "json-schema"

require_all "library"
require_all "pageobjects"

World(PageObject::PageFactory)
World(Appium)
World(BrowserActions)
World(AssertionUtil)

PageObject.default_element_wait = 30
PageObject.default_page_wait = 30

$current_application = ENV["APPLICATION"].to_s
$current_environment = ENV["ENVIRONMENT"].to_s

$obj_env_yml = YAML.load_file("config/environment.yml")
$sit_rank_and_pin_yml = YAML.load_file("data/sit_rank_and_pin.yml") if $current_environment === "sit"

# Clear report folders contents
ReportUtils.clear_folder

# Create reports & log folder if not exists
Dir.mkdir("testreport") unless File.exist?("testreport")
Dir.mkdir("testreport/log") unless File.exist?("testreport/log")
Dir.mkdir("testreport/xmlreports") unless File.exist?("testreport/xmlreports")
Dir.mkdir("testreport/jsonreports") unless File.exists?("testreport/jsonreports")
Dir.mkdir("testreport/reports/") unless File.exist?("testreport/reports/")
Dir.mkdir("testreport/reports/screenshots") unless File.exist?("testreport/reports/screenshots")
