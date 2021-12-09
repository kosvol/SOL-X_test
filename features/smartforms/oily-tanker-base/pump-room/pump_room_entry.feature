@Pump-Room-Entry
Feature: Pump room entry permit creation
  As a ...
  I want to ...
  So that ...

  Scenario: SOL-5707 Display message on Entry Log tab if no entry records exist
    Given SmartForms open page
    When  PermitGenerator create entry permit
      | entry_type | permit_status   |
      | pre        | ACTIVE          |
    Then NavigationDrawer navigate to "PRE" display until see active permit

  Scenario: Verify menu items are displayed in hamburger menu
    Given SmartForms open page
    When NavigationDrawer open hamburger menu
    And NavigationDrawer click show more on "PRE"
    And NavigationDrawer click show more on "Forms"
    And NavigationDrawer verify hamburger categories

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
    And PermitActions verify button "Submit for Approval" is disabled
    Then PRE select Permit Duration <duration>
    Then PRE verify alert message "Please select the start time and duration before submitting." does not show up
    And PermitActions verify button "Submit for Approval"

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
    When GasReadings click done button on gas reader dialog box
    And PRE scroll "down" direction 2 times
    Then GasReadings verify gas table titles

  Scenario: Verify PRE can be terminated manually
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
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
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    And NavigationDrawer navigate to Pump Room "Scheduled"
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click back arrow button
    And CommonSection sleep for "180" sec
    And NavigationDrawer navigate to Pump Room "Active"
    Then CreateEntryPermit verify current permit presents in the list
    And PermitActions click Submit for termination
    Then PinEntry enter pin for rank "C/O"
    And PermitActions click Terminate button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element with text "Permit Has Been Closed"
    And CommonSection sleep for "1" sec
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Terminated"
    Then CreateEntryPermit verify current permit presents in the list

  Scenario: Verify Update needed text can be input and displayed after
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
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
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    And PermitActions request for update
    And CreateEntryPermit verify element with text "Your Updates Have Been Successfully Requested"
    And CommonSection sleep for "1" sec
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Updates Needed"
    Then PermitActions click Edit Update button
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit verify element with text "Comments from Approving Authority"
    And CreateEntryPermit verify element with text "Test Automation"

  Scenario: Verify creator PRE cannot request update needed
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status                    |
      | pre        | APPROVED_FOR_ACTIVATION          |
    And NavigationDrawer navigate to Pump Room "Scheduled"
    And PermitActions verify button "Updates Needed" is disabled

  Scenario Outline: Verify NOT Pump Room Entry RO CANNOT request Update needed and Approve for Activation. Only Close button
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
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
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    When PendingApproval click Officer Approval button
    Then PinEntry enter pin for rank "<rank>"
    And PRE scroll "down" direction 2 times
    And PermitActions verify buttons for not Pump Room Entry RO rank on pending approval page

    Examples:
      | rank  |
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
    Then PermitActions click Close button
   # And I getting a permanent number from indexedDB (need to refactor IndexedDb class)
    And NavigationDrawer navigate to Pump Room "Created"
    Then CreateEntryPermit verify current permit presents in the list

  Scenario: Verify a creator PRE can activate PRE
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
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
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And PermitActions verify button "Approve for Activation"

  Scenario Outline: Verify a creator PRE cannot activate PRE
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
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
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    When PendingApproval click Officer Approval button
    Then PinEntry enter pin for rank "<rank>"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And PermitActions verify button "Approve for Activation" is disabled

    Examples:
      | rank  |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: A temporary number should correctly become permanent. The form must be available by the permanent number.
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit save permit id
    #And I get a temporary number and writing it down
    And CreateEntryPermit verify element with text "Permit Updated"
    #Then I getting a permanent number from indexedDB
    And NavigationDrawer navigate to Pump Room "Created"
    Then CreateEntryPermit verify current permit presents in the list
    Then PermitActions click Edit button
    And PinEntry enter pin for rank "C/O"
    Then PermitActions verify purpose of entry

  Scenario: The Responsible Officer Signature should be displayed PRE
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
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
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    And CreateEntryPermit save current start and end validity time for "PRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    And NavigationDrawer navigate to Pump Room "Scheduled"
    And CreateEntryPermit verify current permit presents in the list
    And PermitActions open current permit for view
    Then PinEntry enter pin for rank "C/O"
    And PermitActions check Responsible Officer Signature

  Scenario: Permit Validity date should match the final date selected from the date picker
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And PRE scroll "up" direction 1 times
    And PRE fill up permit in future
      | duration | delay to activate | days|
      | 4        | 3                 |1    |
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    Then PRE verify scheduled date

  Scenario Outline: Pure Gas Tester2 should not be able to edit gas reading
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
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    And PermitActions request for update
    And CreateEntryPermit verify element with text "Your Updates Have Been Successfully Requested"
    And CommonSection sleep for "1" sec
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Pump Room "Updates Needed"
    Then PermitActions click Edit Update button
    Then PinEntry enter pin for rank "<rank>"
    And PermitActions verify button "Submit for Approval" is disabled
    And PermitActions verify button "Add Gas Test Record" is disabled

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

