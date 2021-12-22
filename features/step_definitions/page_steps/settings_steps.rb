# frozen_string_literal: true

require_relative '../../../page_objects/settings_page'

And('Setting select mode for {string}') do |permit_type|
  @setting_page ||= SettingPage.new(@driver)
  @setting_page.select_mode(permit_type)
end