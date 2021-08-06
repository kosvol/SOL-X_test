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

  # @clear-pre-gas-table
  # Scenario: PRE DB reset
  #   Given I clear gas reader entries
  #   And I clear wearable history and active users

  # @clear-cre-gas-table
  # Scenario: CRE DB reset
  #   And I clear gas reader entries
  #   And I clear wearable history and active users

  @clear-mariadb
  Scenario: Maria DB reset
    Given I clear mariadb

  # @switch-vessel-cot
  # Scenario: Switch vessel
  #   Given I switch vessel to COT

  # @update_mas_pin
  # Scenario: Get master details
  #   Given I update master pin

  @load-workload-data
  Scenario: Load workload data
    Given I clear work rest table
    Then I load workload data

  @update_crew_member_vessel
  Scenario Outline: Update crew members vessel
    Given I update crew members to <vessel_type> vessel with <regex> regex

    Examples:
      | vessel_type    | regex      |
      | sit-lng-vessel | (?i)SITLNG |
      | sit-vessel     | (?i)SITCOT |
      | sit-fsu-vessel | (?i)SITFSU |

# @removed-crew-from-vessel
# Scenario: Removed crew from vessel
#   Given I remove crew from vessel

# @dump_wb_step_records
# Scenario: Dumped wellbeing portal step records
#   Given I truncate and dump step records