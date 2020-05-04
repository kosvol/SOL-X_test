class CommonPage
  class << self

    def is_error
      ServiceUtil.get_response_body.key?('errors')
    end
    
    def is_successful(table)
      ServiceUtil.get_response_body["data"]["#{table}"]
    end
    
  end
end