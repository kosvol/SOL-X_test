@rol_section2
Feature: RoL Section 2: Checklist

  Scenario: Verify Checklist details are pre-filled
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    And CommonSection click Save & Next
    Then RoLSectionTwo verify checklist details

  Scenario: Verify all section 2 data is displayed
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    And CommonSection click Save & Next
    Then RoLSectionTwo verify section 2 data
    And RoLSectionTwo verify checklist warning box

  Scenario: Verify Description of boarding arrangement dropdown input fields are correct
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    And CommonSection click Save & Next
    Then RoLSectionTwo verify dropdown for "Description of boarding arrangement"
      | Port Pilot Ladder            |
      | Starboard Pilot Ladder       |
      | Port Combination Ladder      |
      | Starboard Combination Ladder |
      | Port Gangway                 |
      | Starboard Gangway            |
      | MOT                          |

  Scenario: Verify Duration dropdown input fields are correct
    Given PermitGenerator create permit
      | permit_type        | permit_status    |
      | rigging_of_ladder  | pending_approval |
    Given SmartForms open page
    And SmartForms navigate to "Pending Approval" page using UI
    And PendingApprovalPTW click Approval button
    When PinEntry enter pin for rank "MAS"
    And CommonSection click Next button
    Then RoLSectionTwo verify dropdown for "Duration"
      | 1 hour |
      | 2 hour |
      | 3 hour |
      | 4 hour |
      | 5 hour |
      | 6 hour |
      | 7 hour |
      | 8 hour |

  Scenario: Active RoL permit should only have 'View' and 'View / Termination' button (SOL-4477)
    Given PermitGenerator create permit
      | permit_type        | permit_status |
      | rigging_of_ladder  | active        |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    Then ActivePTW should see view and termination buttons

  Scenario: Verify submit for master approval button is enabled and there are no extra buttons via pending update (SOL-4773)
    Given PermitGenerator create permit
      | permit_type       | permit_status  | new_status              |
      | rigging_of_ladder | updates_needed | APPROVAL_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    When PinEntry enter pin for rank "3/E"
    Then RoLSectionOne should not see previous button
    And RoLSectionOne verify next button is "Save & Next"
    When CommonSection click Save & Next
    Then RoLSectionTwo verify submit button is "enabled"
    And RoLSectionTwo should not see extra buttons

  Scenario Outline: Verify RA, Checklist Creator and other Crew ranks cannot edit the Duration field when the form is in the PENDING_MASTER'S_APPROVAL state (SOL-5210)
    Given PermitGenerator create permit
      | permit_type        | permit_status    |
      | rigging_of_ladder  | pending_approval |
    And SmartForms open page
    And SmartForms navigate to "Pending Approval" page using UI
    And PendingApprovalPTW click Approval button
    When PinEntry enter pin for rank "<rank>"
    And CommonSection click Next button
    Then RoLSectionTwo verify duration dropdown cannot be clicked

    Examples:
      | rank  |
      | C/O   |
      | A/B   |
      | 4/E   |
      | BOS   |

  Scenario Outline: Verify ROL permit validity is accurate as per permit activation duration
    Given PermitGenerator create permit
      | permit_type        | permit_status    |
      | rigging_of_ladder  | pending_approval |
    And SmartForms open page
    And SmartForms navigate to "Pending Approval" page using UI
    And PendingApprovalPTW click Approval button
    When PinEntry enter pin for rank "MAS"
    And CommonSection click Next button
    And RoLSectionTwo select the duration <duration>
    And RoLSectionTwo click activate
    And PinEntry enter pin for rank "MAS"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CommonSection click Back to Home button
    And SmartForms navigate to "Active" page using UI
    Then ActivePTW verify time left less than "<duration>"

    Examples:
      | duration |
      | 1        |
      | 2        |
      | 3        |
      | 4        |
      | 5        |
      | 6        |
      | 7        |
      | 8        |

  Scenario: Verify duration is not selectable on active permit, pending termination, termination update needed states (SOL-5189)
    Given PermitGenerator create permit
      | permit_type        | permit_status |
      | rigging_of_ladder  | active        |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "BOS"
    And CommonSection click Previous
    Then RoLSectionTwo verify duration dropdown cannot be clicked
    Given PermitGenerator create permit
      | permit_type       | permit_status      |
      | rigging_of_ladder | pending_withdrawal |
    Given SmartForms open page
    And SmartForms navigate to "Pending Withdrawal" page using UI
    And PendingWithdrawalPTW click Review & Withdraw button
    And PinEntry enter pin for rank "5/E"
    And CommonSection click Previous
    Then RoLSectionTwo verify duration dropdown cannot be clicked
    Given PermitGenerator create permit
      | permit_type       | permit_status  | new_status                 |
      | rigging_of_ladder | updates_needed | TERMINATION_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    When PinEntry enter pin for rank "A/B"
    And CommonSection click Previous
    Then RoLSectionTwo verify duration dropdown cannot be clicked
