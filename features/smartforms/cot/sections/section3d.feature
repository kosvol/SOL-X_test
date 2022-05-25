@section3d
Feature: Section 3D: DRA - Summary & Assessment

  Scenario: Verify wearable can be picked up consistently
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank | zone_id       | mac               |
      | C/O  | Z-AFT-STATION | 00:00:00:00:00:10 |
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation should see zone as "Aft Station"


  Scenario: Verify location of work can be manual selected after pre-select via wearable
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank | zone_id       | mac               |
      | C/O  | Z-AFT-STATION | 00:00:00:00:00:10 |
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation click location dropdown
    And SignatureLocation select area "Accommodation"
    And SignatureLocation select zone "Ship's Office"
    And SignatureLocation should see zone as "Ship's Office"


  Scenario: Verify done button is disabled when location of work not filled
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation should see zone as "Select"


  Scenario: Verify location stamping on signature section 3d as RA
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section3D should see location stamp "No. 1 Cargo Tank Port"
    And Section3D verify signature rank "C/O"


  Scenario Outline: Verify ranks can sign on section 3d for level2 permits
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<created_rank>"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<signed_rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section3D should see location stamp "No. 1 Cargo Tank Port"
    And Section3D verify signature rank "<signed_rank>"
    Examples:
      | level_one_permit                | level_two_permit                            | signed_rank | created_rank |
      | Hot Work                        | Hot Work Level-2 in Designated Area         | MAS         | C/O          |
      | Hot Work                        | Hot Work Level-2 in Designated Area         | C/O         | C/O          |
      | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage) | C/O         | C/O          |
      | Rotational Portable Power Tools | Use of Portable Power Tools                 | 2/E         | 2/E          |
