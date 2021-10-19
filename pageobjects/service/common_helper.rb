# frozen_string_literal: true

require_relative '../../features/support/env'

class CommonPage
  class << self
    def is_error
      ServiceUtil.get_response_body.key?('errors')
    end

    def is_successful(table)
      ServiceUtil.get_response_body['data'][table.to_s]
    end

    def get_entered_pin
      @entered_pin
    end

    def set_entered_pin=(_pin)
      @entered_pin = nil
      @entered_pin = _pin
    end

    def set_permit_id(_permit)
      @@permit_id = _permit
    end

    def get_permit_id
      @@permit_id
    end

    def set_dra_permit_id(_dra_permit)
      @@dra_permit_id = _dra_permit
    end

    def get_dra_permit_id
      @@dra_permit_id
    end

    def set_rank_id=(_rank_id)
      @rank_id = nil
      @rank_id = _rank_id
      p "current rank id >> #{@rank_id}"
    end

    def get_rank_id
      @rank_id
    end
  end
end
