@PRE-display
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

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
    And I sleep for 10 seconds
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
