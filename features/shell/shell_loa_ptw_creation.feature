@shell_loa_ptw_creation
Feature: SHELL level of authority PTW creation

  Scenario Outline: [Section0] Verify only RA can create permit
    Given SmartForms open page
    And SmartForms click create permit to work
    When PinEntry enter pin for rank "<rank>"
    Then FormPrelude should see select permit type header
    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 2/E   |


  Scenario Outline: [Section0] Verify non RA cannot create permit
    Given SmartForms open page
    And SmartForms click create permit to work
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | A/M   |
      | MAS   |
      | 4/O   |
      | D/C   |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | BOS   |
      | PMN   |
      | A/B   |


  Scenario Outline: [Section3D] Verify rank can not edit permit in created state
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Lifting Operation"
    And SmartForms open "created" page
    And CommonSection sleep for "1" sec
    And CreatedPTW click first permit
    And PinEntry enter pin for rank "<rank>"
    Then Section1 verify next button is "Next"
    Examples:
      | rank  |
      | C/E   |
      | A C/E |
      | CGENG |


  Scenario Outline: [Section3D] Verify rank can edit permit in created state
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Lifting Operation"
    And SmartForms open "created" page
    And CommonSection sleep for "1" sec
    And CreatedPTW click first permit
    And PinEntry enter pin for rank "<rank>"
    Then Section1 verify next button is "Save & Next"
    Examples:
      | rank  |
      | 3/E   |
      | A 3/E |
      | 4/E   |
#      | A 4/E |


  Scenario Outline: [Section3D] Verify MAS, A/M, C/E, A C/E can sign on section 3d
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Lifting Operation"
    And SmartForms open "created" page
    And CommonSection sleep for "1" sec
    And CreatedPTW click first permit
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section3D should see location stamp "No. 1 Cargo Tank Port"
    And Section3D verify signature rank "<rank>"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/E   |
      | A C/E |


  Scenario Outline: [Section3D] Verify non RA cannot sign on section 3d
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And SmartForms open "created" page
    And CommonSection sleep for "1" sec
    And CreatedPTW click first permit
    And PinEntry enter pin for rank "<rank>"
    And CommonSection navigate to "Section 3D"
    Then Section3D verify sign button is "disabled"
    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | 2/E   |
#      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
#      | A 4/E |


  Scenario Outline: [Section4A] Verify rank can't sign checklist
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4A"
    And CommonSection sleep for "2" sec
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | MAS  |
      | A/M  |
      | C/E  |
      | 4/O  |
      | D/C  |


  Scenario Outline: [Section4A] Verify rank can sign checklist
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4A"
    And CommonSection sleep for "2" sec
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Checklist should see location stamp "No. 1 Cargo Tank Port"
    And Checklist verify signature rank "<rank>"
    Examples:
      | rank  |
      | CGENG |
      | C/O   |
      | A C/O |
      | ETO   |


  Scenario Outline: [Section4B EIC] Verify rank can sign for competent person
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click competent person sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then EIC verify signed detail
      | rank   | location_stamp        |
      | <rank> | No. 1 Cargo Tank Port |
    Examples:
      | rank  |
      | 2/O   |
      | 3/O   |
      | 3/E   |
      | A 3/E |
      | 4/E   |
    #      | A 4/E |
      | ETO   |
      | CGENG |


  Scenario Outline: [Section4B EIC] Verify rank can't sign for competent person
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click competent person sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | MAS  |
      | A/M  |
      | 4/O  |


  Scenario Outline: [Section4B EIC] Verify rank can sign for issuing person
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click issuing person sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then EIC verify signed detail
      | rank   | location_stamp        |
      | <rank> | No. 1 Cargo Tank Port |
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/E   |
      | A C/E |


  Scenario Outline: [Section4B EIC] Verify rank can't sign for issuing person
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click issuing person sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | C/O  |
      | 2/O  |
      | 4/O  |


  Scenario Outline: [Section4B] Verify non RA cannot sign on responsible authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4B"
    And Section4B click sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | C/E  |
      | MAS  |
      | A/M  |
      | 4/O  |


  Scenario: [Section4B] Verify Cargo Engineer can sign on responsible authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 4B"
    And Section4B click sign button
    When PinEntry enter pin for rank "CGENG"
    Then SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |


  Scenario Outline: [Section5] Verify rank can sign signature
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section5 verify signature
      | role                 | rank   |
      | Authorized Entrant 1 | <rank> |
    Examples:
      | rank  |
      | A C/O |
      | A 2/O |
#      | A 2/E |
      | CGENG |


  Scenario Outline: [Section6] Verify rank can sign for new gas reading
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "<rank>"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And Section6 click done button
    Then Section6 verify gas reading display
      | O2  | HC      | CO    | H2S   | Toxic  | Rank   |
      | 1 % | 2 % LEL | 3 PPM | 4 PPM | 1.5 CC | <rank> |
    Examples:
      | rank |
      | C/O  |
      | ETO  |


  Scenario Outline: [Section6] Verify rank can not sign for new gas reading
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | MAS  |
      | A/M  |
      | C/E  |


  Scenario Outline: [Section6] Verify rank can submit for master approval
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And Section1 select zone
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 4A"
    And CommonSection sleep for "1" sec
    And CommonSection click Save & Next
    And CommonSection sleep for "1" sec
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 5"
    And CommonSection sleep for "1" sec
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 6"
    And CommonSection sleep for "1" sec
    Then Section6 click submit button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Examples:
      | rank  |
      | 3/E   |
      | A 3/E |
      | 4/E   |
#      | A 4/E |
      | CGENG |


  Scenario Outline: [Section6] Verify rank can not submit for master approval
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Lifting Operation"
    And Section1 select zone
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 4A"
    And CommonSection sleep for "1" sec
    And CommonSection click Save & Next
    And CommonSection sleep for "1" sec
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 5"
    And CommonSection sleep for "1" sec
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 6"
    And CommonSection sleep for "1" sec
    Then Section6 click submit button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
      | MAS  |
      | C/E  |
