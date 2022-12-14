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

  Scenario Outline: Verify cre/pre creator can create PRE (SOL-6110)
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

  Scenario: Verify only cre/pre creator can create PRE (SOL-6110)
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

  Scenario Outline: Verify cre/pre initial gas tester can add gas test record for PRE (SOL-8330)
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
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

  Scenario: Verify non cre/pre initial gas tester can not add gas test record for PRE(SOL-8330)
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

  Scenario Outline: Verify cre/pre initial gas tester can add gas test record for PRE with updates-needed status
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
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

  Scenario Outline: Verify cre/pre periodic gas tester can submit entry log in PRE display (SOL-8304)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click enter new entry log button
    When PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
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

  Scenario: Verify non cre/pre periodic gas tester cannot submit entry log in PRE display (SOL-8304)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click enter new entry log button
    Then PinEntry verify the error message is correct for the wrong rank
      | SAA  |
      | CCK   |
      | 2CK   |
      | STWD  |
      | SPM   |

  Scenario Outline: Verify cre/pre editor can edit PRE (SOL-8460)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    And CreatedEntry click first permit
    When PinEntry enter pin for rank "<rank>"
    And PumpRoomEntry fill text area
    And PumpRoomEntry answer question
      | Location of vessel                                                                                    | At Sea |
      | Has the exhaust ventilation system been switched on and running for at least 15 mins?                 | No     |
      | Are all the Pump room lights switched on?                                                             | Yes    |
      | Is the fixed equipment for continuous monitoring of the atmosphere working properly and calibrated?   | No     |
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

  Scenario Outline: Verify non cre/pre editor can not edit PRE (SOL-8460)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    And CreatedEntry click first permit
    When PinEntry enter pin for rank "<rank>"
    And PumpRoomEntry verify the fields are not editable
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

  Scenario Outline: Verify cre/pre updater can update PRE (SOL-5661)
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "<rank>"
    And PumpRoomEntry fill text area
    And PumpRoomEntry answer question
      | Location of vessel                                                                                    | At Sea |
      | Has the exhaust ventilation system been switched on and running for at least 15 mins?                 | No     |
      | Are all the Pump room lights switched on?                                                             | Yes    |
      | Is the fixed equipment for continuous monitoring of the atmosphere working properly and calibrated?   | No     |
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

  Scenario Outline: Verify non cre/pre updater can not update PRE (SOL-5661)
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "<rank>"
    And PumpRoomEntry verify the fields are not editable
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

 Scenario Outline: Verify cre/pre responsible authority can submit PRE (SOL-6120)
  Given SmartForms open page
  When SmartForms click create entry permit
  Then PinEntry enter pin for rank "C/O"
  And PumpRoomEntry fill text area
  Then PumpRoomEntry answer question
    | Location of vessel                                                                                                                | At Sea |
    | Has the exhaust ventilation system been switched on and running for at least 15 mins?                                             | No     |
    | Are all the Pump room lights switched on?                                                                                         | Yes    |
    | Is the fixed equipment for continuous monitoring of the atmosphere working properly and calibrated?                               | Yes    |
    | Are the personnel entering the pump room aware of the reporting interval?                                                         | Yes    |
    | Has communication with the responsible officer been established?                                                                  | Yes    |
    | Has the exhaust uptake been set to draw air from the lowest point in the pump room?                                               | Yes    |
    | Is the Emergency evacuation harness ready for use?                                                                                | Yes    |
    | Have the personal monitors for persons entering the pump room been checked for readiness?                                         | Yes    |
    | Are the personnel entering the pump room aware of the locations of the ELSA / EEBD and familiar with its use?                     | Yes    |
    | Are the personnel entering the pump room aware of the reporting interval?                                                         | No     |
    | Are emergency and evacuation procedures established and understood by the Person(s) entering the pump room?                       | Yes    |
    | Have the names of the person(s) entering the pump room been recorded in the Port operations log together with the time of entry?  | Yes    |
    | Are the person(s) entering the pump room aware that after exiting the space a report to the responsible officer must be made?     | Yes    |
    | Are the persons entering the pump room familiar with the emergency alarm meant for  CO2 / Foam flooding?                          | Yes    |
    | Are the persons entering the pump room familiar with the location of the emergency trips for the cargo pumps?                     | Yes    |
    | Is the pumproom bilge dry?                                                                                                        | Yes    |
  And CommonEntry click Add Gas Reader
  And PinEntry enter pin for rank "A C/O"
  Then GasReadings add normal gas readings
  And GasReadings click Review & Sign button
  And SignatureLocation sign off
    | area        | zone             |
    | Bridge Deck | Port Bridge Wing |
  And GasReadings click done button on gas reader dialog box
  And PumpRoomEntry select Permit Duration 8
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

  Scenario: Verify non cre/pre responsible authority can not submit PRE (SOL-6120)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And PumpRoomEntry fill text area
    Then PumpRoomEntry answer question
      | Location of vessel                                                                                                                | At Sea |
      | Has the exhaust ventilation system been switched on and running for at least 15 mins?                                             | No     |
      | Are all the Pump room lights switched on?                                                                                         | Yes    |
      | Is the fixed equipment for continuous monitoring of the atmosphere working properly and calibrated?                               | Yes    |
      | Are the personnel entering the pump room aware of the reporting interval?                                                         | Yes    |
      | Has communication with the responsible officer been established?                                                                  | Yes    |
      | Has the exhaust uptake been set to draw air from the lowest point in the pump room?                                               | Yes    |
      | Is the Emergency evacuation harness ready for use?                                                                                | Yes    |
      | Have the personal monitors for persons entering the pump room been checked for readiness?                                         | Yes    |
      | Are the personnel entering the pump room aware of the locations of the ELSA / EEBD and familiar with its use?                     | Yes    |
      | Are the personnel entering the pump room aware of the reporting interval?                                                         | No     |
      | Are emergency and evacuation procedures established and understood by the Person(s) entering the pump room?                       | Yes    |
      | Have the names of the person(s) entering the pump room been recorded in the Port operations log together with the time of entry?  | Yes    |
      | Are the person(s) entering the pump room aware that after exiting the space a report to the responsible officer must be made?     | Yes    |
      | Are the persons entering the pump room familiar with the emergency alarm meant for  CO2 / Foam flooding?                          | Yes    |
      | Are the persons entering the pump room familiar with the location of the emergency trips for the cargo pumps?                     | Yes    |
      | Is the pumproom bilge dry?                                                                                                        | Yes    |
    And CommonEntry click Add Gas Reader
    And PinEntry enter pin for rank "A C/O"
    And GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    When GasReadings click done button on gas reader dialog box
    And PumpRoomEntry select Permit Duration 8
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

  Scenario Outline: Verify cre/pre responsible authority can submit PRE from updates_needed
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
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

  Scenario: Verify non cre/pre responsible authority can not submit PRE from updates_needed
    Given EntryGenerator create entry permit
      | entry_type | permit_status  |
      | pre        | UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
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

  Scenario Outline: Verify cre/pre approval authority can approve and submit PRE to scheduled (SOL-6121)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
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

  Scenario: Verify non cre/pre approval authority can not submit PRE to scheduled (SOL-6121)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
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

  Scenario Outline: Verify cre/pre approval authority can request update for PRE (SOL-6141)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
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

  Scenario Outline: Verify cre/pre eraser can delete PRE (SOL-6142)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    And CreatedEntry save first permit id
    And CreatedEntry click delete
    When PinEntry enter pin for rank "<rank>"
    Then CreatedEntry verify deleted permit not presents in list
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario: Verify non cre/pre eraser can not delete PRE (SOL-6142)
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | pre  | created |
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

  Scenario Outline: Verify cre/pre eraser can delete PRE in pending approval state
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state   |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click delete
    When PinEntry enter pin for rank "<rank>"
    Then PendingApprovalEntry verify deleted permit not presents in list
    Examples:
      | rank  |
      | MAS   |
      | A/M   |

  Scenario: Verify non cre/pre eraser can not delete PRE in pending approval state
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state   |
      | pre  | pending-officer-approval |
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

Scenario Outline: Verify cre/pre eraser can delete PRE in approved for activation state
  Given EntryGenerator create entry permit
    | entry_type | permit_status            |
    | pre        | PENDING_OFFICER_APPROVAL |
  And SmartForms navigate to state page
    | type | state                    |
    | pre  | pending-officer-approval |
  And PendingApprovalEntry click Officer Approval
  When PinEntry enter pin for rank "C/O"
  And CommonEntry click approve for activation
  When PinEntry enter pin for rank "C/O"
  And SignatureLocation sign off
    | area        | zone             |
    | Bridge Deck | Port Bridge Wing |
  Then Submitted verify the form is Successfully Submitted
  And SmartForms navigate to state page
    | type | state                 |
    | pre  |approved-for-activation|
  And ScheduledEntry click delete
  When PinEntry enter pin for rank "<rank>"
  Then ScheduledEntry verify deleted permit not presents in list
  Examples:
    | rank  |
    | MAS   |
    | A/M   |

  Scenario: Verify non cre/pre eraser can not delete PRE in approved for activation state
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    When PinEntry enter pin for rank "C/O"
    And CommonEntry click approve for activation
    When PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    Then Submitted verify the form is Successfully Submitted
    And SmartForms navigate to state page
      | type | state                 |
      | pre  |approved-for-activation|
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

  Scenario Outline: Verify cre/pre terminator can terminate for PRE (SOL-6122)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | pre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And PumpRoomEntry click Terminate
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

  Scenario: Verify non cre/pre terminator can not terminate for PRE (SOL-6122)
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | pre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And PumpRoomEntry click Terminate
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

  Scenario Outline: Verify only cre/pre approval authority can see the approve or request update button for PRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
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

  Scenario Outline: Verify a creator PRE cannot activate his own PRE (SOL-6127)
    Given EntryGenerator create entry permit
      | entry_type | permit_status            | creator_rank |
      | pre        | PENDING_OFFICER_APPROVAL | <rank>       |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
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
