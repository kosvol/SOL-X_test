@section7
Feature: Section 7: Validity of Permit

  @sol-6553
  Scenario: Verify validity from and to is correct for non OA permit
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "3" sec
    And ActivePTW save time info
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Previous
    Then Section7B verify validity date and time

  @sol-6553
  Scenario: Verify validity from and to is correct for OA permit
    Given PermitGenerator create permit
      | permit_type     | permit_status | eic | gas_reading | bfr_photo |
      | use_safe_camera | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW save time info
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Previous
    Then Section7B verify validity date and time


  Scenario: Verify Master can see approve and update buttons for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    Then Section7 verify activate button is "enabled"
    And Section7 verify request update button is "enabled"
