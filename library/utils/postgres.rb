# frozen_string_literal: true

require 'pg'
require 'yaml'
require 'logger'
require_relative '../../service/utils/env_utils'
# integration with postgres db
class Postgres
  include EnvUtils

  def initialize
    @logger = Logger.new($stdout)
    @env = retrieve_vessel_name
  end

  def clear_savefue_db
    connection = generate_connection('safevue')
    connection.exec("DELETE FROM form WHERE id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} safevue form deleted")

    connection.exec("DELETE FROM comment WHERE form_id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} safevue comment deleted")
  end

  def clear_reporting_db
    connection = generate_connection('reporting')
    # risk tables
    connection.exec("DELETE FROM risk_assessment_best_practices WHERE id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} risk_assessment_best_practices deleted")

    connection.exec("DELETE FROM risk_assessment_near_misses WHERE id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} risk_assessment_near_misses deleted")

    connection.exec("DELETE FROM risk_assessment_new_hazards WHERE id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} risk_assessment_new_hazards deleted")

    connection.exec("DELETE FROM risk_assessment_new_measures WHERE id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} risk_assessment_new_measures deleted")

    # vm tables
    connection.exec("DELETE FROM vw_enclosed_space_entry WHERE id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} vw_enclosed_space_entry deleted")

    connection.exec("DELETE FROM vw_permit_archive WHERE id LIKE '%#{@env.upcase}%';")
    @logger.info("#{@env} vw_permit_archive deleted")
  end

  private

  def generate_connection(database)
    config = retrieve_env_file['postgres'][database]

    connection = PG::Connection.new(host: config['host'], user: config['username'],
                                    dbname: format(config['database'], env: retrieve_db_env),
                                    port: '5432', password: config['password'])
    @logger.info("Successfully created connection to #{database}")
    connection
  end

  def retrieve_db_env
    if (ENV['ENVIRONMENT'] == 'sit') || (ENV['ENVIRONMENT'] == 'auto')
      'sit'
    else
      'uat'
    end
  end
end
