# frozen_string_literal: true

require 'require_all'
require 'logger'
require_relative 'permit'
require_relative 'base_permit_builder'
require_all 'service/api'

# ptw builder to create sections
class PermitToWorkBuilder < BasePermitBuilder
  attr_accessor :permit_id

  def create_section0(permit_type = @permit_type, pin = @default_pin)
    response = Section0API.new.request(permit_type, pin)
    self.permit_id = response['data']['createForm']['_id']
    @logger.info("created permit id: #{permit_id}")
  end

  def create_dra(permit_id = self.permit_id, permit_type = @permit_type, pin = @default_pin)
    DraAPI.new.request(permit_id, permit_type, pin)
  end

  def attach_photo(stage, photo_num, permit_id = self.permit_id, pin = @default_pin)
    PhotoAPI.new.request(permit_id, stage, photo_num, pin)
  end

  def create_section1(permit_id = self.permit_id, pin = @default_pin)
    Section1API.new.request(permit_id, pin)
  end

  def create_section3a(permit_id = self.permit_id, pin = @default_pin)
    Section3AAPI.new.request(permit_id, pin)
  end

  def create_section3b(permit_id = self.permit_id, pin = @default_pin)
    Section3BAPI.new.request(permit_id, pin)
  end

  def create_section3c(permit_id = self.permit_id, pin = @default_pin)
    Section3CAPI.new.request(permit_id, pin)
  end

  def create_section3d(permit_id = self.permit_id, pin = @default_pin)
    Section3DAPI.new.request(permit_id, pin)
  end

  def create_section4a(permit_id = self.permit_id, permit_type = @permit_type, pin = @default_pin)
    Section4AAPI.new.request(permit_id, permit_type, pin)
  end

  def create_section4a_checklist(permit_id = self.permit_id, permit_type = @permit_type, pin = @default_pin)
    Section4AChecklistAPI.new.request(permit_id, permit_type, pin)
  end

  def create_section4b_eic(permit_id = self.permit_id, pin = @default_pin)
    @permit.section4b_eic = Section4bEicApi.new.request(permit_id, pin)
    @permit.eic_id = @permit.section4b_eic['data']['createForm']['_id']
    @logger.info("created eic id: #{@permit.eic_id}")
  end

  def create_section4b_eic_detail(permit_id = self.permit_id, eic_id = @permit.eic_id, pin = @default_pin)
    Section4bEicDetailApi.new.request(permit_id, eic_id, pin)
  end

  def create_section4b_detail(eic, permit_id = self.permit_id, pin = @default_pin)
    Section4bDetailApi.new.request(permit_id, eic, pin)
  end

  def create_section5(permit_id = self.permit_id, pin = @default_pin)
    Section5Api.new.request(permit_id, pin)
  end

  def create_section6(gas_reading, permit_id = self.permit_id, pin = @default_pin)
    Section6Api.new.request(permit_id, gas_reading, pin)
  end

  def create_section7(permit_id = self.permit_id, pin = @default_pin)
    Section7Api.new.request(permit_id, pin)
  end

  def create_section8(permit_id = self.permit_id, pin = @default_pin)
    Section8Api.new.request(permit_id, pin)
  end

  def create_section9(permit_id = self.permit_id, pin = @default_pin)
    Section9Api.new.request(permit_id, pin)
  end
end
