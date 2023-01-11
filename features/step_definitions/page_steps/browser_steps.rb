# frozen_string_literal: true

require_relative '../../../page_objects/browser_page'

And('Browser switch to {string} tab in browser') do |condition|
  @browser_page ||= BrowserPage.new(@driver)
  @browser_page.switch_browser_tab(condition)
end

And('Browser open new tab') do
  @browser_page ||= BrowserPage.new(@driver)
  @browser_page.open_new_page
end

And('Browser switch to window {int}') do |window|
  @browser_page ||= BrowserPage.new(@driver)
  @browser_page.switch_window(window)
end

And('Browser refresh page') do
  @browser_page ||= BrowserPage.new(@driver)
  @browser_page.refresh_page
end

And('Browser open second window') do
  @browser_page ||= BrowserPage.new(@driver)
  @browser_page.open_second_window
end
