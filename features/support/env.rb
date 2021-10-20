# frozen_string_literal: true

require 'page-object'
require 'selenium-webdriver'
require 'yaml'
require 'httparty'
require 'page-object/page_factory'
require 'require_all'
require 'rubygems'
require 'rspec/expectations'
require 'cucumber'
require 'appium_lib'
require 'json-schema'
# require 'mysql2'

require_all 'library'
require_all 'pageobjects'

World(PageObject::PageFactory)
World(Appium)
World(BrowserActions)
World(AssertionUtil)

# PageObject.default_element_wait = 5
# PageObject.default_page_wait = 5

$current_application = ENV['APPLICATION']
$current_environment = ENV['ENVIRONMENT']
$current_platform = ENV['PLATFORM']

$obj_env_yml = YAML.load_file('config/environment.yml')
$sit_rank_and_pin_yml = YAML.load_file('data/sit_rank_and_pin.yml')
$checklist_name_in_code_yml = YAML.load_file('data/checklist/checklist_name_in_code.yml')

$password = $obj_env_yml['office_approval']['password']
