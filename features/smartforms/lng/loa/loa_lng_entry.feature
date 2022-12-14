@loa_lng_entry
Feature: Entry LNG LOA

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

  Scenario Outline: Verify cre/pre creator can create CRE (SOL-6110)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "<rank>"
    Then CompressorRoomEntry verify page title
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify only cre/pre creator can create CRE (SOL-6110)
    Given SmartForms open page
    And SmartForms click create entry permit
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre initial gas tester can add gas test record for CRE (SOL-8330)
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Trunk Deck | No. 1 Cargo Tank  |
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

  Scenario: Verify non cre/pre initial gas tester can not add gas test record for CRE(SOL-8330)
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    Then PinEntry verify the error message is correct for the wrong rank
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre initial gas tester can add gas test record for CRE with updates-needed status
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | cre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | cre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Trunk Deck | No. 1 Cargo Tank  |
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

  Scenario Outline: Verify cre/pre periodic gas tester can submit entry log in CRE display (SOL-8304)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click enter new entry log button
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Trunk Deck | No. 1 Cargo Tank  |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | FSTO  |

  Scenario: Verify non cre/pre periodic gas tester cannot submit entry log in CRE display (SOL-8304)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click enter new entry log button
    Then PinEntry verify the error message is correct for the wrong rank
      | SAA   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | SPM   |

  Scenario Outline: Verify cre/pre editor can edit CRE (SOL-8460)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | cre  | created |
    And CreatedEntry click first permit
    When PinEntry enter pin for rank "<rank>"
    And CompressorRoomEntry fill text area
    And CompressorRoomEntry Select Location of vessel "At Sea"
    And CompressorRoomEntry answer all questions "No"
    And CommonEntry verify add gas reading button
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

  Scenario Outline: Verify non cre/pre editor can not edit CRE (SOL-8460)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | cre  | created |
    And CreatedEntry click first permit
    When PinEntry enter pin for rank "<rank>"
    And CompressorRoomEntry verify the fields are not editable
    And CommonEntry verify no add gas reading button
    Then CommonSection click Close button
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETO   |
      | CGENG |

  Scenario Outline: Verify cre/pre updater can update CRE (SOL-5661)
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | cre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | cre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "<rank>"
    And CompressorRoomEntry fill text area
    And CompressorRoomEntry answer all questions "No"
    And CommonEntry verify add gas reading button
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

  Scenario Outline: Verify non cre/pre updater can not update CRE (SOL-5661)
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | cre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | cre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "<rank>"
    And CompressorRoomEntry verify the fields are not editable
    Then CommonEntry verify no add gas reading button
    Then CommonSection click Close button
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETO   |
      | CGENG |

  Scenario Outline: Verify cre/pre responsible authority can submit CRE (SOL-6120)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And CompressorRoomEntry fill text area
    And CompressorRoomEntry Select Location of vessel "At Sea"
    And CompressorRoomEntry answer all questions "No"
    And CommonEntry click Add Gas Reader
    And PinEntry enter pin for rank "A C/O"
    Then GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Trunk Deck | No. 1 Cargo Tank  |
    And GasReadings click done button on gas reader dialog box
    And CompressorRoomEntry select Permit Duration 8
    And CommonEntry click submit for approval
    And PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify non cre/pre responsible authority can not submit CRE (SOL-6120)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And CompressorRoomEntry fill text area
    And CompressorRoomEntry Select Location of vessel "At Sea"
    And CompressorRoomEntry answer all questions "No"
    And CommonEntry click Add Gas Reader
    And PinEntry enter pin for rank "A C/O"
    And GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Trunk Deck | No. 1 Cargo Tank  |
    When GasReadings click done button on gas reader dialog box
    And CompressorRoomEntry select Permit Duration 8
    And CommonEntry click submit for approval
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre responsible authority can submit CRE from updates_needed
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | cre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | cre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click submit for approval
    And PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify non cre/pre responsible authority can not submit CRE from updates_needed
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | cre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | cre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click submit for approval
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre approval authority can approve and submit CRE to scheduled (SOL-6121)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    And PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify non cre/pre approval authority can not submit CRE to scheduled (SOL-6121)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre approval authority can request update for CRE (SOL-6141)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "<rank>"
    And CommonEntry click request for update
    And CommonEntry verify the request updates option
    Examples:
      | rank  |
      | A/M   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify cre/pre eraser can delete CRE (SOL-6142)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | cre  | created |
    And CreatedEntry save first permit id
    And CreatedEntry click delete
    When PinEntry enter pin for rank "<rank>"
    Then CreatedEntry verify deleted permit not presents in list
    Examples:
      | rank  |
      | MAS   |

  Scenario: Verify non cre/pre eraser can not delete CRE (SOL-6142)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | cre  | created |
    And CreatedEntry save first permit id
    And CreatedEntry click delete
    Then PinEntry verify the error message is correct for the wrong rank
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | C/E   |
      | A C/E |
      | BOS   |
      | A/B   |
      | O/S   |
      | RDCRW |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre eraser can delete CRE in pending approval state
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state   |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click delete
    When PinEntry enter pin for rank "<rank>"
    Then PendingApprovalEntry verify deleted permit not presents in list
    Examples:
      | rank  |
      | MAS   |
      | A/M   |

  Scenario: Verify non cre/pre eraser can not delete CRE in pending approval state
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state   |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click delete
    Then PinEntry verify the error message is correct for the wrong rank
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | C/E   |
      | A C/E |
      | BOS   |
      | A/B   |
      | O/S   |
      | RDCRW |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre eraser can delete CRE in approved for activation state
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    When PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    When PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area        | zone             |
      | Trunk Deck | No. 1 Cargo Tank  |
    Then Submitted verify the form is Successfully Submitted
    And SmartForms navigate to state page
      | type | state                 |
      | cre  |approved-for-activation|
    And ScheduledEntry click delete
    When PinEntry enter pin for rank "<rank>"
    Then ScheduledEntry verify deleted permit not presents in list
    Examples:
      | rank  |
      | MAS   |
      | A/M   |

  Scenario: Verify non cre/pre eraser can not delete CRE in approved for activation state
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    When PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    When PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area        | zone             |
      | Trunk Deck | No. 1 Cargo Tank  |
    Then Submitted verify the form is Successfully Submitted
    And SmartForms navigate to state page
      | type | state                 |
      | cre  |approved-for-activation|
    And ScheduledEntry click delete
    Then PinEntry verify the error message is correct for the wrong rank
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | C/E   |
      | A C/E |
      | BOS   |
      | A/B   |
      | O/S   |
      | RDCRW |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify cre/pre terminator can terminate for CRE (SOL-6122)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | cre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And CompressorRoomEntry click Terminate
    And PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify non cre/pre terminator can not terminate for CRE (SOL-6122)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | cre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And CompressorRoomEntry click Terminate
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify only cre/pre approval authority can see the approve or request update button for CRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    When PinEntry enter pin for rank "<rank>"
    Then CommonEntry verify non approval authority view
    Examples:
      | rank |
      | MAS   |
      | 4/O   |
      | 5/O   |
      | D/C   |
      | SAA   |
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
      | ETO   |
      | CGENG |

  Scenario Outline: Verify a creator PRE cannot activate his own CRE (SOL-6127)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            | creator_rank |
      | cre        | PENDING_OFFICER_APPROVAL | <rank>       |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    When PinEntry enter pin for rank "<rank>"
    Then CommonEntry verify non approval authority view
    Examples:
      | rank |
      | A/M   |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
