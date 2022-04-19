# frozen_string_literal: true

require_relative '../../base_page'

# EntryLogPage object
class EntryLogPage < BasePage
  include EnvUtils
  ENTRY_LOG = {
    page_header: "//h1[contains(.,'Entry Log')]",
    header_cell: "//div[starts-with(@class,'header-cell')]",
    first_entrant_time: '(//div[@class="cell"])[3]'
  }.freeze

  def verify_entry_log_table
    expected_headers = YAML.load_file('data/entry/entry_log_table.yml')['headers']
    page_table_headers = find_elements(ENTRY_LOG[:header_cell])
    page_table_headers.each_with_index do |element, index|
      compare_string(expected_headers[index], element.text)
    end
  end

  def verify_first_entrant_time
    sleep 1
    time = retrieve_text(ENTRY_LOG[:first_entrant_time])
    raise "time out #{time} has not updated" if time.include? 'Now'
  end
end
