# frozen_string_literal: true

require 'require_all'
require 'logger'
require_relative 'permit'
require_all 'service/api'

# builder to create sections
class PermitBuilder

  def initialize(permit_type)
    @permit_type = permit_type
    @permit = Permit.new
    @logger = Logger.new($stdout)
  end

  def create_section0(permit_type = @permit_type, pin = '1111')
    @permit.section0 = Section0API.new.request(permit_type, pin)
    @permit.permit_id = @permit.section0['data']['createForm']['_id']
    @logger.info("created permit id: #{@permit.permit_id}")
  end

  def create_dra(permit_id = @permit.permit_id, permit_type = @permit_type, pin = '1111')
    DraAPI.new.request(permit_id, permit_type, pin)
  end

  def attach_photo(stage, photo_num, permit_id = @permit.permit_id, pin = '1111')
    PhotoAPI.new.request(permit_id, stage, photo_num, pin)
  end

  def create_section1(permit_id = @permit.permit_id, pin = '1111')
    Section1API.new.request(permit_id, pin)
  end

  def create_section3a(permit_id = @permit.permit_id, pin = '1111')
    Section3AAPI.new.request(permit_id, pin)
  end

  def create_section3b(permit_id = @permit.permit_id, pin = '1111')
    Section3BAPI.new.request(permit_id, pin)
  end

  def create_section3c(permit_id = @permit.permit_id, pin = '1111')
    Section3CAPI.new.request(permit_id, pin)
  end

  def create_section3d(permit_id = @permit.permit_id, pin = '1111')
    Section3DAPI.new.request(permit_id, pin)
  end

  def create_section4a(permit_id = @permit.permit_id, permit_type = @permit_type, pin = '1111')
    Section4AAPI.new.request(permit_id, permit_type, pin)
  end

  def create_section4a_checklist(permit_id = @permit.permit_id, permit_type = @permit_type, pin = '1111')
    Section4AChecklistAPI.new.request(permit_id, permit_type, pin)
  end

  def create_section4b_eic(permit_id = @permit.permit_id, pin = '1111')
    @permit.section4b_eic = Section4bEicApi.new.request(permit_id, pin)
    @permit.eic_id = @permit.section4b_eic['data']['createForm']['_id']
    @logger.info("created eic id: #{@permit.eic_id}")
  end

  def create_section4b_eic_detail(permit_id = @permit.permit_id, eic_id = @permit.eic_id, pin = '1111')
    Section4bEicDetailApi.new.request(permit_id, eic_id, pin)
  end

  def create_section4b_detail(eic, permit_id = @permit.permit_id, pin = '1111')
    Section4bDetailApi.new.request(permit_id, eic, pin)
  end

  def create_section5(permit_id = @permit.permit_id, pin = '1111')
    Section5Api.new.request(permit_id, pin)
  end

  def create_section6(gas_reading, permit_id = @permit.permit_id, pin = '1111')
    Section6Api.new.request(permit_id, gas_reading, pin)
  end

  def create_section7(permit_id = @permit.permit_id, pin = '1111')
    Section7Api.new.request(permit_id, pin)
  end

  def create_section8(permit_id = @permit.permit_id, pin = '1111')
    Section8Api.new.request(permit_id, pin)
  end

  def create_section9(permit_id = @permit.permit_id, pin = '1111')
    Section9Api.new.request(permit_id, pin)
  end

  def update_form_status(status, permit_id = @permit.permit_id, pin = '1111')
    UpdateFormsStatusApi.new.request(permit_id, status, pin)
  end
end
