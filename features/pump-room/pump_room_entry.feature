@Pump-Room-Entry
Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...

  Scenario: Verify menu items are displayed in hamburger menu
    Given I launch sol-x portal without unlinking wearable
    Then  I navigate to "Created P/R Entries" screen
    And I should see the label 'Created P/R Entries'
    And I click on back arrow

    Then  I navigate to "Updates Needed P/R Entries" screen
    And I should see the label 'Updates Needed P/R Entries'
    And I click on back arrow

    Then  I navigate to "Closed P/R Entries" screen
    And I should see the label 'Closed P/R Entries'
    And I click on back arrow

    Then  I navigate to "Deleted P/R Entries" screen
    And I should see the label 'Deleted P/R Entries'
    And I click on back arrow

  @x1234
  Scenario: Verify Created PRE is displayed in Created PRE list
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    And Get PRE id
    Then I press the "Close" button
    And I should see the current PRE in the "Created PRE" list


  Scenario Outline: Verify only Pump Room Entry RO can create PRE
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin <pin>
    Then I should see PRE landing screen
    And I tear down created form

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
    Then I should see all questions for PRE and three answers each
      | Has the exhaust ventilation system been switched on and running for at least 15 mins?                                            |
      | Are all the Pump room lights switched on?                                                                                        |
      | Is the fixed equipment for continuous monitoring of the atmosphere working properly and calibrated?                              |
      | Has communication with the responsible officer been established?                                                                 |
      | Has the exhaust uptake been set to draw air from the lowest point in the pump room?                                              |
      | Is the Emergency evacuation harness ready for use?                                                                               |
      | Have the personal monitors for persons entering the pump room been checked for readiness?                                        |
      | Are the personnel entering the pump room aware of the locations of the ELSA / EEBD and familiar with its use?                    |
      | Are the personnel entering the pump room aware of the reporting interval?                                                        |
      | Are emergency and evacuation procedures established and understood by the Person(s) entering the pump room?                      |
      | Have the names of the person(s) entering the pump room been recorded in the Port operations log together with the time of entry? |
      | Are the person(s) entering the pump room aware that after exiting the space a report to the responsible officer must be made?    |
      | Are the persons entering the pump room familiar with the emergency alarm meant for  CO2 / Foam flooding?                         |
      | Are the persons entering the pump room familiar with the location of the emergency trips for the cargo pumps?                    |
      | Is the pumproom bilge dry?                                                                                                       |


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
      | 4 hours  |
      | 6 hours  |
      | 8 hours  |


  Scenario: Verify user able to fill Date of Last Calibration
    Given  I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I select current day for field "Date of Last Calibration"


  Scenario: Verify user able to see reporting interval when YES is selected
    Given  I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    And I should not see Reporting interval
    Then I click Yes to answer the question "Are the personnel entering the pump room aware of the reporting interval?"
    And  I should see Reporting interval


  Scenario: Verify user can add Gas Test Record
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I press the "Add Gas Test Record" button
    And I should see the page "Gas Test Record"
    And (for pre) I should see the disabled "Continue" button
    And I fill up "Gas Test Record"
    Then (for pre) I should see the enabled "Continue" button
    And I press the "Continue" button
    Then I should see the page "Other Toxic Gases"
    And (for pre) I should see the disabled "Add Toxic Gas" button
    Then I fill up "Other Toxic Gases"
    And (for pre) I should see the enabled "Add Toxic Gas" button
    Then I press the "Add Toxic Gas" button
    And I should see a new row with filled data
    And I should be able to delete the record
    Then I fill up "Other Toxic Gases"
    And I press the "Add Toxic Gas" button
    And I press the "Review & Sign" button
    Then I should see the page "Review Your Gas Test Record"

    # And I should be able to return on previous pages
    # Then I press the "Back" button
    # And I should see the section "Other Toxic Gases"
    # Then I press the "Back" button
    # And I should see the section "Gas test Record"
    # Then I should be able to return on Review Your Gas Test Record => BUG SOL-5246

    And (for pre) I should see the disabled "Enter PIN & Submit" button
    Then (for pre) I sign on canvas
    And (for pre) I should see the enabled "Enter PIN & Submit" button
    And I press the "Enter PIN & Submit" button
    And I sign on Gas Test Record with 8383 pin


  #TThen I should see the page "Gas Test Record Successfully Submitted"
  #Then I should "Gas Reading" table
  #And I should see the table on the page with entered gas data
  #Then I should not see the "Add Gas Test Record" button


  Scenario: Verify PRE will be activated and auto terminated at the specified time
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 1
    And (for pre) I submit permit for Officer Approval
    Then I activate the current PRE form
    And I should see the current PRE in the "Scheduled" list
    When I wait to activate PRE. Delay 120
    Then I should see the current PRE in the "Active PRE" list
    And I set the activity end time in 1 minutes
    When I navigate to "Closed P/R Entries" screen
    Then I should see current PRE is auto terminated


  Scenario: Verify PRE can be terminated manually
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 1
    And (for pre) I submit permit for Officer Approval
    Then I activate the current PRE form
    And I should see the current PRE in the "Scheduled" list
    When I wait to activate PRE. Delay 120
    And I should see the current PRE in the "Active PRE" list
    Then I terminate the PRE
    And I should see the current PRE in the "Closed PRE" list


  Scenario: Verify Update needed text can be input and displayed after
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 1
    And (for pre) I submit permit for Officer Approval
    Then I request update needed
    And (for pre) I should see update needed message

  Scenario: Verify creator PRE cannot request update needed
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 1
    And (for pre) I submit permit for Officer Approval
    Then I open the current PRE with status Pending approval. Pin: 8383
    And (for pre) I should see the disabled "Updates Needed" button

  Scenario: Verify NOT Pump Room Entry RO CANNOT request Update needed and Approve for Activation. Only Close button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I fill up PRE. Duration 4. Delay to activate 1
    And (for pre) I submit permit for Officer Approval
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


  Scenario Outline: Verify a creator PRE cannot activate PRE. Exception: Chief Officer
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin <pin>
    Then I fill up PRE. Duration 4. Delay to activate 1
    And (for pre) I submit permit for Officer Approval
    Then I open the current PRE with status Pending approval. Pin: <pin>
    And (for pre) I should see the <condition> "Approve for Activation" button

    Examples:
      | rank                      | pin  | condition |
      | Chief Officer             | 8383 | enabled   |
      | Additional Chief Officer  | 2761 | disabled  |
      | Second Officer            | 6268 | disabled  |
      | Additional Second Officer | 7865 | disabled  |
      | 3/O                       | 0159 | disabled  |
      | A 3/O                     | 2674 | disabled  |


  Scenario Outline: Verify role which CANNOT navigate to Pump Room Entry Display
    Given I launch sol-x portal without unlinking wearable
    And Navigate to PRE Display
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
    And Navigate to PRE Display
    And I enter pin <pin>
    Then I should see the label 'Pump Room Entry Display'

    Examples:
      | role            | pin  |
      | Master          | 1111 |
      | Chief Officer   | 8383 |
      | Chief Engineer  | 8248 |
      | Second Engineer | 2523 |








