# frozen_string_literal: true

require_relative '../../../service/api/entry/activate_entry_permit_api'
require_relative '../../../service/api/entry/submit_for_termination_api'
require_relative '../../../page_objects/precre/create_entry_permit_page'
require_relative '../../../page_objects/precre/pump_room_page'
require_relative '../../../page_objects/precre/compressor_room_page'

And('Service activate {string} permit') do |permit|
  @activate_permit_service ||= ActivateEntryPermitApi.new
  @activate_permit_service.request(CreateEntryPermitPage.permit_id, permit, '1111')
end
#I terminate the CRE permit via service
And('Service submit {string} permit for termination') do |permit|
  @activate_permit_service ||= SubmitForTerminationAPI.new
  @activate_permit_service.request(CreateEntryPermitPage.permit_id, permit, '1111')
end
