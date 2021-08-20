@PRE-display
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

  Scenario: Verify PRE permit hand over is working
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details via service
    And I enter new entry log
    And I send entry report with 1 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 10 seconds
    And I acknowledge the new entry log via service
    Then I should see entry log details display as filled
    When I submit a scheduled PRE permit
    And  I activate PRE form via service
    #And I dismiss gas reader dialog box
    And I click on permit tab
    Then I should see new PRE permit number
    And I terminate the PRE permit via service
  # And I should see entry log data transfer to new permit

  Scenario: Verify entrant crew list displayed the correct entrants
    Given I clear gas reader entries
    When I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log pre via service
    Then I should see correct signed in entrants
    And I terminate the PRE permit via service

  Scenario: Verify crew already entered pumproom should not be listed on optional crew list
    Given I clear gas reader entries
    When I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 1 optional entrants
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log pre via service
    Then I should see entrant count equal 2
    And I enter new entry log
    Then I should not see entered entrant on optional entrant list
    And I terminate the PRE permit via service

  Scenario: Verify PRE duration display on PRED
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details via service
    Then I should see timer countdown
    And I terminate the PRE permit via service

  Scenario: Verify entry log details populated as filled
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details via ui
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log via service
    Then I should see entry log details display as filled
    And I terminate the PRE permit via service

  Scenario: Verify PRE permit creator name display on PRED
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new PRE
    And I enter pin via service for rank 3/O
    And I fill up PRE. Duration 4. Delay to activate 3
    And for pre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I take note of PRE permit creator name and activate the the current PRE form
    And I activate PRE form via service
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    Then I should see the PRE permit creator name on PRED
    And I terminate the PRE permit via service

  Scenario: Verify ship local time shift on PRED
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details via ui
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log via service
    And I should see PRE display timezone
    And I terminate the PRE permit via service

  Scenario: Verify exit time update to timestamp an entrant count updated after entrant sign out
    Given I clear gas reader entries
    When I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log pre via service
    And I signout the entrant
    Then I should see entrant count equal 0
    And I should see exit timestamp updated
    And I terminate the PRE permit via service

  Scenario: Verify PRE gas entry popup don't show if no difference in gas reading
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details via service
    And I enter same entry log
    And I send entry report with 0 optional entrants
    #And I dismiss gas reader dialog box
    And I sleep for 3 seconds
    Then I shoud not see dashboard gas reading popup
    And I terminate the PRE permit via service

  Scenario: Verify PRE gas entry popup display if there is difference in gas reading
    Given I launch sol-x portal without unlinking wearable
    When I fill and submit PRE permit details via service
    And I enter new entry log
    And I send entry report with 0 optional entrants
    #And I dismiss gas reader dialog box
    And I sleep for 5 seconds
    Then I should see dashboard gas reading popup
    And I terminate the PRE permit via service

  Scenario: Verify only 2 total entrant is valid after entry log approval with optional entrant
    Given I clear gas reader entries
    When I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 1 optional entrants
    And I dismiss gas reader dialog box
    And I sleep for 4 seconds
    And I acknowledge the new entry log pre via service
    Then I should see entrant count equal 2
    And I terminate the PRE permit via service

  Scenario: Verify only 1 total entrant is valid after entry log approval
    Given I clear gas reader entries
    When I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I sleep for 5 seconds
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log pre via service
    And I sleep for 3 seconds
    Then I should see entrant count equal 1
    And I terminate the PRE permit via service

  Scenario: Verify total entrant count is valid before entry log approval
    Given I clear gas reader entries
    When I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I sleep for 3 seconds
    And I dismiss gas reader dialog box
    #And I sleep for 3 seconds
    Then I should see entrant count equal 0
    And I terminate the PRE permit via service

  Scenario Outline: Verify role which CANNOT navigate to Pump Room Entry Display (6024)
    Given I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank <role>
    Then I should see not authorize error message

    Examples:
      | role |
      | C/O  |
      | ETO  |
      | D/C  |
      | BOS  |
      | A/B  |
      | O/S  |
      | OLR  |

  Scenario Outline: Verify role which CAN navigate to Pump Room Entry Display (6024)
    Given I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank <role>
    Then I should see the header 'Pump Room Entry Display'

    Examples:
      | role  |
      | MAS   |
      | C/O   |
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
    Then I navigate to create new PRE
    And I enter pin via service for rank C/O
    And I fill up PRE. Duration 4. Delay to activate 3
    And for pre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I activate the current PRE form
    And I activate PRE form via service
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
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

  Scenario: PRE should not displayed permit terminated when new PRE permit is created
    Given I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I should see Permit Activated PRE status on screen
    And I should see green background color
    When I submit a scheduled PRE permit
    And I sleep for 30 seconds
    And I should see green background color

  Scenario: Verify PRE permit is terminated after terminating via dashboard popup
    Given I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    Then I add new entry "A 2/O,3/O,A 3/O,4/O" PRE
    And I terminate the PRE permit via service
    And I sleep for 10 seconds
    # Then I should see PRE activity status change to inactive
    And I should see Permit Terminated PRE status on screen
    Then I should see red background color

  Scenario: [PRED] Verify PRED displays green screen automatically after PRE becomes active
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    Then I fill and submit PRE permit details via ui
    And I should see Permit Activated PRE status on screen
    And I should see green background color
    And (for pred) I should see the enabled "Home" button
    And (for pred) I should see the enabled "Entry Log" button
    And (for pred) I should see the enabled "Permit" button
    And (for pred) I should see warning box for activated status

  Scenario: [PRED] Verify PRED can't add entry without initial gas readings
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    Then I fill and submit PRE permit details via without gas readings
    And I should see Permit Activated PRE status on screen
    And I should see green background color
    And (for pred) I should see warning box for activated status
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I should not see gas reader dialog box

  Scenario: PRED Entry log - Verify user stays in Entry log tab when after submitting gas readings
    Given I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I enter new entry log
    And I send entry report with 2 optional entrants
    And I sleep for 5 seconds
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log pre via service
    #And I sleep for 3 seconds
    #And I acknowledge the new entry log pre via service
    And I sleep for 3 seconds
    And I should see Entry Log tab

  Scenario Outline: Verify Non AGT and Gas Tester cannot submit entry log in PRED
    Given I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I click on new entry log button
    And I enter pin via service for rank <rank>
    Then I should see not authorize error message

    Examples:
      | rank  |
      | SAA   |
      | RDCRW |
      | ETR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | RDCRW |
      | SPM   |


  Scenario Outline: Verify AGT  can submit entry log in PRED
    Given I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I click on new entry log button
    And I enter pin via service for rank <rank>
    And I enter without sign new entry log
    And I sign for gas
    And I send entry report with 1 optional entrants
    Examples:
      | rank  |
      | MAS   |
      | C/O   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |


  Scenario Outline: Verify gas testers can submit entry log in PRED
    Given I submit a activated PRE permit
    And I launch sol-x portal without unlinking wearable
    And I navigate to PRE Display
    And I enter pin via service for rank C/O
    And I click on new entry log button
    And I enter pin via service for rank <rank>
    And I enter without sign new entry log
    And I sign for gas
    And I send entry report with 1 optional entrants
    Examples:
      | rank  |
      | 4/O   |
      | D/C   |
      | A4O   |
      | 5/O   |
      | BOS   |
      | A/B   |
      | O/S   |
      | C/E   |
      | ACE   |
      | 2/E   |
      | A2E   |
      | 3/E   |
      | A3E   |
      | CGENG |
      | 4/E   |
      | A4E   |
      | T/E   |
      | 5/E   |
      | PMN   |
      | FTR   |
      | OLR   |