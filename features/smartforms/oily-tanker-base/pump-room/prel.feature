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
     And I enter pin for rank C/O
     And I enter new entry log
     And I send entry report with 3 optional entrants
     And I switch to last tab in browser
     Then I should see alert message
     And I click terminate new gas readings on dashboard page
     And I enter pin 2761
     And I switch to first tab in browser
     Then I should see red background color
     And I should see Permit Terminated PRE status on screen

  Scenario: PRE Dashboard Gas reading pop up should have a independent close option
    Given I launch sol-x portal
    When I submit a current CRE permit via service
    And I sleep for 3 seconds
    And I add new entry "A 2/O" CRE
    And I sleep for 3 seconds
    And I acknowledge the new entry log cre via service
    And I sleep for 5 seconds
    And I add new entry "3/O,A 3/O" CRE with different gas readings
    And I sleep for 20 seconds
    Then I should see alert message