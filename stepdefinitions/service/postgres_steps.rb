# frozen_string_literal: true

require_relative '../../service/utils/env_utils'
Given(/^I clear postgres db$/) do
  postgres = Postgres.new
  postgres.clear_savefue_db
  postgres.clear_dataiku_db
end
