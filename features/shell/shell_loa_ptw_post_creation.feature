@shell_loa_ptw_post_creation
Feature: SHELL level of authority post ptw creation

  Scenario Outline: [Pending Approval] Verify rank can activate permit
    Given PermitGenerator create permit
      | permit_type       | permit_status    | eic | gas_reading | bfr_photo |
      | lifting_operation | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And PendingApprovalPTW click Approval button
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


  Scenario Outline: [Pending Approval] Verify rank can't activate permit
    Given PermitGenerator create permit
      | permit_type       | permit_status    | eic | gas_reading | bfr_photo |
      | lifting_operation | pending_approval | yes | yes         | 2         |
    And SmartForms open "pending-approval" page
    And CommonSection sleep for "2" sec
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    Then CommonSection click Close button
    Examples:
      | rank |
      | C/O  |
      | 2/O  |
      | 2/E  |
      | ETO  |


  Scenario Outline: [Active] Verify rank can't terminate permit
    Given PermitGenerator create permit
      | permit_type       | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | lifting_operation | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 8"
    Then Section8 verify RA signature section is hidden
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | 4/O   |
      | C/E   |
      | A C/E |


  Scenario Outline: [Active] Verify rank can terminate permit
    Given PermitGenerator create permit
      | permit_type       | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | lifting_operation | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 8"
    Then Section8 verify termination button is "enabled"
    Examples:
      | rank |
      | 2/E  |
#      | A 2/E |
      | C/O  |
      | 2/O  |
      | ETO  |


  Scenario Outline: [Pending Withdrawal] Verify rank can withdraw permit
    Given PermitGenerator create permit
      | permit_type       | permit_status      | eic | gas_reading | bfr_photo | aft_photo |
      | lifting_operation | pending_withdrawal | yes | no          | 2         | 2         |
    And SmartForms open "pending-withdrawal" page
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "<rank>"
    Then Section9 verify withdraw button is "enabled"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/E   |
      | A C/E |


  Scenario Outline: [Pending Withdrawal] Verify rank can't withdraw permit
    Given PermitGenerator create permit
      | permit_type       | permit_status      | eic | gas_reading | bfr_photo | aft_photo |
      | lifting_operation | pending_withdrawal | yes | no          | 2         | 2         |
    And SmartForms open "pending-withdrawal" page
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "<rank>"
    Then Section9 verify withdrawn signature section is hidden
    Examples:
      | rank |
      | 2/E  |
#      | A 2/E |
      | C/O  |
      | 2/O  |
      | ETO  |


  Scenario Outline: [Updates Needed] Verify rank can't edit updates needed permit
    Given PermitGenerator create permit
      | permit_type       | permit_status  | new_status              | eic | gas_reading | bfr_photo |
      | lifting_operation | updates_needed | APPROVAL_UPDATES_NEEDED | yes | yes         | 2         |
    And SmartForms open "updates-needed" page
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    Then Section6 verify submit button is "disabled"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/E   |
      | A C/E |
      | CCK   |


  Scenario Outline: [Updates Needed] Verify rank can edit updates needed permit
    Given PermitGenerator create permit
      | permit_type       | permit_status  | new_status              | eic | gas_reading | bfr_photo |
      | lifting_operation | updates_needed | APPROVAL_UPDATES_NEEDED | yes | yes         | 2         |
    And SmartForms open "updates-needed" page
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 6"
    Then Section6 verify submit button is "enabled"
    Examples:
      | rank |
      | C/O  |
      | 2/O  |
      | 3/O  |
      | 2/E  |
      | ETO  |
