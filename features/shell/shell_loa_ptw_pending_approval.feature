@shell_loa_ptw_pending_approval
Feature: SHELL level of authority pending approvalPTW


  Scenario Outline: [Pending Approval] Verify rank can submit for approval
    Given PermitGenerator create permit
      | permit_type       | permit_status    | eic | gas_reading | bfr_photo |
      | lifting_operation | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And PendingApprovalPTW click approval button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    And CommonSection click Next button
    Then Section7 verify activate button is "enabled"
    And Section7 verify request update button is "enabled"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/E   |
      | A C/E |



  Scenario Outline: [Pending Approval] Verify rank can't submit for approval
    Given PermitGenerator create permit
      | permit_type       | permit_status    | eic | gas_reading | bfr_photo |
      | lifting_operation | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And CommonSection sleep for "2" sec
    And PendingApprovalPTW click approval button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    Then CommonSection click Close button
    Examples:
      | rank |
      | C/O  |
      | 2/O  |
      | 2/E  |
      | ETO  |


