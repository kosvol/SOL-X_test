@global-reset
Feature: DB reset
  As a ...
  I want to ...
  So that ...

  @clear-forms-table
  Scenario: DB reset
    Given I clear forms table
    And I clear oa event table
    And I clear gas reader entries
    Given I clear gas reader entries
    And I clear wearable history and active users
    Given I clear mariadb

  @clear-pre-gas-table
  Scenario: PRE DB reset
    Given I clear gas reader entries
    And I clear wearable history and active users

  @clear-cre-gas-table
  Scenario: CRE DB reset
    Given I clear PRE forms
    And I clear gas reader entries
    And I clear wearable history and active users

  @clear-mariadb
  Scenario: Maria DB reset
    Given I clear mariadb

  @switch-vessel
  Scenario: Switch vessel
    Given I switch vessel to COT

  @update_mas_pin
  Scenario: Get master details
    Given I update master pin

  @load-workload-data
  Scenario: Load workload data
    Given I clear work rest table
    Then I load workload data

  @update_cot_crew_member_vessel
  Scenario: Update crew members vessel
    Given I update crew members to sit-vessel vessel

  @update_lng_crew_member_vessel
  Scenario: Update crew members vessel
    Given I update crew members to sit-lng-vessel vessel

  @removed-crew-from-vessel
  Scenario: Removed crew from vessel
    Given I remove crew from vessel