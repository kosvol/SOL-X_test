@Pump-Room-Entry
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

  Scenario: SOL-5707 Display message on Entry Log tab if no entry records exist
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    When I fill and submit PRE permit details
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
    And I enter pin <pin>
    Then I should see PRE landing screen

    Examples:
      | rank                      | pin  |
      | Chief Officer             | 8383 |
      | Additional Chief Officer  | 2761 |
      | Second Officer            | 6268 |
      | Additional Second Officer | 7865 |
      | 3/O                       | 0159 |
      | A 3/O                     | 2674 |

  Scenario Outline: Verify not Pump Room Entry RO cannot create PRE
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin <pin>
    Then I should see not authorize error message

    Examples:
      | rank                       | pin  |
      | Master                     | 1111 |
      | Addtional Master           | 9015 |
      | Chief Engineer             | 8248 |
      | Second Engineer            | 2523 |
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

  Scenario: Verify in the form there are all questions
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I should see the right order of elements

  Scenario Outline: Verify submit for approval button is disable when mandatory fields not fill
    Given  I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
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
    And I enter pin 8383
    Then I select current day for field "Date of Last Calibration"

  Scenario: Verify user able to see reporting interval when YES is selected
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    And I should not see Reporting interval
    Then I click Yes to answer the question "Are the personnel entering the pump room aware of the reporting interval?"
    And I should see Reporting interval

  Scenario: Verify user can add Gas Test Record with toxic gas
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new PRE
    And I enter pin 8383
    And I add all gas readings
    And I enter pin 9015
    And I set time
    Then I will see popup dialog with By A/M Atif Hayat crew rank and name
    When I dismiss gas reader dialog box
    Then I should see gas reading display with toxic gas

  Scenario: Verify PRE can be terminated manually
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for Officer Approval
    And I getting a permanent number from indexedDB
    Then I activate the current PRE form
    And I sleep for 1 seconds
    When I navigate to "Scheduled" screen for PRE
    And I should see the current PRE in the "Scheduled" list
    And I click on back arrow
    And I sleep for 100 seconds
    And I navigate to "Active" screen for PRE
    And I should see the current PRE in the "Active PRE" list
    And I click on back arrow
    Then I terminate the PRE
    When I navigate to "Terminated" screen for PRE
    And I should see the current PRE in the "Closed PRE" list

  Scenario: Verify Update needed text can be input and displayed after
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for Officer Approval
    And I sleep for 5 seconds
    And I getting a permanent number from indexedDB
    Then I request update needed
    And for pre I should see update needed message

  Scenario: Verify creator PRE cannot request update needed
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for Officer Approval
    And I sleep for 5 seconds
    And I getting a permanent number from indexedDB
    Then I open the current PRE with status Pending approval. Pin: 8383
    And for pre I should see the disabled "Updates Needed" button

  Scenario: Verify NOT Pump Room Entry RO CANNOT request Update needed and Approve for Activation. Only Close button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for Officer Approval
    And I sleep for 2 seconds
    And I getting a permanent number from indexedDB
    Then (table) Buttons should be missing for the following role:
      | Master                     | 1111 |
      | Addtional Master           | 9015 |
      | Chief Engineer             | 8248 |
      | Second Engineer            | 2523 |
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

  Scenario: Verify Created PRE is displayed in Created PRE list
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    And Get PRE id
    Then I press the "Close" button
    And I getting a permanent number from indexedDB
    And I navigate to "Created" screen for PRE
    Then I should see the current PRE in the "Created PRE" list

  Scenario Outline: Verify a creator PRE cannot activate PRE. Exception: Chief Officer
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new PRE
    And I enter pin <pin>
    Then I fill up PRE. Duration 4. Delay to activate 2
    And Get PRE id
    And for pre I submit permit for Officer Approval
    And I sleep for 5 seconds
    And I getting a permanent number from indexedDB
    Then I open the current PRE with status Pending approval. Pin: <pin>
    And for pre I should see the <condition> "Approve for Activation" button

    Examples:
      | rank                      | pin  | condition |
      | Chief Officer             | 8383 | enabled   |
      | Additional Chief Officer  | 2761 | disabled  |
      | Second Officer            | 6268 | disabled  |
      | Additional Second Officer | 7865 | disabled  |
      | 3/O                       | 0159 | disabled  |
      | A 3/O                     | 2674 | disabled  |

  Scenario: A temporary number should correctly become permanent. The form must be available by the permanent number.
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    And I get a temporary number and writing it down
    Then I sleep for 3 seconds
    And I should see the text 'Permit Updated'
    Then I getting a permanent number from indexedDB
    And I navigate to "Created" screen for PRE
    And I should see the current PRE in the "Created" list
    Then I edit pre and should see the old number previously written down

  Scenario: Verify PRE will be activated and auto terminated at the specified time
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 2
    And for pre I submit permit for Officer Approval
    And I getting a permanent number from indexedDB
    Then I activate the current PRE form
    When I navigate to "Scheduled" screen for PRE
    And I should see the current PRE in the "Scheduled" list
    And I click on back arrow
    And I sleep for 120 seconds
    And I navigate to "Active" screen for PRE
    Then I should see the current PRE in the "Active PRE" list
    And I set the activity end time in 1 minutes
    And I click on back arrow
    And I sleep for 90 seconds
    When I navigate to "Terminated" screen for PRE
    Then I should see current PRE is auto terminated








