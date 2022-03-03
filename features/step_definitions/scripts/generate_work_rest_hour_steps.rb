# frozen_string_literal: true

# script steps
require_relative '../../../scripts/generate_work_rest_hour'

And('Generate work rest hour data') do
  GenWorkRestHour.new.run
end
