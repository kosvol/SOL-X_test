# frozen_string_literal: true

require_relative '../../../service/db_service'
require_relative '../../../service/crew_member_service'

Given('CrewMember service reset') do
  crew_member_service = CrewMemberService.new
  crew_member_service.reset_crew_member
end
