@Pump-Room-Entry
Feature: Pump room entry permit creation
  As a ...
  I want to ...
  So that ...

  Scenario: SOL-5707 Display message on Entry Log tab if no entry records exist
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And SmartForms navigate to "Pending Approval" page for "PRE"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    And Service Activate "PRE" permit
    Then SmartForms navigate to "PRE" display until see active permit
   # Given I fill and submit PRE permit details via service
   # Then I should see no new entry log message

  Scenario: Verify menu items are displayed in hamburger menu
    Given SmartForms open page
    When SmartForms open hamburger menu
    And SmartForms click show more on "PRE"
    And SmartForms click show more on "Forms"
    And SmartForms verify hamburger categories

  Scenario Outline: Verify only Pump Room Entry RO can create PRE
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "<rank>"
    Then PRE verify landing screen is "Section 1: Pump Room Entry Permit"

    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify not Pump Room Entry RO cannot create PRE
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"

    Examples:
      | rank  |
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

  Scenario: Verify in the form there are all questions
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    Then PRE verify questions order

  Scenario Outline: Verify submit for approval button is disable when mandatory fields not fill
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    Then PRE verify alert message "Please select the start time and duration before submitting."
    And Button "Submit for Approval" should be disabled
    Then PRE select Permit Duration <duration>
    Then PRE verify alert message "Please select the start time and duration before submitting." does not show up

    And Button "Submit for Approval" should not be disabled

    Examples:
      | duration |
      | 4        |
      | 6        |
      | 8        |

  Scenario: Verify user able to fill Date of Last Calibration
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    Then PRE select Date of Last Calibration as current day

  Scenario: Verify user able to see reporting interval when YES is selected
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit "should not" see Reporting interval
    Then PRE answer question
      | answer | question                                                                  |
      | Yes    | Are the personnel entering the pump room aware of the reporting interval? |
    And CreateEntryPermit "should" see Reporting interval

  Scenario: Verify user can add Gas Test Record with toxic gas
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save form time
    And CreateEntryPermit verify popup dialog with "C/O COT C/O" crew member

    When I dismiss gas reader dialog box
    Then I should see gas reading display with toxic gas and C/O COT C/O as gas signer

  Scenario: Verify PRE can be terminated manually
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And SmartForms navigate to "Pending Approval" page for "PRE"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    And SmartForms navigate to "Scheduled" page for "PRE"
    Then CreateEntryPermit verify current permit presents in the list

    And I click on back arrow
    And I sleep for 180 seconds
    And I navigate to "Active" screen for PRE
    And I should see the current PRE in the "Active PRE" list
    And I click on back arrow
    Then I terminate the PRE
    When I navigate to "Terminated" screen for PRE
    And I should see the current PRE in the "Closed PRE" list

  Scenario: Verify Update needed text can be input and displayed after
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button

    Then I request update needed
    And for pre I should see update needed message

  Scenario: Verify creator PRE cannot request update needed
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And SmartForms navigate to "Pending Approval" page for "PRE"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"

    And for pre I should see the disabled "Updates Needed" button

  Scenario: Verify NOT Pump Room Entry RO CANNOT request Update needed and Approve for Activation. Only Close button
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button

    Then (table) Buttons should be missing for the following role:
      | MAS   |
      | A/M   |
      | ETO   |
      | D/C   |
      | 4/E   |
      | A 4/E |
      | BOS   |
      | A/B   |
      | O/S   |
      | OLR   |

  Scenario: Verify Created PRE is displayed in Created PRE list
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit save permit id
    Then PRE click Close button
   # And I getting a permanent number from indexedDB (need to refactor IndexedDb class)
    And SmartForms navigate to "Created" page for "PRE"
    Then CreateEntryPermit verify current permit presents in the list

  Scenario Outline: Verify a creator PRE cannot activate PRE. Exception: Chief Officer
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button

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
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit save permit id
    #And I get a temporary number and writing it down
    And CreateEntryPermit verify element type "text" with text "Permit Updated"
    #Then I getting a permanent number from indexedDB
    And SmartForms navigate to "Created" page for "PRE"
    #And I should see the current PRE in the "Created" list
    Then CreateEntryPermit verify current permit presents in the list

    Then I edit pre and should see the old number previously written down

  Scenario: The Responsible Officer Signature should be displayed PRE
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And SmartForms navigate to "Pending Approval" page for "PRE"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    And SmartForms navigate to "Scheduled" page for "PRE"

    And I should see the current PRE in the "Scheduled" list
    When I view permit with C/O rank
    And I check "Responsible Officer Signature" is present

  Scenario: Permit Validity date should match the final date selected from the date picker
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"

    Then I fill up PRE Duration 4 Delay to activate 3 with custom days 1 in Future from current

    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And SmartForms navigate to "Pending Approval" page for "PRE"

    Then I check scheduled date

  Scenario Outline: Pure Gas Tester2 should not be able to edit gas reading
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button

    Then I request update needed
    And I should see that form is open for read by rank <rank>

    Examples:
      | rank  |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | BOS   |
      | A/B   |
      | O/S   |
      | 5/E   |
      | E/C   |
      | ELC   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |

