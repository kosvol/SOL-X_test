@rol_section3
Feature: RoL Section 3: Task Status

  Scenario: Verify task commenced at should be populated with permit activated time
    Given PermitGenerator create permit
      | permit_type       | permit_status |
      | rigging_of_ladder | active        |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW save time info
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    Then RoLSectionThree verify task commenced time

  Scenario: Verify all section 3 data is displayed
    Given PermitGenerator create permit
      | permit_type       | permit_status |
      | rigging_of_ladder | active        |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    Then RoLSectionThree verify section 3 data

  Scenario: Verify no duplicate 'Previous' and 'Close' buttons during pending withdrawal state
    Given PermitGenerator create permit
      | permit_type       | permit_status      |
      | rigging_of_ladder | pending_withdrawal |
    Given SmartForms open page
    And SmartForms navigate to "Pending Withdrawal" page using UI
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "MAS"
    And RoLSectionThree should not see extra Previous and Close buttons

  Scenario: Verify termination page display previous and close buttons for read only user
    Given PermitGenerator create permit
      | permit_type       | permit_status      |
      | rigging_of_ladder | pending_withdrawal |
    Given SmartForms open page
    And SmartForms navigate to "Pending Withdrawal" page using UI
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "5/E"
    And RoLSectionThree should not see extra Previous and Close buttons
