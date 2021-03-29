@PRE-display
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify entrant count and entries log persist for an overlapped or immediate scheduled PRE

  Scenario: Verify entrant crew list displayed the correct entrants
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    Then I should see correct signed in entrants

  Scenario: Verify crew already entered pumproom should not be listed on optional crew list
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 1 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    Then I should see entrant count equal 2
    And I enter new entry log
    Then I should not see entered entrant on list

  Scenario: Verify PRE duration display on PRED
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    Then I should see timer countdown

  Scenario: Verify entry log details populated as filled
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    Then I should see entry log details display as filled

  Scenario: Verify PRE permit creator name display on PRED
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new PRE
    And I enter pin for rank 3/O
    And I fill up PRE. Duration 4. Delay to activate 2
    And for pre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I take note of PRE permit creator name and activate the the current PRE form
    And I sleep for 100 seconds
    And I navigate to PRE Display
    And I enter pin for rank C/O
    Then I should see the PRE permit creator name on PRED

  Scenario: Verify ship local time shift on PRED
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    And I should see PRE display timezone

  Scenario: Verify exit time update to timestamp an entrant count updated after entrant sign out
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    And I signout the entrant
    Then I should see entrant count equal 0
    And I should see exit timestamp updated

  Scenario: Verify PRE gas entry popup don't show if no difference in gas reading
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details
    And I enter same entry log
    And I send entry report with 0 optional entrants
    And I sleep for 2 seconds
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    Then I shoud not see dashboard gas reading popup

  Scenario: Verify PRE gas entry popup display if there is difference in gas reading
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I sleep for 2 seconds
    And I dismiss gas reader dialog box
    And I sleep for 5 seconds
    Then I should see dashboard gas reading popup

  Scenario: Verify only 2 total entrant is valid after entry log approval with optional entrant
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 1 optional entrants
    And I sleep for 3 seconds
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    Then I should see entrant count equal 2

  ##### dashboard termination not even implemented
  # Scenario: Verify PRE permit is terminated after terminating via dashboard popup
  #   Given I launch sol-x portal without unlinking wearable
  #   When I clear gas reader entries
  #   And I navigate to create new PRE
  #   And I enter pin for rank C/O
  #   And I fill up PRE. Duration 4. Delay to activate 2
  #   And I add all gas readings
  #   And I enter pin for rank A/M
  #   And I dismiss gas reader dialog box
  #   And for pre I submit permit for Officer Approval
  #   And I getting a permanent number from indexedDB
  #   And I activate the current PRE form
  #   And I sleep for 100 seconds
  #   And I navigate to PRE Display
  #   And I enter pin for rank C/O
  #   And I enter new entry log
  # step 'I send entry report with 0 optional entrants'
  # step 'I sleep for 3 seconds'
  # step 'I dismiss gas reader dialog box'
  # step 'I sleep for 3 seconds'
  #   And I terminate from dashboard
  #   And I sleep for 20 seconds
  #   # Then I should see PRE activity status change to inactive
  #   Then I should see red background color
  #   And I should see Permit Terminated PRE status on screen
  # ### need to check if dashboard really dismiss popup; after display popup feature gap resolve

  Scenario: Verify only 1 total entrant is valid after entry log approval
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I sleep for 5 seconds
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log via service
    And I sleep for 3 seconds
    Then I should see entrant count equal 1

  Scenario: Verify total entrant count is valid before entry log approval
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    When I fill and submit PRE permit details
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I sleep for 3 seconds
    And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    Then I should see entrant count equal 0

  Scenario Outline: Verify role which CANNOT navigate to Pump Room Entry Display (6024)
    Given I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin for rank <role>
    Then I should see not authorize error message

    Examples:
      | role  |
      | A/M   |
      | ETO   |
      | D/C   |
      | BOS   |
      | A/B   |
      | O/S   |
      | OLR   |

  Scenario Outline: Verify role which CAN navigate to Pump Room Entry Display (6024)
    Given I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin for rank <role>
    Then I should see the header 'Pump Room Entry Display'

    Examples:
      | role |
      | MAS  |
      | C/O  |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |

  Scenario: Verify the PRED background color and buttons depends on the activity PRE.
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    When I navigate to create new PRE
    And I enter pin for rank C/O
    And I fill up PRE. Duration 4. Delay to activate 2
    And for pre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I activate the current PRE form
    And I sleep for 100 seconds
    And I navigate to PRE Display
    And I enter pin for rank C/O
    And I should see Permit Activated PRE status on screen
    And I should see green background color
    And (for pred) I should see the enabled "Home" button
    And (for pred) I should see the enabled "Entry Log" button
    And (for pred) I should see the enabled "Permit" button
    And (for pred) I should see warning box for activated status
    # And (for pred) I should see warning box "Gas reading is missing" on "Entry log"
    Then I set the activity end time in 1 minutes
    And I sleep for 90 seconds
    And I should see red background color
    And I should see Permit Terminated PRE status on screen
    And (for pred) I should see the enabled "Home" button
    And (for pred) I should see the disabled "Entry Log" button
    And (for pred) I should see the disabled "Permit" button
    And (for pred) I should see warning box for deactivated status
