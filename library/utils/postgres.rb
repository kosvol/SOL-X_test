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
    @date_from = retrieve_date_from
    @days = retrieve_days
    @heat_dsbl = retrieve_heat_disable
    @heart_dsbl = retrieve_heart_disable
    @steps_dsbl = retrieve_steps_disable
    @cotsit_enbl = retrieve_cotsit_enable
    @fsusit_enbl = retrieve_fsusit_enable
    @lngsit_enbl = retrieve_lngsit_enable
    @cotauto_enbl = retrieve_cotauto_enable
    @fsuauto_enbl = retrieve_fsuauto_enable
    @lngauto_enbl = retrieve_lngauto_enable
    @cotsit20_enbl = retrieve_cotsit20_enable
    @fsusit20_enbl = retrieve_fsusit20_enable
    @cotuat_enbl = retrieve_cotuat_enable
    @fsuuat_enbl = retrieve_fsuuat_enable
    @lnguat_enbl = retrieve_lnguat_enable
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

  def clear_dwh_db
    connection = generate_connection('dwh')
    # birthday table
    connection.exec("
  DELETE FROM fact_watch_5min WHERE time_epoch >= '1';
  DELETE FROM cube_heart_stress WHERE date_epoch >= '1';
  DELETE FROM cube_heat_stress_31 WHERE date_epoch >= '1';
  DELETE FROM cube_heat_stress_51 WHERE date_epoch >= '1';
  DELETE FROM cube_step_heat WHERE date_epoch >= '1';
  DELETE FROM cube_zone_traffic WHERE date_epoch >= '1';
  DELETE FROM cube_step_heat WHERE date_epoch >= '1';
  ")
    @logger.info("#{@env} wellbeing tables are cleared")

  end

  def clear_steps_reporting_db
    connection = generate_connection('reporting')
    # risk tables
    connection.exec("DELETE FROM public.vw_steps WHERE id >=0;")
    @logger.info("#{@env} steps table was cleared")
  end

  def insert_well_safevue_db
    connection = generate_connection('safevue')
    # -- ///COTSIT\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
    ON COMMIT drop;
    INSERT INTO cache_table VALUES

    (0 ,'SIT-COT-VESSEL' ,'COTSIT_0002' ,'00:00:00:00:00:00'), -- Deck Officer
    (60 ,'SIT-COT-VESSEL' ,'COTSIT_0009' ,'00:00:00:00:00:01'), -- Deck Rating
    (180 ,'SIT-COT-VESSEL' ,'COTSIT_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
    (300 ,'SIT-COT-VESSEL' ,'COTSIT_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
    (480 ,'SIT-COT-VESSEL' ,'COTSIT_0036' ,'00:00:00:00:00:04'), -- Admin/Catering
    (0 ,'SIT-COT-VESSEL' ,'COTSIT_0003' ,'00:00:00:00:00:05'), -- Deck Officer
    (-60 ,'SIT-COT-VESSEL' ,'COTSIT_0010' ,'00:00:00:00:00:01'), -- Deck Rating
    (-180 ,'SIT-COT-VESSEL' ,'COTSIT_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
    (-300 ,'SIT-COT-VESSEL' ,'COTSIT_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
    (-480 ,'SIT-COT-VESSEL' ,'COTSIT_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


  CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
  ON COMMIT drop;
  INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
  SELECT t.t + (days.days||' days')::INTERVAL,
    (SELECT vessel_offset
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS vessel_offset,
    (SELECT vessel_id
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS vessel_id,
    (SELECT user_id
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS user_id,
    (SELECT beacon_mac
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS beacon_mac,
     floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
       floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
       floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
       floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@cotsit_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl} (timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"

    # -- ///FSUSIT\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
      ON COMMIT drop;
      INSERT INTO cache_table VALUES

      (0 ,'SIT-FSU-VESSEL' ,'FSUSIT_0002' ,'00:00:00:00:00:01'), -- Deck Officer
      (60 ,'SIT-FSU-VESSEL' ,'FSUSIT_0009' ,'00:00:00:00:00:02'), -- Deck Rating
      (180 ,'SIT-FSU-VESSEL' ,'FSUSIT_0012' ,'00:00:00:00:00:03'), -- Engineering Officer
      (300 ,'SIT-FSU-VESSEL' ,'FSUSIT_0024' ,'00:00:00:00:00:04'), -- Engineering Rating
      (480 ,'SIT-FSU-VESSEL' ,'FSUSIT_0036' ,'00:00:00:00:00:05'), -- Admin/Catering
      (0 ,'SIT-FSU-VESSEL' ,'FSUSIT_0003' ,'00:00:00:00:00:00'), -- Deck Officer
      (-60 ,'SIT-FSU-VESSEL' ,'FSUSIT_0010' ,'00:00:00:00:00:01'), -- Deck Rating
      (-180 ,'SIT-FSU-VESSEL' ,'FSUSIT_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
      (-300 ,'SIT-FSU-VESSEL' ,'FSUSIT_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
      (-480 ,'SIT-FSU-VESSEL' ,'FSUSIT_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


    CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
    ON COMMIT drop;
    INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
    SELECT t.t + (days.days||' days')::INTERVAL,
      (SELECT vessel_offset
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS vessel_offset,
      (SELECT vessel_id
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS vessel_id,
      (SELECT user_id
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS user_id,
      (SELECT beacon_mac
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS beacon_mac,
        floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
         floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
         floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
         floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@fsusit_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl} (timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"


    # -- ///LNGSIT\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
    ON COMMIT drop;
    INSERT INTO cache_table VALUES

    (0 ,'SIT-LNG-VESSEL' ,'LNGSIT_0002' ,'00:00:00:00:00:00'), -- Deck Officer
    (60 ,'SIT-LNG-VESSEL' ,'LNGSIT_0009' ,'00:00:00:00:00:01'), -- Deck Rating
    (180 ,'SIT-LNG-VESSEL' ,'LNGSIT_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
    (300 ,'SIT-LNG-VESSEL' ,'LNGSIT_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
    (480 ,'SIT-LNG-VESSEL' ,'LNGSIT_0036' ,'00:00:00:00:00:04'), -- Admin/Catering
    (0 ,'SIT-LNG-VESSEL' ,'LNGSIT_0003' ,'00:00:00:00:00:05'), -- Deck Officer
    (-60 ,'SIT-LNG-VESSEL' ,'LNGSIT_0010' ,'00:00:00:00:00:01'), -- Deck Rating
    (-180 ,'SIT-LNG-VESSEL' ,'LNGSIT_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
    (-300 ,'SIT-LNG-VESSEL' ,'LNGSIT_0025' ,'00:00:00:00:00:03') -- Engineering Rating
    ,(-480 ,'SIT-LNG-VESSEL' ,'LNGSIT_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


    CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
    ON COMMIT drop;
    INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
    SELECT t.t + (days.days||' days')::INTERVAL,
    (SELECT vessel_offset
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS vessel_offset,
    (SELECT vessel_id
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS vessel_id,
    (SELECT user_id
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS user_id,
    (SELECT beacon_mac
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS beacon_mac,
     floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
       floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
       floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
       floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@lngsit_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl} (timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"


    # -- ///AUTOCOT\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
      ON COMMIT drop;
      INSERT INTO cache_table VALUES

      (0 ,'AUTO-COT-VESSEL' ,'COTAUTO_0002' ,'00:00:00:00:00:00'), -- Deck Officer
      (60 ,'AUTO-COT-VESSEL' ,'COTAUTO_0009' ,'00:00:00:00:00:01'), -- Deck Rating
      (180 ,'AUTO-COT-VESSEL' ,'COTAUTO_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
      (300 ,'AUTO-COT-VESSEL' ,'COTAUTO_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
      (480 ,'AUTO-COT-VESSEL' ,'COTAUTO_0036' ,'00:00:00:00:00:04'), -- Admin/Catering
      (0 ,'AUTO-COT-VESSEL' ,'COTAUTO_0003' ,'00:00:00:00:00:05'), -- Deck Officer
      (-60 ,'AUTO-COT-VESSEL' ,'COTAUTO_0010' ,'00:00:00:00:00:01'), -- Deck Rating
      (-180 ,'AUTO-COT-VESSEL' ,'COTAUTO_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
      (-300 ,'AUTO-COT-VESSEL' ,'COTAUTO_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
      (-480 ,'AUTO-COT-VESSEL' ,'COTAUTO_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


    CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
    ON COMMIT drop;
    INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
    SELECT t.t + (days.days||' days')::INTERVAL,
      (SELECT vessel_offset
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS vessel_offset,
      (SELECT vessel_id
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS vessel_id,
      (SELECT user_id
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS user_id,
      (SELECT beacon_mac
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS beacon_mac,
        floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
         floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
         floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
         floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@cotauto_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl} (timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"


    # -- ///AUTOFSU\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
    ON COMMIT drop;
    INSERT INTO cache_table VALUES

    (0 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0002' ,'00:00:00:00:00:01'), -- Deck Officer
    (60 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0009' ,'00:00:00:00:00:02'), -- Deck Rating
    (180 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0012' ,'00:00:00:00:00:03'), -- Engineering Officer
    (300 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0024' ,'00:00:00:00:00:04'), -- Engineering Rating
    (480 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0036' ,'00:00:00:00:00:05'), -- Admin/Catering
    (0 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0003' ,'00:00:00:00:00:01'), -- Deck Officer
    (-60 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0010' ,'00:00:00:00:00:02'), -- Deck Rating
    (-180 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0013' ,'00:00:00:00:00:03'), -- Engineering Officer
    (-300 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0025' ,'00:00:00:00:00:04'), -- Engineering Rating
    (-480 ,'AUTO-FSU-VESSEL' ,'FSUAUTO_0038' ,'00:00:00:00:00:00'); -- Admin/Catering



    CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
    ON COMMIT drop;
    INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
    SELECT t.t + (days.days||' days')::INTERVAL,
    (SELECT vessel_offset
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS vessel_offset,
    (SELECT vessel_id
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS vessel_id,
    (SELECT user_id
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS user_id,
    (SELECT beacon_mac
    FROM cache_table
    ORDER BY random()
    LIMIT 1) AS beacon_mac,
     floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
       floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
       floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
       floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@fsuauto_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl} (timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"


    # -- ///AUTOLNG\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
      ON COMMIT drop;
      INSERT INTO cache_table VALUES

      (0 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0002' ,'00:00:00:00:00:00'), -- Deck Officer
      (60 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0009' ,'00:00:00:00:00:01'), -- Deck Rating
      (180 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
      (300 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
      (480 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0036' ,'00:00:00:00:00:04'), -- Admin/Catering
      (0 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0003' ,'00:00:00:00:00:05'), -- Deck Officer
      (-60 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0010' ,'00:00:00:00:00:01'), -- Deck Rating
      (-180 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
      (-300 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
      (-480 ,'AUTO-LNG-VESSEL' ,'LNGAUTO_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


    CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
    ON COMMIT drop;
    INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
    SELECT t.t + (days.days||' days')::INTERVAL,
      (SELECT vessel_offset
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS vessel_offset,
      (SELECT vessel_id
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS vessel_id,
      (SELECT user_id
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS user_id,
      (SELECT beacon_mac
       FROM cache_table
       ORDER BY random()
       LIMIT 1) AS beacon_mac,
        floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
         floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
         floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
         floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@lngauto_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl} (timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"

    # -- ///COTSIT_20\\\ -- #

    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
    ON COMMIT drop;
    INSERT INTO cache_table VALUES

    (0 ,'SIT20-COT-VESSEL' ,'COTSIT20_0002' ,'00:00:00:00:00:01'), -- Deck Officer
    (60 ,'SIT20-COT-VESSEL' ,'COTSIT20_0009' ,'00:00:00:00:00:02'), -- Deck Rating
    (180 ,'SIT20-COT-VESSEL' ,'COTSIT20_0012' ,'00:00:00:00:00:03'), -- Engineering Officer
    (300 ,'SIT20-COT-VESSEL' ,'COTSIT20_0024' ,'00:00:00:00:00:04'), -- Engineering Rating
    (480 ,'SIT20-COT-VESSEL' ,'COTSIT20_0020' ,'00:00:00:00:00:05'), -- non Admin/Catering
    (0 ,'SIT20-COT-VESSEL' ,'COTSIT20_0003' ,'00:00:00:00:00:00'), -- Deck Officer
    (-60 ,'SIT20-COT-VESSEL' ,'COTSIT20_0010' ,'00:00:00:00:00:01'), -- Deck Rating
    (-180 ,'SIT20-COT-VESSEL' ,'COTSIT20_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
    (-300 ,'SIT20-COT-VESSEL' ,'COTSIT20_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
    (-480 ,'SIT20-COT-VESSEL' ,'COTSIT20_0021' ,'00:00:00:00:00:04'); -- non Admin/Catering


  CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
  ON COMMIT drop;
  INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
  SELECT t.t + (days.days||' days')::INTERVAL,
    (SELECT vessel_offset
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS vessel_offset,
    (SELECT vessel_id
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS vessel_id,
    (SELECT user_id
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS user_id,
    (SELECT beacon_mac
     FROM cache_table
     ORDER BY random()
     LIMIT 1) AS beacon_mac,
     floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
       floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
       floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
       floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@cotsit20_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl} (timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"

    # -- ///FSUSIT_20\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
      ON COMMIT drop;
      INSERT INTO cache_table VALUES

      (0 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0002' ,'00:00:00:00:00:00'), -- Deck Officer
      (60 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0009' ,'00:00:00:00:00:01'), -- Deck Rating
      (180 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
      (300 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
      (480 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0020' ,'00:00:00:00:00:04'), -- non Admin/Catering
      (0 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0003' ,'00:00:00:00:00:05'), -- Deck Officer
      (-60 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0010' ,'00:00:00:00:00:01'), -- Deck Rating
      (-180 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
      (-300 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
      (-480 ,'SIT20-FSU-VESSEL' ,'FSUSIT20_0021' ,'00:00:00:00:00:04'); -- non Admin/Catering


      CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
      ON COMMIT drop;
      INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
      SELECT t.t + (days.days||' days')::INTERVAL,
      (SELECT vessel_offset
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_offset,
      (SELECT vessel_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_id,
      (SELECT user_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS user_id,
      (SELECT beacon_mac
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS beacon_mac,
        floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
         floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
         floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
         floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@fsusit20_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"


    # -- ///COT_UAT\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
      ON COMMIT drop;
      INSERT INTO cache_table VALUES

    (0 ,'UAT-COT-VESSEL' ,'COTUAT_0002' ,'00:00:00:00:00:00'), -- Deck Officer
    (60 ,'UAT-COT-VESSEL' ,'COTUAT_0009' ,'00:00:00:00:00:01'), -- Deck Rating
    (180 ,'UAT-COT-VESSEL' ,'COTUAT_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
    (300 ,'UAT-COT-VESSEL' ,'COTUAT_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
    (480 ,'UAT-COT-VESSEL' ,'COTUAT_0036' ,'00:00:00:00:00:04'), -- Admin/Catering
    (0 ,'UAT-COT-VESSEL' ,'COTUAT_0003' ,'00:00:00:00:00:05'), -- Deck Officer
    (-60 ,'UAT-COT-VESSEL' ,'COTUAT_0010' ,'00:00:00:00:00:01'), -- Deck Rating
    (-180 ,'UAT-COT-VESSEL' ,'COTUAT_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
    (-300 ,'UAT-COT-VESSEL' ,'COTUAT_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
    (-480 ,'UAT-COT-VESSEL' ,'COTUAT_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


      CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
      ON COMMIT drop;
      INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
      SELECT t.t + (days.days||' days')::INTERVAL,
      (SELECT vessel_offset
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_offset,
      (SELECT vessel_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_id,
      (SELECT user_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS user_id,
      (SELECT beacon_mac
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS beacon_mac,
        floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
         floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
         floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
         floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@cotuat_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"

    # -- ///FSUUAT\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
      ON COMMIT drop;
      INSERT INTO cache_table VALUES

    (0 ,'UAT-FSU-VESSEL' ,'FSUUAT_0002' ,'00:00:00:00:00:00'), -- Deck Officer
    (60 ,'UAT-FSU-VESSEL' ,'FSUUAT_0009' ,'00:00:00:00:00:01'), -- Deck Rating
    (180 ,'UAT-FSU-VESSEL' ,'FSUUAT_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
    (300 ,'UAT-FSU-VESSEL' ,'FSUUAT_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
    (480 ,'UAT-FSU-VESSEL' ,'FSUUAT_0036' ,'00:00:00:00:00:04'), -- Admin/Catering
    (0 ,'UAT-FSU-VESSEL' ,'FSUUAT_0003' ,'00:00:00:00:00:05'), -- Deck Officer
    (-60 ,'UAT-FSU-VESSEL' ,'FSUUAT_0010' ,'00:00:00:00:00:01'), -- Deck Rating
    (-180 ,'UAT-FSU-VESSEL' ,'FSUUAT_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
    (-300 ,'UAT-FSU-VESSEL' ,'FSUUAT_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
    (-480 ,'UAT-FSU-VESSEL' ,'FSUUAT_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


      CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
      ON COMMIT drop;
      INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
      SELECT t.t + (days.days||' days')::INTERVAL,
      (SELECT vessel_offset
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_offset,
      (SELECT vessel_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_id,
      (SELECT user_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS user_id,
      (SELECT beacon_mac
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS beacon_mac,
        floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
         floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
         floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
         floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@fsuuat_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"

    # -- ///LNGUAT\\\ -- #
    connection.exec "CREATE TEMP TABLE cache_table(vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr)
      ON COMMIT drop;
      INSERT INTO cache_table VALUES

    (0 ,'UAT-LNG-VESSEL' ,'LNGUAT_0002' ,'00:00:00:00:00:00'), -- Deck Officer
    (60 ,'UAT-LNG-VESSEL' ,'LNGUAT_0009' ,'00:00:00:00:00:01'), -- Deck Rating
    (180 ,'UAT-LNG-VESSEL' ,'LNGUAT_0012' ,'00:00:00:00:00:02'), -- Engineering Officer
    (300 ,'UAT-LNG-VESSEL' ,'LNGUAT_0024' ,'00:00:00:00:00:03'), -- Engineering Rating
    (480 ,'UAT-LNG-VESSEL' ,'LNGUAT_0036' ,'00:00:00:00:00:04'), -- Admin/Catering
    (0 ,'UAT-LNG-VESSEL' ,'LNGUAT_0003' ,'00:00:00:00:00:05'), -- Deck Officer
    (-60 ,'UAT-LNG-VESSEL' ,'LNGUAT_0010' ,'00:00:00:00:00:01'), -- Deck Rating
    (-180 ,'UAT-LNG-VESSEL' ,'LNGUAT_0013' ,'00:00:00:00:00:02'), -- Engineering Officer
    (-300 ,'UAT-LNG-VESSEL' ,'LNGUAT_0025' ,'00:00:00:00:00:03'), -- Engineering Rating
    (-480 ,'UAT-LNG-VESSEL' ,'LNGUAT_0038' ,'00:00:00:00:00:04'); -- Admin/Catering


      CREATE TEMP TABLE cache_data(timestamp timestamp, vessel_offset int2, vessel_id text, user_id text,beacon_mac macaddr, temperature float8, humidity float8, heart_rate numeric, steps float8 )
      ON COMMIT drop;
      INSERT INTO cache_data (timestamp, vessel_offset, vessel_id, user_id, beacon_mac,temperature, humidity, heart_rate, steps)
      SELECT t.t + (days.days||' days')::INTERVAL,
      (SELECT vessel_offset
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_offset,
      (SELECT vessel_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS vessel_id,
      (SELECT user_id
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS user_id,
      (SELECT beacon_mac
      FROM cache_table
      ORDER BY random()
      LIMIT 1) AS beacon_mac,
        floor(random() * 5 + '#{18 + Random.rand(25)}')  AS temperature, -- Temperature form 18 to 18+25+5=48
         floor(random() * 30 + '#{10 + Random.rand(30)}')                AS humidity, -- Humidity form 10 to 70
         floor(random() * 80 + '#{60 + Random.rand(50)}')               as heart_rate, -- Heart rate from 60 to 190
         floor(random() * 200 + #{5 + Random.rand(75)})                as steps -- steps from 10 to 255

  FROM generate_series

  (TIMESTAMP '#{@date_from} 00:00:00' , '#{@date_from} #{1 + Random.rand(10)}:00:00',
       '5 min') t(t)

  CROSS JOIN generate_series(0, #{@days}-1) days(days)
  ORDER BY 1;
  #{@lnguat_enbl}delete from cache_data;
  #{@heat_dsbl}insert into public.humidity_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, humidity from cache_data;
  #{@heat_dsbl}insert into public.temperature_data
  #{@heat_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, temperature  from cache_data;
  #{@heart_dsbl}insert into public.heart_rate_data
  #{@heart_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, heart_rate  from cache_data;
  #{@steps_dsbl} insert into public.steps_data
  #{@steps_dsbl}(timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps)select timestamp, vessel_offset, vessel_id, user_id, beacon_mac, steps  from cache_data;"

    @logger.info("#{@env} generated data inserted to the safevue_DB - Date from: #{@date_from}; Days #{@days}; ")
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


