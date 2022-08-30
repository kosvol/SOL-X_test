@loa_lng_post_creation_ptw
Feature: LOA LNG Permit to Work for post creation

  @clear_form_lng
  Scenario: clear form data
    Given DB service clear couch table
      | db_type | table                  |
      | edge    | forms                  |
      | cloud   | forms                  |
      | cloud   | office_approval_events |
      | edge    | gas_reader_entry       |
      | cloud   | gas_reader_entry       |
    And DB service clear postgres data


  Scenario Outline: Verify default approval authority can approve permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    And Section7 click activate
    When PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank |
      | MAS  |
      | A/M  |

  Scenario Outline: Verify non default approval authority can not approve permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading |
      | enclosed_spaces_entry | pending_approval | no  | no          |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    And Section7 click activate
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
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


  Scenario Outline: Verify default ptw updater can edit permit for APPROVAL_UPDATES_NEEDED
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


  Scenario Outline: Verify non default ptw updater can not edit permit for APPROVAL_UPDATES_NEEDED
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


  Scenario Outline: Verify default ptw updater can edit permit for TERMINATION_UPDATES_NEEDED
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


  Scenario Outline: Verify non default ptw updater can not edit permit for TERMINATION_UPDATES_NEEDED
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


  Scenario Outline: Verify default ptw terminator can submit for termination
    Given SmartForms open page
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


  Scenario Outline: Verify non default ptw terminator can not submit for termination
    Given SmartForms open page
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
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
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


  Scenario Outline: Verify default ptw withdrawer can withdraw permit
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


  Scenario Outline: Verify non default ptw withdrawer can not withdraw permit
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading |
      | enclosed_spaces_entry | pending_withdrawal | no  | no          |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "MAS"
    And Section9 click Withdraw Permit To Work
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
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


  Scenario Outline: Verify default ptw eraser can delete created permit
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "1" sec
    And CreatedPTW delete first permit id
    And PinEntry enter pin for rank "<rank>"
    And CommonSection sleep for "1" sec
    Then CreatedPTW verify deleted permit
    Examples:
      | rank |
      | MAS  |
      | A/M  |


  Scenario Outline: Verify non default ptw eraser can not delete created permit
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "1" sec
    And CreatedPTW delete first permit id
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
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


  Scenario Outline: Verify default periodic gas tester can add periodic test record
    Given SmartForms open page
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


  Scenario Outline: Verify non default periodic gas tester can not add periodic test record
    Given SmartForms open page
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
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
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