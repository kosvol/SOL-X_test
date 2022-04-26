@global-reset
Feature: DB reset

  @clear_couch
  Scenario: clean couch db data
    Given DB service clear couch table
      | db_type | table                  |
      | edge    | forms                  |
      | cloud   | forms                  |
      | cloud   | office_approval_events |
      | edge    | gas_reader_entry       |
      | cloud   | gas_reader_entry       |
      | edge    | geofence               |
      | edge    | alerts                 |

  @clear_postgres
  Scenario: clean postgres data
    Given DB service clear postgres data


#  @load-workload-data
#  Scenario: Load workload data
#    Given I clear work rest table
#    Then I load workload data
#
#  @update_auto_crew_member_vessel
#  Scenario Outline: Update SIT crew members vessel
#    Given I update crew members to <vessel_type> vessel with <regex> regex
#
#    Examples:
#      | vessel_type     | regex         |
#       | AUTO-LNG-VESSEL | (?i)SITLNG |
#      | AUTO-COT-VESSEL | (?i)AUTO_SOLX |
# | AUTO-FSU-VESSEL | (?i)SITFSU |

# @removed-crew-from-vessel
# Scenario: Removed crew from vessel
#   Given I remove crew from vessel

# @dump_wb_step_records
# Scenario: Dumped wellbeing portal step records
#   Given I truncate and dump step records