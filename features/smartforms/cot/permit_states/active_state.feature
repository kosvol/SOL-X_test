@active-permit
Feature: COT active permit

  Scenario: Verify maintenance more than 2 hours AND oa permits land at section 6 via Update Reading with RA
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading | bfr_photo |
      | main_anchor | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "1" sec
    And ActivePTW click Gas Test button
    When PinEntry enter pin for rank "C/O"
    Then Section6 verify gas reading note


  Scenario: Verify maintenance more than 2 hours AND oa permits land at section 8 via Submit for Termination with RA
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading | bfr_photo |
      | main_anchor | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "1" sec
    And ActivePTW click View/Terminate button
    When PinEntry enter pin for rank "C/O"
    Then Section8 answer task status "Completed"


  Scenario: Verify non maintenance AND oa permits land at section 6 via Update Reading with RA
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "1" sec
    And ActivePTW click Gas Test button
    When PinEntry enter pin for rank "C/O"
    Then Section6 verify gas reading note


  Scenario: Verify non maintenance AND oa permits land at section 8 via Submit for Termination with RA
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading | bfr_photo |
      | main_anchor | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "1" sec
    And ActivePTW click View/Terminate button
    When PinEntry enter pin for rank "C/O"
    Then Section8 answer task status "Completed"


  Scenario: Verify section 8 buttons display are correct
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading | bfr_photo |
      | main_anchor | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "1" sec
    And ActivePTW click View/Terminate button
    When PinEntry enter pin for rank "C/O"
    Then CommonSection click Close button

  Scenario: Verify section 8 Competent Person sign button is disable for read only user
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading | bfr_photo |
      | main_anchor | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "1" sec
    And ActivePTW click View/Terminate button
    When PinEntry enter pin for rank "C/O"
    Then CommonSection click Close button

  Scenario: Verify section 8 Issuing Authority sign button is disable for read only user
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading | bfr_photo |
      | main_anchor | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And CommonSection sleep for "1" sec
    And ActivePTW click View/Terminate button
    When PinEntry enter pin for rank "MAS"
    Then Section8 verify sign button are disabled

  Scenario: Verify maintenance permit issue date is display
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading | bfr_photo |
      | main_anchor | active        | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    When CommonSection sleep for "1" sec
    Then ActivePTW verify issued date

#  Scenario: Verify all underwater permit only valid for 4 hours
#    Given I launch sol-x portal without unlinking wearable
#    And I navigate to create new permit
#    And I enter pin for rank C/O
#    And I select Underwater Operations permit
#    And I select Underwater Operation at night or concurrent with other operations permit for level 2
#    And I fill only location of work
#    And I press next for 7 times
#    And I sign checklist and section 5
#    And I press next for 1 times
#    Then I submit permit for Master Review
#    When I click on back to home
#    And I click on pending approval filter
#    And I set oa permit to office approval state manually
#    And I click on pending approval filter
#    And I navigate to OA link
#    And I approve oa permit via oa link manually
#    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
#    And I click on pending approval filter
#    And I approve permit
#    And I click on back to home
#    And I click on active filter
#    Then I should see permit valid for 4 hours

  Scenario: Verify all maintenance permit with duration less than 2 hours should have 2 hours validity
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection fill up maintenance required fields
    And CommonSection sleep for "2" sec
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    And Section7 click activate
    And PinEntry enter pin for rank "MAS"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    Then ActivePTW verify time left less than "2"

  Scenario: Verify normal permit should have 8 hours validity
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection fill up required fields
    And CommonSection sleep for "2" sec
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 7"
    And Section7 click activate
    And PinEntry enter pin for rank "MAS"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    Then ActivePTW verify time left less than "8"


#  Scenario Outline: Verify RoL permit validity will be based on user selection
#    Given I launch sol-x portal without unlinking wearable
#    And I navigate to create new permit
#    And I enter pin for rank C/O
#    And I select Rigging of Gangway & Pilot Ladder permit
#    And I select NA permit for level 2
#    When I press next for 1 times
#    Then I submit permit for Master Approval
#    When I click on back to home
#    And I click on pending approval filter
#    And I set rol permit to active state with <duration> duration
#    And I sleep for 3 seconds
#    And I click on active filter
#    Then I should see permit valid for <duration> hours
#
#    Examples:
#      | duration |
#      | 1        |
#      | 2        |
#      | 3        |
#      | 4        |
#      | 5        |
#      | 6        |
#      | 7        |
#      | 8        |