@PRE-display
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

  Scenario: Verify entrant count and entries log persist for an overlapped or immediate scheduled PRE

  # Scenario: Verify PRE turn No Active on dashboard after PRE permit terminated

  # Scenario: Verify PRE entry log count on dashboard after entry log approval

  Scenario: Verify historic entry logs displayed on dashboard

  Scenario: Verify PRE permit creator name display on PRED

  Scenario: Verify ship local time shift on PRED

  Scenario: Verify PRE duration display on PRED

  Scenario: Verify entrant count updated after sign out

  Scenario: Verify exit time update to timestamp after entrant sign out

  Scenario: Verify only 2 total entrant is valid after entry log approval with optional entrant

  Scenario: Verify only 1 total entrant is valid after entry log approval
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new PRE
    And I enter pin 8383
    And I fill up PRE. Duration 4. Delay to activate 1
    And I add all gas readings
    And I enter pin 9015
    And I dismiss gas reader dialog box
    And (for pre) I submit permit for Officer Approval
    And I getting a permanent number from indexedDB
    And I activate the current PRE form
    And I sleep for 80 seconds
    And I navigate to PRE Display
    And I enter pin 8383
    And I submit a new entry log
    And I acknowledge the new entry log via service
    Then I should see entrant count equal 1

  Scenario: Verify total entrant count is valid before entry log approval
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new PRE
    And I enter pin 8383
    And I fill up PRE. Duration 4. Delay to activate 1
    And I add all gas readings
    And I enter pin 9015
    And I dismiss gas reader dialog box
    And (for pre) I submit permit for Officer Approval
    And I getting a permanent number from indexedDB
    And I activate the current PRE form
    And I sleep for 70 seconds
    And I navigate to PRE Display
    And I enter pin 8383
    And I submit a new entry log
    Then I should see entrant count equal 0

  Scenario Outline: Verify role which CANNOT navigate to Pump Room Entry Display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin <pin>
    Then I should see not authorize error message

    Examples:
      | role                       | pin  |
      | Second Officer             | 6268 |
      | Additional Second Officer  | 7865 |
      | 3/O                        | 0159 |
      | A 3/O                      | 2674 |
      | Addtional Master           | 9015 |
      | Electro Technical Officer  | 0856 |
      | Additional Second Engineer | 3030 |
      | D/C                        | 2317 |
      | 3/E                        | 4685 |
      | A 3/E                      | 6727 |
      | 4/E                        | 1311 |
      | A 4/E                      | 0703 |
      | BOS                        | 1018 |
      | A/B                        | 6316 |
      | O/S                        | 7669 |
      | OLR                        | 0450 |

  Scenario Outline: Verify role which CAN navigate to Pump Room Entry Display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin <pin>
    Then I should see the label 'Pump Room Entry Display'

    Examples:
      | role            | pin  |
      | Master          | 1111 |
      | Chief Officer   | 8383 |
      | Chief Engineer  | 8248 |
      | Second Engineer | 2523 |

  Scenario: Verify the PRED background color and buttons depends on the activity PRE.
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new PRE
    And I enter pin 8383
    And I fill up PRE. Duration 4. Delay to activate 1
    And (for pre) I submit permit for Officer Approval
    And I getting a permanent number from indexedDB
    And I activate the current PRE form
    And I sleep for 80 seconds
    And I navigate to PRE Display
    And I enter pin 8383
    And I should see Permit Activated PRE status on screen
    And I should see green background color
    And (for pred) I should see the enabled "Home" button
    And (for pred) I should see the enabled "Entry Log" button
    And (for pred) I should see the enabled "Permit" button
    And (for pred) I should see warning box for activated status
    And (for pred) I should see warning box "Gas reading is missing" on "Entry log"
    Then I set the activity end time in 1 minutes
    And I sleep for 120 seconds
    And I should see red background color
    And I should see Permit Terminated PRE status on screen
    And (for pred) I should see the enabled "Home" button
    And (for pred) I should see the disabled "Entry Log" button
    And (for pred) I should see the disabled "Permit" button
    And (for pred) I should see warning box for deactivated status
