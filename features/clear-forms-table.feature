@global-reset
Feature: DB reset
  As a ...
  I want to ...
  So that ...

  @clear-forms-table
  Scenario: DB reset
    Given I clear forms table
    And I clear oa event table
    And I clear oa forms table
    And I clear gas reader entries
    And I clear geofence
    Given I clear gas reader entries
    And I clear wearable history and active users
    Given I clear postgres db for auto
    
  @load-workload-data
  Scenario: Load workload data
    Given I clear work rest table
    Then I load workload data

  @update_sit_crew_member_vessel
  Scenario Outline: Update SIT crew members vessel
    Given I update crew members to <vessel_type> vessel with <regex> regex

    Examples:
      | vessel_type    | regex      |
      | SIT-LNG-VESSEL | (?i)SITLNG |
      | SIT-COT-VESSEL | (?i)SITCOT |
      | SIT-FSU-VESSEL | (?i)SITFSU |

  @update_auto_crew_member_vessel
  Scenario Outline: Update SIT crew members vessel
    Given I update crew members to <vessel_type> vessel with <regex> regex

    Examples:
      | vessel_type    | regex      |
      # | AUTO-LNG-VESSEL | (?i)SITLNG |
      | AUTO-COT-VESSEL | (?i)AUTO_SOLX |
      # | AUTO-FSU-VESSEL | (?i)SITFSU |

# @removed-crew-from-vessel
# Scenario: Removed crew from vessel
#   Given I remove crew from vessel

# @dump_wb_step_records
# Scenario: Dumped wellbeing portal step records
#   Given I truncate and dump step records