# frozen_string_literal: true

require 'rest-client'
# photo attach api requests
class PhotoAPI < BaseSectionApi

  def request(form_id, stage, photo_num, pin)
    payload = create_payload(form_id, stage)
    photo_num.times do
      updated_payload = update_dynamic_keys(payload)
      RestClient::Request.execute(
        method: :post, url: retrieve_api_url,
        headers: { accept: 'application/json', "x-auth-user": 'system', "x-auth-pin": pin },
        payload: { "operations": updated_payload.to_json,
                   "map": '{"0":["variables.photo.file"]}', '0': File.new("#{Dir.pwd}/data/photos/save_vue_ai.jpeg") }
      )
    end
  end

  private

  def create_payload(form_id, stage)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/photo_attachment.json")
    payload['variables']['formId'] = form_id
    payload['variables']['photo']['takenAtStage'] = stage
    payload
  end

  def update_dynamic_keys(payload)
    payload['variables']['photo']['id'] = @time_service.retrieve_current_date_time
    payload['variables']['photo']['takenAt'] = @time_service.retrieve_current_date_time
    payload['variables']['photo']['utcOffset'] = @time_service.retrieve_ship_utc_offset
    payload
  end
end
