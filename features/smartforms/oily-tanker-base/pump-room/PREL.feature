@PREL
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

  Scenario: Verify PRE permit is terminated after terminating via dashboard popup
    Given  I submit a scheduled PRE permit
    And I activate PRE form via service
    When I launch sol-x portal dashboard
    And I sleep for 3 seconds
    And I open new dashboard page
    And I sleep for 3 seconds
    And I switch to first tab in browser
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 3 optional entrants
    And I switch to last tab in browser
    Then I should see alert message
    And I click terminate new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see red background color
    And I should see Permit Terminated PRE status on screen

  Scenario: PRE Dashboard Gas reading pop up should have a independent close option
    Given I get active PRE permit and terminate
    When I get active CRE permit and terminate
    When I submit a activated PRE permit
    When I launch sol-x portal dashboard
    And I sleep for 5 seconds
    And I open new dashboard page
    And I switch to first tab in browser
    And I navigate to PRE Display
    And I enter pin via service for rank A C/O
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I acknowledge the new entry log pre via service
    And I sleep for 5 seconds
    And I dismiss gas reader dialog box
    And I click on back arrow
    And I enter random entry log with role 2/O
    And I send entry report with 1 optional entrants
    And I sleep for 5 seconds
    And I switch to last tab in browser
    Then I should see alert message
    And I click close new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see alert message

  Scenario: Dashboard - Verify updated view and icon is displayed in Dashboard main page for entry log and PRE status
    Given I launch sol-x portal
    And I get active PRE permit and terminate
    And I get active CRE permit and terminate
    When I check PRE elements on dashboard inactive
    When I submit a activated PRE permit
    And I sleep for 3 seconds
    And I add new entry "A 2/O" PRE
    And I sleep for 3 seconds
    And I acknowledge the new entry log pre via service
    And I sleep for 5 seconds
    When I check PRE elements on dashboard active
