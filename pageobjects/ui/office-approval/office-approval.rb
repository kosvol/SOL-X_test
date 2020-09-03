require 'httparty'

class OfficeApproval
  include PageObject
  def get_office_approval_link(form_id, role, name)
    event_id = get_event_id(form_id)
    staff_id = get_staff_id(role, name)

    $obj_env_yml['office_approval']['format_link'] % [form_id, event_id, staff_id]
  end

  private

  def get_event_id(form_id)

    url = $obj_env_yml['office_approval']['get_event_id']
    request = HTTParty.post(url, {
        headers: { 'Content-Type' => 'application/json' },
        body: { selector: { formId: form_id } }.to_json
    })

    JSON(request.response.body)['docs'][0]['_id']
  end

  def get_staff_id(role, name)

    url = $obj_env_yml['office_approval']['get_staff_id']
    request = HTTParty.post(url, {
        headers: { 'Content-Type' => 'application/json' },
        body: {
            "selector": {
                "role": role,
                "name": name
            }
        }.to_json
    })

    JSON(request.response.body)['docs'][0]['_id']
  end
end