@enclosed-space-ent
Feature: EnclosedSpaceEntryLog
  As a ...
  I want to ...
  So that ...

  Scenario: Check Enclosed Spaces Entry log is empty
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    Then I should see no new entry log message in Entry log

  Scenario: Check button Send Report is disabled
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I add normal gas readings
    And I review and sign gas readings
    And I enter pin 8383
    Then I check the Send Report button is disabled

  Scenario: Check button Send Report is enabled
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I add normal gas readings
    And I review and sign gas readings
    And I enter pin 8383
    And I select entrants 5
    Then I check the Send Report button is enabled

  Scenario: Check enabled selected Entrants on New Entry page
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I add normal gas readings
    And I review and sign gas readings
    And I enter pin 8383
    And I sleep for 20 seconds
    And I select entrants 5
    Then I check entrants in list 5

  Scenario: Check names of  selected Entrants on New Entry page
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I add normal gas readings
    And I review and sign gas readings
    And I enter pin 8383
    Then I check names of entrants 3 on New Entry page

  Scenario: Check Enclosed Spaces Entry  first log
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I add normal gas readings
    And I review and sign gas readings
    And I enter pin 8383
    And I select entrants 2
    And I send Report
    And I just click button Home
    And I just click on back arrow
    And I just click on back arrow
    And I sleep for 30 seconds
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    Then I should not see empty form elements