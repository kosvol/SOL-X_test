# frozen_string_literal: true

require './././support/env'

class CommonPage
  class << self
    def is_error
      ServiceUtil.get_response_body.key?('errors')
    end

    def successful?(table)
      ServiceUtil.get_response_body['data'][table.to_s]
    end

    def return_entered_pin
      @entered_pin
    end

    def set_entered_pin=(pin)
      @entered_pin = nil
      @entered_pin = pin
    end

    def set_permit_id(permit)
      @@permit_id = permit
    end

    def return_permit_id
      @@permit_id
    end

    def set_dra_permit_id(dra_permit)
      @@dra_permit_id = dra_permit
    end

    def return_dra_permit_id
      @@dra_permit_id
    end

    def set_rank_id=(rank_id)
      @rank_id = nil
      @rank_id = rank_id
      p "current rank id >> #{@rank_id}"
    end

    def return_rank_id
      @rank_id
    end
  end
end
