@section9
Feature: Section9: Withdrawal of Permit


  Scenario: Verify section 9 buttons display are correct via pending termination state
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading | aft_photo |
      | enclosed_spaces_entry | pending_withdrawal | no  | yes         | 2         |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "4/E"
    And CommonSection click Previous
    When CommonSection click Next button
    Then CommonSection click Close button


  Scenario: Verify Master can see terminate and update buttons for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading | aft_photo |
      | enclosed_spaces_entry | pending_withdrawal | no  | yes         | 2         |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    When PinEntry enter pin for rank "MAS"
    Then Section9 verify withdraw button is "enabled"
    And Section9 verify request updates button is "enabled"


  Scenario: Verify Master can see terminate and update buttons for oa permit
    Given PermitGenerator create permit
      | permit_type     | permit_status      | eic | gas_reading | aft_photo |
      | use_safe_camera | pending_withdrawal | no  | yes         | 2         |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    When PinEntry enter pin for rank "MAS"
    Then Section9 verify withdraw button is "enabled"
    And Section9 verify request updates button is "enabled"


  Scenario: Verify non Master will not see withdraw and request update button for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading | aft_photo |
      | enclosed_spaces_entry | pending_withdrawal | no  | yes         | 2         |
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    And PendingWithdrawalPTW click Review & Withdraw button
    When PinEntry enter pin for rank "C/O"
    Then Section9 verify withdrawn signature section is hidden


  Scenario Outline: Verify Status Update display as completed when user submit as continue
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And Section8 answer task status "<task_status>"
    And CommonSection sleep for "3" sec
    And Section8 click Submit For Termination
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "3" sec
    And SmartForms navigate to state page
      | type | state              |
      | ptw  | pending-withdrawal |
    Then PendingWithdrawalPTW verify task status is "<task_status>"
    Examples:
      | task_status |
      | Completed   |
      | Suspended   |
