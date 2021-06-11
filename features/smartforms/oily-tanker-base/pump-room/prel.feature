@PREL
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

   Scenario: Verify PRE permit is terminated after terminating via dashboard popup
     Given  I submit a scheduled PRE permit
     And I activate PRE form via service
     When I launch sol-x portal dashboard
     And I open new dashboard page
     And I switch to first tab in browser
     And I navigate to PRE Display
     And I enter pin for rank C/O
     And I enter new entry log
     And I send entry report with 0 optional entrants
     And I switch to last tab in browser



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