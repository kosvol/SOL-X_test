@loa_cot_post_creation_ptw
Feature: LOA COT Permit to Work for post creation

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

  Scenario Outline: Verify default approval authority can approve permit (SOL-8717)
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    And Section7 click Activate
    When PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario: Verify non default approval authority can not approve permit (SOL-8717)
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    And Section7 click Activate
    Then PinEntry verify the error message is correct for the wrong rank
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
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

  Scenario Outline: Verify default approval authority can send permit for updates (SOL-8349)
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 7"
    And Section7 click Request Updates
    And Section7 enter AA comments "Test automation. Pending_master_approval "
    And Section7 click Submit
    And Submitted verify the form is Successfully Submitted
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify default approval authority can send terminated permit for updates
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading |
      | enclosed_spaces_entry | pending_withdrawal | no  | no          |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "<rank>"
    And Section9 click Request Updates
    And Section9 enter AA comments "Test automation, Pending_withdrawal"
    And Section9 click Submit
    And Submitted verify the form is Successfully Submitted
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify default ptw updater can edit permit for APPROVAL_UPDATES_NEEDED (SOL-8351)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              | eic | gas_reading |
      | enclosed_spaces_entry | updates_needed | APPROVAL_UPDATES_NEEDED | no  | no          |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    When PinEntry enter pin for rank "<rank>"
    Then Section1 verify next button is "Save & Next"
    Examples:
      | rank  |
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

  Scenario Outline: Verify non default ptw updater can not edit permit for APPROVAL_UPDATES_NEEDED (SOL-8351)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              | eic | gas_reading |
      | enclosed_spaces_entry | updates_needed | APPROVAL_UPDATES_NEEDED | no  | no          |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    When PinEntry enter pin for rank "<rank>"
    Then Section1 verify next button is "Next"
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
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

  Scenario Outline: Verify default ptw updater can edit permit for TERMINATION_UPDATES_NEEDED (SOL-8351)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status                 | eic | gas_reading |
      | enclosed_spaces_entry | updates_needed | TERMINATION_UPDATES_NEEDED | no  | no          |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    When PinEntry enter pin for rank "<rank>"
    Then CommonSection click Save button
    Examples:
      | rank  |
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

  Scenario Outline: Verify non default ptw updater can not edit permit for TERMINATION_UPDATES_NEEDED (SOL-8351)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status                 | eic | gas_reading |
      | enclosed_spaces_entry | updates_needed | TERMINATION_UPDATES_NEEDED | no  | no          |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    When PinEntry enter pin for rank "<rank>"
    Then CommonSection click Close button
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
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

  Scenario Outline: Verify default ptw terminator can submit for termination (SOL-8353)
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | active        | no  | no          |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And Section8 click Submit For Termination
    When PinEntry enter pin for rank "<rank>"
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

  Scenario: Verify non default ptw terminator can not submit for termination (SOL-8353)
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | active        | no  | no          |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And Section8 click Submit For Termination
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

  Scenario Outline: Verify default ptw withdrawer can withdraw permit (SOL-8361)
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading |
      | enclosed_spaces_entry | pending_withdrawal | no  | no          |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "MAS"
    And Section9 click Withdraw Permit To Work
    When PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario: Verify non default ptw withdrawer can not withdraw permit (SOL-8361)
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading |
      | enclosed_spaces_entry | pending_withdrawal | no  | no          |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "MAS"
    And Section9 click Withdraw Permit To Work
    Then PinEntry verify the error message is correct for the wrong rank
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
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

  Scenario Outline: Verify default ptw eraser can delete created permit (SOL-8341)
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW delete first permit id
    And PinEntry enter pin for rank "<rank>"
    Then CreatedPTW verify deleted permit
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario: Verify non default ptw eraser can not delete created permit (SOL-8341)
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW delete first permit id
    Then PinEntry verify the error message is correct for the wrong rank
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
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

  Scenario Outline: Verify default ptw eraser can delete a permit with PENDING_MASTER_APPROVAL state (SOL-8341)
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW delete first permit id
    And PinEntry enter pin for rank "<rank>"
    Then PendingApprovalPTW verify deleted permit
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify default periodic gas tester can add periodic test record (SOL-8552)
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | active        | no  | yes         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "<rank>"
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

  Scenario: Verify non default periodic gas tester can not add periodic test record (SOL-8552)
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | active        | no  | yes         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
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

  Scenario Outline: Verify default initial gas tester can update the gas test record in Updates Needed state (SOL-8410)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              | eic | gas_reading |
      | enclosed_spaces_entry | updates_needed | APPROVAL_UPDATES_NEEDED | no  | yes         |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "<rank>"
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

  Scenario: Verify non default initial gas tester can not update the gas test record in Updates Needed state (SOL-8410)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              | eic | gas_reading |
      | enclosed_spaces_entry | updates_needed | APPROVAL_UPDATES_NEEDED | no  | yes         |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
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

  Scenario Outline: Verify default dra signee can sign dra in Pending Approval (SOL-8308)
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section3D should see location stamp "No. 1 Cargo Tank Port"
    And Section3D verify signature rank "<rank>"
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

  Scenario: Verify non default dra signee can not sign dra Pending Approval (SOL-8308)
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
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

  Scenario Outline:Verify the "permit creator" should be able to approve the PTW which he created (SOL-8305)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<rank>"
    And FormPrelude select level1 "Enclosed Space Entry"
    And Section1 select zone
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    And PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection click Save & Next
    And Section6 save permit id
    And Section6 answer gas reading as "N/A"
    And Section6 click Submit button
    And PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And Submitted verify the form is Successfully Submitted
    And SmartForms navigate to "Pending Approval" page using UI
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    And Section7 click Activate
    When PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank |
      | A/M  |

  Scenario Outline: Verify default dra signee can sign dra in Master Review (SOL-8309)
    Given PermitGenerator create oa pending status permit
      | permit_type    | oa_status            | eic | gas_reading |
      | underwater_sim | PENDING_MASTER_REVIEW| no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Review button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section3D should see location stamp "No. 1 Cargo Tank Port"
    And Section3D verify signature rank "<rank>"
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

  Scenario Outline: Verify default approval authority can submit OA permit (SOL-8347)
    Given PermitGenerator create oa pending status permit
      | permit_type    | oa_status            | eic | gas_reading |
      | underwater_sim | PENDING_MASTER_REVIEW| no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Review button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    When Section6 click Submit for OA
    And Submitted verify the form is Successfully Submitted
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify default approval authority can send OA permit for updates (SOL-8720)
    Given PermitGenerator create oa pending status permit
      | permit_type    | oa_status            | eic | gas_reading |
      | underwater_sim | PENDING_MASTER_REVIEW| no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Review button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    And Section6 click Updates Needed
    And Section6 enter AA comments "Test automation. Pending_master_review"
    And Section6 click Submit button
    And Submitted verify the form is Successfully Submitted
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify default ptw eraser can delete a permit with PENDING_MASTER_REVIEW state (SOL-8341)
    Given PermitGenerator create oa pending status permit
      | permit_type    | oa_status            | eic | gas_reading |
      | underwater_sim | PENDING_MASTER_REVIEW| no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW delete first permit id
    And PinEntry enter pin for rank "<rank>"
    Then PendingApprovalPTW verify deleted permit
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify default approval authority can approve ROL permit
    Given PermitGenerator create permit
      | permit_type       | permit_status    | eic | gas_reading |
      | rigging_of_ladder | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection click Next button
    And RoLSectionTwo select the duration 8
    And RoLSectionTwo click Activate
    When PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario: Verify non default approval authority can not approve permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | rigging_of_ladder     | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection click Next button
    And RoLSectionTwo select the duration 8
    And RoLSectionTwo click Activate
    Then PinEntry verify the error message is correct for the wrong rank
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
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

  Scenario Outline: Verify default approval authority can send ROL permit for updates (SOL-3685)
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | rigging_of_ladder     | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection click Next button
    And RoLSectionTwo click Updates Needed
    And RoLSectionTwo enter AA comments "Test automation. Pending_master_approval"
    And RoLSectionTwo click Submit
    And Submitted verify the form is Successfully Submitted
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify default ROL responsible authority can submit rol permit for approval from Updates needed (SOL-3688)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              |
      | rigging_of_ladder     | updates_needed | APPROVAL_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Save & Next
    And RoLSectionTwo click Submit
    When PinEntry enter pin for rank "<rank>"
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

  Scenario: Verify default rigging of ladder responsible authority can NOT submit rol permit for approval from Updates needed (SOL-3688)
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              |
      | rigging_of_ladder     | updates_needed | APPROVAL_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Save & Next
    And RoLSectionTwo click Submit
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

  Scenario Outline: Verify default ptw terminator can submit ROL permit for termination
    Given PermitGenerator create permit
      | permit_type        | permit_status | eic | gas_reading |
      | rigging_of_ladder  | active        | no  | no          |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And RoLSectionThree click Submit For Termination
    When PinEntry enter pin for rank "<rank>"
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

  Scenario: Verify non default ptw terminator can not submit ROL permit for termination
    Given PermitGenerator create permit
      | permit_type       | permit_status | eic | gas_reading |
      | rigging_of_ladder | active        | no  | no          |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And RoLSectionThree click Submit For Termination
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

  Scenario Outline: Verify default ptw withdrawer can withdraw ROL permit
    Given PermitGenerator create permit
      | permit_type       | permit_status      | eic | gas_reading |
      | rigging_of_ladder | pending_withdrawal | no  | no          |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "MAS"
    And RoLSectionThree click Withdraw Permit To Work
    When PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario: Verify non default ptw withdrawer can not withdraw permit
    Given PermitGenerator create permit
      | permit_type       | permit_status      | eic | gas_reading |
      | rigging_of_ladder | pending_withdrawal | no  | no          |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "MAS"
    And RoLSectionThree click Withdraw Permit To Work
    Then PinEntry verify the error message is correct for the wrong rank
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
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

  Scenario Outline: Verify default ptw withdrawer can send terminated ROL permit to Updates (SOL-3701)
    Given PermitGenerator create permit
      | permit_type       | permit_status      | eic | gas_reading |
      | rigging_of_ladder | pending_withdrawal | no  | no          |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "<rank>"
    And RoLSectionThree click request_updates
    And RoLSectionThree enter AA comments "Test automation. Pending_withdrawal"
    And RoLSectionThree click Submit
    And Submitted verify the form is Successfully Submitted
    Examples:
      | rank |
      | MAS  |
      | A/M  |
