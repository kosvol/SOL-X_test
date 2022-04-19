@loa_cot_entry
Feature: Entry COT LOA

  Scenario Outline: Verify cre/pre periodic gas tester can submit entry log in PRE display
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click enter new entry log button
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings fill equipment fields
    Examples:
      | rank  |
      | MAS   |
#      | A/M   |
      | C/O   |
#      | A C/O |
      | 2/O   |
#      | A 2/O |
      | 3/O   |
#      | A 3/O |
      | 4/O   |
#      | A 4/O |
      | 5/O   |
      | D/C   |
      | BOS   |
      | A/B   |
      | O/S   |
#      | RDCRW |
      | C/E   |
#      | A C/E |
      | 2/E   |
#      | A 2/E |
      | 3/E   |
#      | A 3/E |
      | 4/E   |
#      | A 4/E |
      | 5/E   |
      | E/C   |
#      | ETO   |
      | ELC   |
#      | E/CDT |
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
#      | WPR   |
#      | FSTO  |

  Scenario Outline: Verify non cre/pre periodic gas tester cannot submit entry log in PRE display
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | SAA  |
#      | ETR  |
#      | WPR   |
#      | CCK   |
#      | 2CK   |
#      | STWD  |
#      | FSTO  |
#      | RDCRW |
#      | SPM   |

  Scenario Outline: Verify ranks CAN navigate to Pump Room Entry Display
    Given SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "<role>"
    Then EntryDisplay click "home" tab
    Examples:
      | role  |
      | MAS   |
      | C/O   |
#      | A C/O |
      | 2/O   |
#      | A 2/O |
      | 3/O   |
#      | A 3/O |
      | C/E   |
#      | A C/E |
      | 2/E   |
#      | A 2/E |
      | 3/E   |
#      | A 3/E |
      | 4/E   |
      | A 4/E |

  Scenario Outline: Verify ranks CANNOT navigate to Pump Room Entry Display
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | ETR  |
      | D/C  |
      | BOS  |
      | A/B  |
      | O/S  |
      | OLR  |

  Scenario Outline: Verify cre/pre creator can create PRE
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "<rank>"
    Then PumpRoomEntry verify page title
    Examples:
      | rank |
      | C/O  |
#      | A C/O |
      | 2/O  |
#      | A 2/O |
      | 3/O  |
#      | A 3/O |

  Scenario Outline: Verify only cre/pre creator can create PRE
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | MAS  |
#      | A/M   |
      | C/E  |
      | 2/E  |
#      | ETO   |
#      | A 2/E |
      | D/C  |
      | 3/E  |
#      | A 3/E |
      | 4/E  |
#      | A 4/E |
      | BOS  |
      | A/B  |
#      | O/S   |
      | OLR  |

  Scenario Outline: Verify only cre/pre approval authority can approve or request update for PRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "<rank>"
    Then CommonEntry verify non approval authority view
    Examples:
      | rank |
      | MAS  |
#      | A/M   |
#      | ETO   |
      | D/C  |
      | 4/E  |
#      | A 4/E |
      | BOS  |
      | A/B  |
#      | O/S   |
      | OLR  |

  Scenario Outline: Verify a creator PRE cannot activate PRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status            | creator_rank |
      | pre        | PENDING_OFFICER_APPROVAL | <rank>       |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "<rank>"
    Then CommonEntry verify non approval authority view
    Examples:
      | rank |
      | 2/O  |
#      | A 2/O |
      | 3/O  |
#      | A 3/O |

  Scenario Outline: Verify only cre/pre editor can edit gas reading
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    When PinEntry enter pin for rank "<rank>"
    Then CommonEntry verify no add gas reading button
    Examples:
      | rank |
      | 4/O  |
##      | A 4/O |
      | 5/O  |
      | D/C  |
      | BOS  |
      | A/B  |
#      | O/S  |
      | 5/E  |
      | E/C  |
      | ELC  |
      | T/E  |
      | PMN  |
      | FTR  |
      | OLR  |