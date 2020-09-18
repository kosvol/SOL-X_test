# frozen_string_literal: true

require './././support/env'

class CommonButton < CommonPage
  include PageObject

  ### common locator
  elements(:labels_scrapper, xpath: "//*[local-name()='h3' or local-name()='h2' or local-name()='h4' or local-name()='label']")
  element(:main_clock, xpath: "//h3[@data-testid='main-clock']")
  element(:back_arrow, xpath: "//button/*[@data-testid='arrow']")
  elements(:generic_data, xpath: "//*[starts-with(@class,'ViewGenericAnswer__Answer')]")
  button(:enter_pin_btn, xpath: "//button[contains(.,'Enter Pin')]")
  buttons(:sign_btn, xpath: "//button[contains(.,'Sign')]")
  button(:clear_btn, xpath: "//button[contains(.,'Clear')]")
  button(:done_btn, xpath: "//button[contains(.,'Done')]")
  buttons(:previous_btn, xpath: "//button[contains(.,'Previous')]")
  buttons(:close_btn, xpath: "//button[contains(.,'Close')]")
  button(:save_and_next_btn, xpath: "//button[contains(.,'Save & Next')]")
  button(:next_btn, xpath: "//button[contains(.,'Next')]")
  buttons(:submit_termination_btn, xpath: "//button[contains(.,'Submit For Termination')]")
  buttons(:submit_termination_btn1, xpath: "//button[contains(.,'Submit for Termination')]")
  buttons(:update_reading_btn, xpath: "//button[contains(.,'Update Readings')]")
  button(:back_to_home_btn, xpath: "//button[contains(.,'Back to Home')]")
  button(:submit_update_btn, xpath: "//button[contains(.,'Submit')]")
  buttons(:save_and_close_btn, xpath: "//button[contains(.,'Save & Close')]")
  buttons(:save_btn, xpath: "//button[contains(.,'Save')]")
  buttons(:review_and_terminate_btn, xpath: "//button[contains(.,'Review and Terminate')]")
  button(:request_update_btn, xpath: "//button[contains(.,'Request Updates')]")
  element(:enter_comment_box, xpath: "//textarea")
  
end