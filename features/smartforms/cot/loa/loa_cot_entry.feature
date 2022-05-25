@loa_cot_entry
Feature: Entry COT LOA

  @clear_form
  Scenario: clear form data
    Given DB service clear couch table
      | db_type | table                  |
      | edge    | forms                  |
      | cloud   | forms                  |
      | cloud   | office_approval_events |
      | edge    | gas_reader_entry       |
      | cloud   | gas_reader_entry       |
    And DB service clear postgres data


  Scenario Outline: Verify cre/pre initial gas tester can add gas test record
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
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
      | ETO   |
      | CGENG |

  Scenario Outline: Verify non cre/pre initial gas tester can not add gas test record
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | 4/O   |
      | 5/O   |
      | 5/E   |
      | T/E   |
      | E/C   |
      | ETR   |
      | O/S   |
      | SAA   |
      | D/C   |
      | BOS   |
      | PMN   |
      | A/B   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | RDCRW |
      | SPM   |

  Scenario Outline: Verify cre/pre periodic gas tester can submit entry log in PRE display
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click enter new entry log button
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings fill equipment fields
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | BOS   |
      | A/B   |
      | O/S   |
      | RDCRW |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
      | ETO   |
      | ELC   |
#      | E/CDT |
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | FSTO  |


  Scenario Outline: Verify cre/pre creator can create PRE
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "<rank>"
    Then PumpRoomEntry verify page title
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify only cre/pre creator can create PRE
    Given SmartForms open page
    When SmartForms click create entry permit
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

  Scenario Outline: Verify cre/pre editor can edit PRE
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    And CreatedEntry click first permit
    When PinEntry enter pin for rank "<rank>"
    Then CommonSection click Save & Close button
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify non cre/pre editor can not edit PRE
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    And CreatedEntry click first permit
    When PinEntry enter pin for rank "<rank>"
    Then CommonSection click Close button
    Examples:
      | rank  |
      | MAS   |
      | C/E   |
      | 2/E   |
      | ETO   |
      | A 2/E |
      | 4/O   |
      | ETO   |

  Scenario Outline: Verify cre/pre updater can update PRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "<rank>"
    Then CommonSection click Save & Close button
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |


  Scenario Outline: Verify non cre/pre updater can not update PRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "<rank>"
    Then CommonSection click Close button
    Examples:
      | rank  |
      | MAS   |
      | C/E   |
      | 2/E   |
      | ETO   |
      | A 2/E |
      | 4/O   |
      | ETO   |

  Scenario Outline: Verify cre/pre approval authority can approve or request update for PRE
    Given SmartForms open page
    And EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    And CommonSection sleep for "1" sec
    Then CommonSection verify header is "Successfully Submitted"
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |


  Scenario Outline: Verify non cre/pre approval authority can not approve or request update for PRE
    Given SmartForms open page
    And EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | C/E   |
      | 2/E   |
      | ETO   |
      | A 2/E |
      | 4/O   |
      | ETO   |

  Scenario Outline: Verify cre/pre responsible authority can submit for PRE approval
    Given SmartForms open page
    And EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    And CommonSection sleep for "1" sec
    Then CommonSection verify header is "Successfully Submitted"
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |


  Scenario Outline: Verify non cre/pre responsible authority can not submit for PRE approval
    Given SmartForms open page
    And EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | C/E   |
      | 2/E   |
      | ETO   |
      | A 2/E |
      | 4/O   |
      | ETO   |

  Scenario Outline: Verify cre/pre eraser can delete PRE
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And CommonSection sleep for "1" sec
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    And CreatedEntry save first permit id
    And CreatedEntry click delete
    When PinEntry enter pin for rank "<rank>"
    And CommonSection sleep for "1" sec
    Then CreatedEntry verify deleted permit not presents in list
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify non cre/pre eraser can not delete PRE
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And CommonSection sleep for "1" sec
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    And CreatedEntry save first permit id
    And CreatedEntry click delete
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | ETO   |
      | CGENG |


  Scenario Outline: Verify cre/pre terminator authority can terminate for PRE
    Given PermitStatusService terminate active "PRE" entry permit
    And SmartForms open page
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | pre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And PumpRoomEntry click Terminate
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    And CommonSection sleep for "1" sec
    Then CommonSection verify header is "Successfully Submitted"
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |


  Scenario Outline: Verify non cre/pre terminator authority can not terminate for PRE
    Given PermitStatusService terminate active "PRE" entry permit
    And SmartForms open page
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | pre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And PumpRoomEntry click Terminate
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | C/E   |
      | 2/E   |
      | ETO   |
      | A 2/E |
      | 4/O   |
      | ETO   |
