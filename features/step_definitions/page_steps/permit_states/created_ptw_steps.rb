# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/created_ptw_page'

And('CreatedPTW click first permit') do
  @created_ptw_page ||= CreatedPTWPage.new(@driver)
  @created_ptw_page.click_first_permit
end
