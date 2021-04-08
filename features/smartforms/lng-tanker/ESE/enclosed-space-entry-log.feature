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
    Then I should see no new entry log message

  Scenario: Check button Send Report is disabled
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I enter new entry log
    Then I check the Send Report button is disabled

  Scenario: Check button Send Report is enabled
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I enter new entry log
    And I fill entry report with 5 required entrants
    Then I check the Send Report button is enabled

  Scenario: Check enabled selected Entrants on New Entry page
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I enter new entry log
    And I fill entry report with 5 required entrants
    Then I should see required entrants count equal 5

  Scenario: Check names of  selected Entrants on New Entry page
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I enter new entry log
    And I fill entry report with 5 required entrants
    Then I check names of entrants 5 on New Entry page

  Scenario: Check Enclosed Spaces Entry  first log
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And Get PRE id
    And I enter new entry log
    And I fill entry report with 2 required entrants
    And I send Report
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    And I click on entry log tab
    And I click on back arrow
    And I click on back arrow
    And I sleep for 20 seconds
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    Then I should see only entry log message

  Scenario: Check Enclosed Spaces Entry LOG values
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I take note of issued date and time
    And I click New Entrant button on Enclose Space Entry PWT
    And Get PRE id
    And I enter new entry log
    And I fill entry report with 1 required entrants
    And I send Report
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    And I sleep for 5 seconds
    Then I should see entry log details display as filled api

  Scenario: Entry log should indicate "Competent Person" on PWT view
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I take note of issued date and time
    And I click New Entrant button on Enclose Space Entry PWT
    And Get PRE id
    And I enter new entry log
    And I fill entry report with 1 required entrants
    And I send Report
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    And I sleep for 5 seconds
    Then I check all header-cells in Entry log table on PWT

  Scenario: Entry log should indicate "Competent Person" on Dashboard
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I take note of issued date and time
    And I click New Entrant button on Enclose Space Entry PWT
    And Get PRE id
    And I enter new entry log
    And I fill entry report with 1 required entrants
    And I send Report
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    And I sleep for 5 seconds
    And I click on back arrow
    And I click on back arrow
    And I launch sol-x portal dashboard
    And I go to ESE log in dashboard
    And I check all header-cells in Entry log table on Dashboard