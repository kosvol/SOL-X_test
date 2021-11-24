# frozen_string_literal: true

require_relative '../../../page_objects/eic_page'

Given('EIC verify Description of work {string}') do |expected|
  @eic_page ||= EICPage.new(@driver)
  @eic_page.verify_desc_of_work(expected)
end

Given('EIC verify pre-filled answers') do
  @eic_page ||= EICPage.new(@driver)
  @eic_page.verify_pre_filled_answers
end

Given('EIC click competent person sign button') do
  @eic_page ||= EICPage.new(@driver)
  @eic_page.click_competent_sign_btn
end

Given('EIC click issuing person sign button') do
  @eic_page ||= EICPage.new(@driver)
  @eic_page.click_issuing_sign_btn
end

Given('EIC verify signed detail') do |table|
  @eic_page ||= EICPage.new(@driver)
  @eic_page.verify_signed_detail(table)
end

Given('EIC should see {string} button {string}') do |button_type, expected|
  @eic_page ||= EICPage.new(@driver)
  @eic_page.verify_button_behavior(button_type, expected)
end

Given('EIC answers yes to Method of Isolation') do
  @eic_page ||= EICPage.new(@driver)
  @eic_page.answer_method_of_isolation
end

Given('EIC verify sub questions') do |table|
  @eic_page ||= EICPage.new(@driver)
  @eic_page.verify_sub_questions(table)
end
