@lng-cre
Feature: Compressor room entry creation
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify new scheduled CRE permit will replace existing active CRE permit
  Scenario: Verify new active CRE permit will replace existing active CRE permit
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
    And CreateEntryPermit save permit id from list
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click go back button
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And CommonSection sleep for "5" sec
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
    Then CRE verify permit not present in list
    And NavigationDrawer click go back button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Terminated"
    Then CreateEntryPermit verify current permit presents in the list

  Scenario: Verify user can see all the CRE questions
    Given SmartForms open page
    When SmartForms click create "CRE"
    And PinEntry enter pin for rank "C/O"
    Then CRE verify form titles and questions
    Then CRE verify form titles of sections
    Then CRE verify form answers for questions

  Scenario Outline: Verify only these crew can create CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "<rank>"
    Then CRE verify landing screen is "Compressor/Motor Room Entry"
  #need to add pins to Additional roles
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

  Scenario: Verify gas table titles are saved correct on created CRE form
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
    Then CRE verify gas added by "By C/O STG C/O"
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
    When GasReadings click done button on gas reader dialog box
# need to add PMAN rank to auto env
    Examples:
      | rank |
      | PMAN |
      | ETO  |
      | ELC  |

  Scenario Outline: Verify CRE roles cannot approve the same permit
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
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "<rank>"
    And CommonSection verify button availability
      | button                 | availability |
      | Approve for Activation | disabled     |
    Examples:
      | rank  |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify non CRE creator can approve the same permit
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
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "<rank>"
    And CommonSection verify button availability
      | button                 | availability |
      | Approve for Activation | enabled      |
    Examples:
      | rank  |
      | 2/O   |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify these roles can terminate CRE permit
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
    And CreateEntryPermit save permit id from list
    And ActiveEntry click Submit for termination
    Then PinEntry enter pin for rank "<rank>"
    And ActiveEntry click Terminate button
    Then PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify element with text "Permit Has Been Closed"
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Terminated"
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
    And NavigationDrawer click go back button
    And CommonSection sleep for "2" sec
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Created"
    And CreateEntryPermit save permit id from list
    And CreatedEntry click button Delete
    Then PinEntry enter pin for rank "MAS"
    Then CreatedEntry verify deleted permit not presents in list
    And NavigationDrawer click go back button
    And CommonSection sleep for "2" sec
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Deleted"
    Then CreateEntryPermit verify current permit presents in the list

  Scenario: Verify user cannot send CRE for approval without start time and duration
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CommonSection verify button availability
      | button              | availability |
      | Submit for Approval | disabled     |

  Scenario Outline: Verify these roles can request update for CRE permit in Pending Approval State
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
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "<rank>"
    And CommonSection verify button availability
      | button         | availability |
      | Updates Needed | enabled      |

    Examples:
      | rank  |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

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
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And PendingApprovalEntry click approve for activation
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Scheduled"
    And CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click back arrow button
    And CommonSection sleep for "180" sec
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
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
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And CommonSection verify button availability
      | button  | availability |
      | Add Gas | disabled     |
    And CommonSection verify button availability
      | button         | availability |
      | Updates Needed | disabled     |

  Scenario: The Responsible Officer Signature should be displayed CRE
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status           |
      | cre        | APPROVED_FOR_ACTIVATION |
    And CommonSection sleep for "1" sec
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Scheduled"
    And CreateEntryPermit verify current permit presents in the list
    And ScheduledEntry open current permit for view
    Then PinEntry enter pin for rank "C/O"
    And CommonSection check Responsible Officer Signature

  Scenario: The Responsible Officer Signature should be displayed in terminated list CRE
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
    And CreateEntryPermit save permit id from list
    And ActiveEntry click Submit for termination
    Then PinEntry enter pin for rank "C/O"
    And ActiveEntry click Terminate button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Terminated"
    And CreateEntryPermit verify current permit presents in the list
    And TerminatedEntry open current permit for view
    Then PinEntry enter pin for rank "C/O"
    And CommonSection check Responsible Officer Signature
      | rank        | zone                  |
      | C/O STG C/O | No. 1 Cargo Tank Port |

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
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And PendingApprovalEntry click approve for activation
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    Then CreateEntryPermit click Back to Home button
    And CommonSection sleep for "180" sec
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
    And ActiveEntry open current permit for view
    Then PinEntry enter pin for rank "C/O"
    Then GasReadings verify location in sign
      | location              |
      | No. 1 Cargo Tank Port |

  Scenario Outline: Verify Chief Officer can activate his/her own CRE permit
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
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "<rank>"
    And PendingApprovalEntry click approve for activation
    Then PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"

    Examples:
      | rank  |
      | C/O   |
      | A C/O |