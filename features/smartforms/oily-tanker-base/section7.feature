@section7
Feature: Section 7: Validity of Permit

  @sol-6553
  Scenario: Verify validity from and to is correct for non OA permit
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW save time info
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Previous
    Then Section7B verify validity date and time

  @sol-6553
  Scenario: Verify validity from and to is correct for OA permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | active | yes | yes         | 2         |
    And SmartForms open "active" page
    And ActivePTW save time info
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Previous
    Then Section7B verify validity date and time


  Scenario: Verify Master can see approve and update buttons for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    Then Section7 verify activate button is "enabled"
    And Section7 verify request update button is "enabled"


  Scenario: Verify Master can review and update button for oa permit
    Given PermitGenerator create permit
      | permit_type     | permit_status    | eic | gas_reading | bfr_photo |
      | use_safe_camera | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 6"
    Then Section6 verify submit button is "enabled"
    And Section6 verify submit button text is "Submit for Office Approval"


  Scenario Outline: Verify non Master will not see office approval, request update and close button for oa permit
    Given PermitGenerator create permit
      | permit_type     | permit_status    | eic | gas_reading | bfr_photo |
      | use_safe_camera | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    Then Section6 "should not" see submit and update button
    Examples:
      | rank |
      | C/O  |
      | C/E  |


  Scenario Outline: Verify non Master will not see approve and request update button for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    Then Section6 "should not" see submit and update button
    Examples:
      | rank |
      | C/O  |
      | C/E  |
