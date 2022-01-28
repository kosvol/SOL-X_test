# frozen_string_literal: true

require_relative '../../../page_objects/precre/entry_display_page'

And('EntryDisplayLog signout entrants by order {string}') do |count|
  @entry_display_log = EntryDisplayLog.new(@driver)
  @entry_display_log.signout_entrants_by_order(count)
end

And('EntryDisplayLog signout entrants by rank {string}') do |rank|
  @entry_display_log = EntryDisplayLog.new(@driver)
  @entry_display_log.signout_entrants_by_name(rank)
end
