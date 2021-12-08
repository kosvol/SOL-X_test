@lng-cre
Feature: Compressor room entry creation
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify new scheduled CRE permit will replace existing active CRE permit
  Scenario: Verify new active CRE permit will replace existing active CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
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
    And Service activate "CRE" permit
    #And I getting a permanent number from indexedDB
    And SmartForms navigate to "Active" page for "CRE"
    Then PinEntry enter pin for rank "A C/O"
    Then CreateEntryPermit verify current permit presents in the list
    #When I submit a current CRE permit via service
    When PermitGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And CommonSection sleep for "5" sec
    And SmartForms click back arrow button
    And SmartForms navigate to "Active" page for "CRE"
    Then PinEntry enter pin for rank "A C/O"
    Then CRE verify permit not present in list
    And SmartForms click back arrow button
    And SmartForms navigate to "Terminated" page for "CRE"
    Then PinEntry enter pin for rank "A C/O"
    Then CreateEntryPermit verify current permit presents in the list

  Scenario: Verify user can see all the CRE questions
    Given SmartForms open page
    When SmartForms click create "CRE"
    And PinEntry enter pin for rank "C/O"
    Then CRE Verify form titles and questions
    Then CRE Verify form titles of sections
    Then CRE Verify form answers for questions

  Scenario Outline: Verify only these crew can create CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "<rank>"
    Then CRE verify landing screen is "Compressor/Motor Room Entry"

    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify these crew cannot create CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
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


  Scenario: Verify AGT can add gas reading in CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save form time
    Then CRE verify gas added by "C/O STG C/O"
    When GasReadings click done button on gas reader dialog box
    Then GasReadings verify gas table titles

  Scenario Outline: Verify any rank can add gas reading in CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "<rank>"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    #And I add all gas readings with <rank> rank
    When GasReadings click done button on gas reader dialog box

    Examples:
      | rank |
      | PMAN |
      | ETO  |
      | ELC  |

  Scenario: Verify CRE Chief Officer can approve the same permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
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
    #And I getting a permanent number from indexedDB
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And PermitActions verify button "Approve for Activation"

  Scenario Outline: Verify CRE roles cannot approve the same permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
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
    Then PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    #And I getting a permanent number from indexedDB
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "<rank>"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And PermitActions verify button "Approve for Activation" is disabled
    Examples:
      | rank  |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify non CRE creator can approve the same permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
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
    Then PinEntry enter pin for rank "A C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    #And I getting a permanent number from indexedDB
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "<rank>"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    Then CRE verify landing screen is "Compressor/Motor Room Entry"

  Scenario Outline: Verify these roles can terminate CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "<rank>"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "<rank>"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    #And I getting a permanent number from indexedDB
    And CommonSection sleep for "1" sec
    And SmartForms navigate to "Scheduled" page for "CRE"
    And CreateEntryPermit verify current permit presents in the list
    And SmartForms click back arrow button
    And Service activate "CRE" permit
    And SmartForms navigate to "Active" page for "CRE"
    Then PinEntry enter pin for rank "C/O"
    Then CreateEntryPermit verify current permit presents in the list
    And PermitActions click Submit for termination
    Then PinEntry enter pin for rank "<rank>"
    And PermitActions click Terminate button
    Then PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "text" with text "Permit Has Been Closed"
    And CommonSection sleep for "1" sec
    And CreateEntryPermit click Back to Home button
    And SmartForms navigate to "Terminated" page for "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit verify current permit presents in the list
    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify only MAS can delete CRE permit in Created State
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And SmartForms click back arrow button
    And SmartForms navigate to "Created" page for "CRE"
    And CreateEntryPermit save permit id
    And PermitActions click button Delete
    Then PermitActions verify deleted permit

  Scenario: Verify user cannot send CRE for approval with start time and duration
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And PermitActions verify button "Submit for Approval" is disabled

  Scenario: Verify these roles can request update for CRE permit in Pending Approval State
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
   # And I getting a permanent number from indexedDB
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "A 3/O"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    Then PermitActions verify button "Approve for Activation"
    Then PermitActions verify button "Updates Needed"

  Scenario: Verify CRE permit turn active on schedule time
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
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
   # And I getting a permanent number from indexedDB
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    And CommonSection sleep for "1" sec
    When SmartForms navigate to "Scheduled" page for "CRE"
    And CreateEntryPermit verify current permit presents in the list
    And SmartForms click back arrow button
    And Service activate "CRE" permit
    When SmartForms navigate to "Active" page for "CRE"
    And CreateEntryPermit verify current permit presents in the list

  Scenario: Verify creator CRE cannot request update needed
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
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
    #And I getting a permanent number from indexedDB
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    Then PermitActions verify button "Add Gas"
    Then PermitActions verify button "Updates Needed" is disabled

  Scenario: The Responsible Officer Signature should be displayed CRE
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 10                |
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
    #And I getting a permanent number from indexedDB
    When PendingApproval click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save current start and end validity time for "CRE"
    And PermitActions check Responsible Officer Signature
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    Then CreateEntryPermit click Back to Home button
    And CommonSection sleep for "1" sec
    When SmartForms navigate to "Scheduled" page for "CRE"
    And CreateEntryPermit verify current permit presents in the list
    And PermitActions open current permit for view
    Then PinEntry enter pin for rank "C/O"
    And PermitActions check Responsible Officer Signature

  Scenario: The Responsible Officer Signature should be displayed in terminated list CRE
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    #And I getting a permanent number from indexedDB
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "A C/O"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    Then CreateEntryPermit click Back to Home button
    And CommonSection sleep for "1" sec
    And Service activate "CRE" permit
    And CommonSection sleep for "10" sec
    Then Service submit "CRE" permit for termination
    When SmartForms navigate to "Terminated" page for "CRE"
    And CreateEntryPermit verify current permit presents in the list
    And PermitActions open current permit for view
    Then PinEntry enter pin for rank "C/O"
    And PermitActions check Responsible Officer Signature

  Scenario: Gas Reader location stamp should not be missing
    Given SmartForms open page
    Then Wearable service unlink all wearables
    And Wearable service link crew member
      | rank | zone_id       | mac               |
      | C/O  | Z-AFT-STATION | 00:00:00:00:00:10 |
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
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
    #And I getting a permanent number from indexedDB
    And SmartForms navigate to "Pending Approval" page for "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CreateEntryPermit save current start and end validity time for "CRE"
    When PendingApproval click Officer Approval button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Permit Successfully Scheduled for Activation"
    Then CreateEntryPermit click Back to Home button
    And CommonSection sleep for "1" sec
    And Service activate "CRE" permit
    And CommonSection sleep for "1" sec
    When SmartForms navigate to "Active" page for "CRE"
    And PermitActions open current permit for view
    Then PinEntry enter pin for rank "C/O"
    Then GasReadings verify location in sign