@section5
Feature: Section 5: Responsibility Acceptance

  @SOL-7490
  Scenario: Verify signature exists after navigating
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
      | Authorized Entrant 2 |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/E"
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    And CommonSection click Save & Next
    And CommonSection sleep for "2" sec
    When CommonSection click Previous
    Then Section5 verify signature
      | role                 | rank |
      | Authorized Entrant 1 | C/O  |
      | Authorized Entrant 2 | C/E  |


  Scenario: Verify signature component is deleted after removing Roles & Responsibilities from drop down
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1  |
      | Authorized Entrant 2  |
      | Authorized Entrant 3  |
      | Authorized Gas Tester |
    And Section5 select role
      | Authorized Entrant 1  |
      | Authorized Gas Tester |
    Then Section5 verify "role_list"
      | Authorized Entrant 2 |
      | Authorized Entrant 3 |
    And Section5 verify "signature_list"
      | Authorized Entrant 2 |
      | Authorized Entrant 3 |


  Scenario: Verify signature component is deleted after removing Roles & Responsibilities via cross
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1  |
      | Authorized Entrant 2  |
      | Authorized Entrant 3  |
      | Authorized Gas Tester |
    And Section5 delete role
      | Authorized Entrant 2 |
      | Authorized Entrant 3 |
    Then Section5 verify "role_list"
      | Authorized Entrant 1  |
      | Authorized Gas Tester |
    And Section5 verify "signature_list"
      | Authorized Entrant 1  |
      | Authorized Gas Tester |


  Scenario: Verify user can see a list of roles
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    Then Section5 verify role full list


  Scenario: Verify same user can sign for multiple roles
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
      | Authorized Entrant 2 |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    Then Section5 verify signature
      | role                 | rank |
      | Authorized Entrant 1 | C/O  |
      | Authorized Entrant 2 | C/O  |


  Scenario: Verify Enter Pin and Sign button is disable if sign as non crew checked
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Sign as non-crew member
    Then Section5 verify sign button is 'disabled'


  Scenario: Verify Enter Pin and Sign button is enabled if name and company fields filled
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Sign as non-crew member
    And Section5 enter non-crew info
      | name      | company      |
      | test_crew | test_company |
    Then Section5 verify sign button is 'enabled'
    And Section5 verify non-crew hint


  Scenario Outline: Verify only sponsor crews can sign
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Sign as non-crew member
    And Section5 enter non-crew info
      | name                 | company                 |
      | test_crew_automation | test_company_automation |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    Then Section5 verify supervised signature
      | rank   | role                 | name                 | company                 |
      | <rank> | Authorized Entrant 1 | test_crew_automation | test_company_automation |

    Examples:
      | rank |
      | C/O  |
#      | A C/O |
      | 2/O  |
#      | A 2/O |
      | 3/O  |
      | C/E  |
#      | A C/E |
      | 2/E  |
#      | A 2/E |
      | 3/E  |
#      | A 3/E |
      | 4/E  |

  Scenario: Verify non sponsor crews cannot sign
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Sign as non-crew member
    And Section5 enter non-crew info
      | name      | company      |
      | test_crew | test_company |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "MAS"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"


  Scenario: Verify crew can sign
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Sign as non-crew member
    And Section5 enter non-crew info
      | name      | company      |
      | test_crew | test_company |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    Then Section5 verify supervised signature
      | rank | role                 | name      | company      |
      | C/O  | Authorized Entrant 1 | test_crew | test_company |


  Scenario:  Verify linked user will show the default location in section5 signature
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank | zone_id       | mac               |
      | C/O  | Z-AFT-STATION | 00:00:00:00:00:10 |
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/O"
    And SignatureLocation should see zone as "Aft Station"