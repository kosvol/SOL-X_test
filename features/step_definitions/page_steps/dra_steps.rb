# frozen_string_literal: true

require_relative '../../../page_objects/dra_page'

Given('DRA edit hazards') do |table|
  @dra_page ||= DRAPage.new(@driver)
  params = table.hashes.first
  @dra_page.edit_hazards(params['type'], params['likelihood'], params['consequence'])
end

Given('DRA verify risk indicator') do |table|
  params = table.hashes.first
  @dra_page.verify_risk_indicator(params['type'], params['expected'])
end

Given('DRA verify evaluation of residual risk') do |table|
  params = table.hashes.first
  @dra_page.verify_residual_risk(params['without_measures'], params['after_measures'],
                                 params['residual_risk'])
end

Given('DRA add additional measures') do
  @dra_page ||= DRAPage.new(@driver)
  @dra_page.add_additional_measures
end

Given('DRA Save DRA') do
  @dra_page.save_dra
end

Given('DRA should see additional measures') do
  @dra_page.verify_measures_text
end

Given('DRA delete a hazard') do
  @dra_page ||= DRAPage.new(@driver)
  @dra_page.delete_hazard
end

Given('DRA should see a hazard is deleted') do
  @dra_page.verify_hazard_deleted
end

Given('DRA add extra hazard') do
  @dra_page ||= DRAPage.new(@driver)
  @dra_page.add_extra_hazard
end

Given('DRA should see extra hazard') do
  @dra_page.verify_extra_hazard
end
