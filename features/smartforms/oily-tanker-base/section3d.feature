@section3d
Feature: Section3DDRA

  @www
  Scenario: Verify wearable can be picked up consistently
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank | zone_id       | mac               |
      | C/O  | Z-AFT-STATION | 00:00:00:00:00:10 |
#    And SmartForms open page
#    And SmartForms click create permit to work
#    And PinEntry enter pin for rank "C/O"
#    And FormPrelude select level1 "Hot Work"
#    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
#    And CommonSection navigate to "Section 3D"
#    And CommonSection click sign button
#    And PinEntry enter pin for rank "C/O"
#    And SignatureLocation should see zone as "Aft Station"


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


  Scenario Outline: Verify only DRA signoff can sign on section 3d for level2 non maintenance permits
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


  Scenario Outline: Verify only DRA signoff can sign on section 3d for level1 non maintenance permits
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<created_rank>"
    And FormPrelude select level1 "<level_one_permit>"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<signed_rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section3D should see location stamp "No. 1 Cargo Tank Port"
    And Section3D verify signature rank "<signed_rank>"
    Examples:
      | level_one_permit                      | signed_rank | created_rank |
#      | Enclosed Spaces Entry                                        | A C/O       | A C/O        |
      | Working Aloft/Overside                | 2/O         | 2/O          |
#      | Work on Pressure Pipeline/Vessels                            | A 2/O       | A 2/O        |
      | Personnel Transfer By Transfer Basket | C/E         | C/E          |
#      | Helicopter Operations                                        | A C/E       | A C/E        |
#      | Work on Electrical Equipment and Circuits – Low/High Voltage | A 2/E       | A 2/E        |
      | Working on Deck During Heavy Weather  | 3/O         | 3/O          |
#      | Working on Deck During Heavy Weather                         | A 3/O       | A 3/O        |
      | Working on Deck During Heavy Weather  | 3/E         | C/O          |
#      | Working on Deck During Heavy Weather                         | A 3/E       | C/O          |
      | Working on Deck During Heavy Weather  | 4/E         | C/O          |
#      | Working on Deck During Heavy Weather                         | A 4/E       | C/O          |

  Scenario Outline: Verify non RA cannot sign on section 3d for non maintenance permits
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<non_ra_rank>"
    And PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | level_one_permit                      | non_ra_rank |
      | Work on Pressure Pipeline/Vessels     | D/C         |
      | Personnel Transfer By Transfer Basket | 4/O         |
      | Helicopter Operations                 | ETR         |
      | Helicopter Operations                 | ELC         |
      | Helicopter Operations                 | PMN         |
