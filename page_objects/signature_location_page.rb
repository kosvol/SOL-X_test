# frozen_string_literal: true

require_relative 'base_page'

# SignatureLocationPage object
class SignatureLocationPage < BasePage
  include EnvUtils

  SIGNATURE_LOCATION = {
    zone_ddl: '//button[@name="zone"]',
    default_zone: '//button[@name="zone"]/span',
    zone_list: "//ul[starts-with(@class,'UnorderedList-')]/li/button",
    zone_option: '//button[contains(.,"%s")]',
    back_btn: '//button[contains(.,"Back")]',
    signature_pad: '//*[@data-testid="signature-canvas"]',
    done_btn: '//button[contains(.,"Done")]',
    submit_btn: "//div[starts-with(@class,'MainGasesInput__ButtonContainer')]/button[2]"
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

  def sign_off_static_zone_area
    click(SIGNATURE_LOCATION[:signature_pad])
    click_location_dropdown
    area = find_elements(SIGNATURE_LOCATION[:zone_list]).first
    area.location_once_scrolled_into_view
    area.click
    zone = find_elements(SIGNATURE_LOCATION[:zone_list]).first
    zone.location_once_scrolled_into_view
    zone.click
    click(SIGNATURE_LOCATION[:submit_btn])
    click(SIGNATURE_LOCATION[:done_btn])
  end
end
