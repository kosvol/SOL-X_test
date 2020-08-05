# frozen_string_literal: true

class CommonPage
  class << self
    def is_error
      ServiceUtil.get_response_body.key?('errors')
    end

    def is_successful(table)
      ServiceUtil.get_response_body['data'][table.to_s]
    end

    def set_permit_id(_permit)
      @@permit_id = _permit
    end

    def get_permit_id
      @@permit_id
    end
  end
end
