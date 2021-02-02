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

  @clear-mariadb
  Scenario: Maria DB reset
    Given I clear mariadb