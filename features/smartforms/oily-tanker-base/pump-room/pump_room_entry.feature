@Pump-Room-Entry
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

  Scenario: SOL-5707 Display message on Entry Log tab if no entry records exist
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    When I fill and submit PRE permit details via service
    Then I should see no new entry log message

  Scenario: Verify menu items are displayed in hamburger menu
    Given I launch sol-x portal without unlinking wearable
    When I open hamburger menu
    And I click on PRE show more
    And I click on forms show more
    And I should see entire hamburger categories

  Scenario Outline: Verify only Pump Room Entry RO can create PRE
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank <rank>
    Then I should see PRE landing screen

    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify not Pump Room Entry RO cannot create PRE
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin for rank <rank>
    Then I should see not authorize error message

    Examples:
      | rank  | pin  |
      | MAS   | 1111 |
      | A/M   | 9015 |
      | C/E   | 8248 |
      | 2/E   | 2523 |
      | ETO   | 0856 |
      | A 2/E | 3030 |
      | D/C   | 2317 |
      | 3/E   | 4685 |
      | A 3/E | 6727 |
      | 4/E   | 1311 |
      | A 4/E | 0703 |
      | BOS   | 1018 |
      | A/B   | 6316 |
      | O/S   | 7669 |
      | OLR   | 0450 |

  Scenario: Verify in the form there are all questions
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I should see the right order of elements

  Scenario Outline: Verify submit for approval button is disable when mandatory fields not fill
    Given  I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I should see alert message "Please select the start time and duration before submitting."
    And Button "Submit for Approval" should be disabled
    Then I select Permit Duration <duration>
    And I should not see alert message "Please select the start time and duration before submitting."
    And Button "Submit for Approval" should not be disabled

    Examples:
      | duration |
      | 4        |
      | 6        |
      | 8        |

  Scenario: Verify user able to fill Date of Last Calibration
    Given  I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I select current day for field "Date of Last Calibration"

  Scenario: Verify user able to see reporting interval when YES is selected
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    And I should not see Reporting interval
    Then I click Yes to answer the question "Are the personnel entering the pump room aware of the reporting interval?"
    And I should see Reporting interval

  Scenario: Verify user can add Gas Test Record with toxic gas
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new PRE
    And I enter pin via service for rank C/O
    And I add all gas readings
    And I enter pin via service for rank A/M
    And I set time
    Then I will see popup dialog with By A/M Atif Hayat crew rank and name
    When I dismiss gas reader dialog box
    Then I should see gas reading display with toxic gas

  Scenario: Verify PRE can be terminated manually
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I fill up PRE. Duration 4. Delay to activate 3
    And Get PRE id
    And for pre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    Then I activate the current PRE form
    And I sleep for 1 seconds
    When I navigate to "Scheduled" screen for PRE
    And I should see the current PRE in the "Scheduled" list
    And I click on back arrow
    And I sleep for 180 seconds
    And I navigate to "Active" screen for PRE
    And I should see the current PRE in the "Active PRE" list
    And I click on back arrow
    Then I terminate the PRE
    When I navigate to "Terminated" screen for PRE
    And I should see the current PRE in the "Closed PRE" list

  Scenario: Verify Update needed text can be input and displayed after
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for A C/O Approval
    And I sleep for 5 seconds
    And I getting a permanent number from indexedDB
    Then I request update needed
    And for pre I should see update needed message

  Scenario: Verify creator PRE cannot request update needed
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for A C/O Approval
    And I sleep for 5 seconds
    And I getting a permanent number from indexedDB
    Then I open the current PRE with status Pending approval. Rank: C/O
    And for pre I should see the disabled "Updates Needed" button

  Scenario: Verify NOT Pump Room Entry RO CANNOT request Update needed and Approve for Activation. Only Close button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for A C/O Approval
    And I sleep for 2 seconds
    And I getting a permanent number from indexedDB
    Then (table) Buttons should be missing for the following role:
      | MAS   |
      | A/M   |
      | C/E   |
      | 2/E   |
      | ETO   |
      | A 2/E |
      | D/C   |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | BOS   |
      | A/B   |
      | O/S   |
      | OLR   |

  Scenario: Verify Created PRE is displayed in Created PRE list
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    And Get PRE id
    Then I press the "Close" button
    And I getting a permanent number from indexedDB
    And I navigate to "Created" screen for PRE
    Then I should see the current PRE in the "Created PRE" list

  Scenario Outline: Verify a creator PRE cannot activate PRE. Exception: Chief Officer
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin via service for rank <rank>
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for A C/O Approval
    And I sleep for 5 seconds
    And I getting a permanent number from indexedDB
    Then I open the current PRE with status Pending approval. Rank: <rank>
    And for pre I should see the <condition> "Approve for Activation" button

    Examples:
      | rank  | condition |
      | C/O   | enabled   |
      | A C/O | disabled  |
      | 2/O   | disabled  |
      | A 2/O | disabled  |
      | 3/O   | disabled  |
      | A 3/O | disabled  |

  Scenario: A temporary number should correctly become permanent. The form must be available by the permanent number.
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    And I get a temporary number and writing it down
    Then I sleep for 3 seconds
    And I should see the text 'Permit Updated'
    Then I getting a permanent number from indexedDB
    And I navigate to "Created" screen for PRE
    And I should see the current PRE in the "Created" list
    Then I edit pre and should see the old number previously written down

  Scenario: The Responsible Officer Signature should be displayed PRE
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I fill up PRE. Duration 4. Delay to activate 3
    And Get PRE id
    And for pre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    Then I activate the current PRE form
    And I sleep for 1 seconds
    When I navigate to "Scheduled" screen for PRE
    And I should see the current PRE in the "Scheduled" list
    When I view permit with C/O rank
    And I check "Responsible Officer Signature" is present

  Scenario: Permit Validity date should match the final date selected from the date picker
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin via service for rank C/O
    Then I fill up PRE Duration 4 Delay to activate 3 with custom days 1 in Future from current
    #And I change PRE Duration 4 Delay to activate 3 with custom days 1 in Past from selected
    And Get PRE id
    And for pre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I navigate to "Pending Approval" screen for PRE
    Then I check scheduled date