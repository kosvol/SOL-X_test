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


#     Given I launch sol-x portal without unlinking wearable
#     When I clear gas reader entries
#     And I navigate to create new PRE
#     And I enter pin for rank C/O
#     And I fill up PRE. Duration 4. Delay to activate 2
#     And I add all gas readings
#     And I enter pin for rank A/M
#     And I dismiss gas reader dialog box
#     And for pre I submit permit for Officer Approval
#     And I getting a permanent number from indexedDB
#     And I activate the current PRE form
#    # And I sleep for 100 seconds
#     And I navigate to PRE Display
#     And I enter pin for rank C/O
#     And I enter new entry log
#   step 'I send entry report with 0 optional entrants'
#   step 'I sleep for 3 seconds'
#   step 'I dismiss gas reader dialog box'
#   step 'I sleep for 3 seconds'
#     And I terminate from dashboard
#     And I sleep for 20 seconds
#     # Then I should see PRE activity status change to inactive
#     Then I should see red background color
#     And I should see Permit Terminated PRE status on screen
#   ### need to check if dashboard really dismiss popup; after display popup feature gap resolve


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
