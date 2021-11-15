# frozen_string_literal: true

require_relative 'base_page'

# SignatureLocationPage object
class SignatureLocationPage < BasePage
  include EnvUtils

  SIGNATURE_LOCATION = {
    zone_ddl: '//button[@name="zone"]',
    default_zone: '//button[@name="zone"]/span',
    zone_option: '//button[contains(.,"%s")]',
    back_btn: '//button[contains(.,"Back")]',
    signature_pad: '//*[@data-testid="signature-canvas"]',
    done_btn: '//button[contains(.,"Done")]'
  }.freeze

  def initialize(driver)
    super
    find_element(SIGNATURE_LOCATION[:zone_ddl])
  end

  def verify_default_zone_selected(expected)
    actual_element = find_element(SIGNATURE_LOCATION[:default_zone])
    if expected != 'Select'
      wait = 0
      until actual_element.text != 'Select' # to wait for the text change for wearable linked user
        sleep 0.5
        wait += 1
        break if wait > 5
      end
    end
    compare_string(expected, actual_element.text)
  end

  def click_location_dropdown
    click(SIGNATURE_LOCATION[:zone_ddl])
  end

  def select_area(area)
    scroll_click(SIGNATURE_LOCATION[:zone_option] % area)
  end

  def select_zone(zone)
    scroll_click(SIGNATURE_LOCATION[:zone_option] % zone)
  end

  def sign_off(area, zone)
    click(SIGNATURE_LOCATION[:signature_pad])
    click_location_dropdown
    select_area(area)
    select_zone(zone)
    click(SIGNATURE_LOCATION[:done_btn])
  end
end

