# frozen_string_literal: true

require_relative '../base_page'

# OPPermitArchivePage objects
class OPPermitArchivePage < BasePage
  include EnvUtils

  OP_PERMIT_ARCHIVE = {
    permit_archive_item: '//span[text()="Permit Archive"]/ancestor::li[@role="menuitem"]'
  }.freeze

  def initialize(driver)
    super
    find_element(OP_PERMIT_ARCHIVE[:permit_archive_item])
  end

  def verify_permit_archive_item
    element = find_element(OP_PERMIT_ARCHIVE[:permit_archive_item])
    border_colour = element.css_value('background-color')
    compare_string('rgba(230, 247, 255, 1)', border_colour)
  end
end
