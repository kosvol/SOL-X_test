@section4BEIC
Feature: Section 4B: Energy Isolation Certificate

  Scenario: Verify description of work is pre-populated
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And Section1 enter Description of work "Test Automation"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    Then EIC verify Description of work "Test Automation"


  Scenario: Verify data,time and EIC number is pre-populated
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    Then EIC verify pre-filled answers


  Scenario: Verify location stamping on signature section as RA
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank | zone_id       | mac               |
      | C/O  | Z-AFT-STATION | 00:00:00:00:00:10 |
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And CommonSection click sign button
    When PinEntry enter pin for rank "C/O"
    Then SignatureLocation should see zone as "Aft Station"


  Scenario Outline: Verify location stamping on signature section for competent person
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<rank_create>"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click competent person sign button
    When PinEntry enter pin for rank "<sign_rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then EIC verify signed detail
      | rank        | location_stamp        |
      | <sign_rank> | No. 1 Cargo Tank Port |
    Examples:
      | sign_rank | rank_create |
      | C/O       | C/E         |
      | 2/E       | C/O         |
#      |   E/O    | 2/E         |

  Scenario Outline: Verify location stamping on signature section for issuing authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<rank_create>"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click issuing person sign button
    When PinEntry enter pin for rank "<sign_rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then EIC verify signed detail
      | rank        | location_stamp        |
      | <sign_rank> | No. 1 Cargo Tank Port |
    Examples:
      | sign_rank | rank_create |
      | C/E       | C/O         |


  Scenario Outline: Verify non RA cannot sign on responsible authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And CommonSection navigate to "Section 4B"
    And Section4B click sign button
    When PinEntry enter pin for rank "<sign_rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | sign_rank | level_one_permit               | level_two_permit                                                           |
      | MAS       | Hot Work                       | Hot Work Level-2 in Designated Area                                        |
      | D/C       | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      | BOS       | Cold Work                      | Cold Work - Blanking/Deblanking of Pipelines and Other Openings            |
      | A/B       | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      | 4/O       | Underwater Operations          | Underwater Operation during daytime without any simultaneous operations    |
      | PMN       | Underwater Operations          | Underwater Operations at night for mandatory drug and contraband search    |
      | OLR       | Hot Work                       | Hot Work Level-2 outside E/R (Loaded Passage)                              |


  @SOL-6981
  Scenario Outline: Verify non competent person cannot sign as competent person
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<rank>"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC should see "competent_person_sign" button "enabled"
    And EIC should see "issuing_authorized_sign" button "enabled"
    And EIC should see "save_eic" button "enabled"
    Examples:
      | rank |
      | C/O  |
      | 2/E  |
#      | ETO  |
      | C/E  |


  Scenario: Verify sub questions
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And CommonSection sleep for "2" sec
    And EIC answers yes to Method of Isolation
    Then EIC verify sub questions
      | Lock Out                                                                                 |
      | Tag Out                                                                                  |
      | Sanction to Test (High Voltage) (Checklist)                                              |
      | Switch Disconnector                                                                      |
      | Main/DB Switch Breaker                                                                   |
      | Circuit fuses                                                                            |
      | Blank Flanges/Capping                                                                    |
      | Blinding/Spading                                                                         |
      | Removal spool piece/valves                                                               |
      | Removal of Hazards                                                                       |
      | Double Block and Bleed                                                                   |
      | Disconnection of piping                                                                  |
      | Warning Tag displayed on Equipments / Power Supply / Control Unit / Valves               |
      | Relevant Departments personnel informed as applicable                                    |
      | Equipments/Valves locked and tagged                                                      |
      | Suitable tools with insulation available (Electrical Isolation)                          |
      | Voltage level checked after electrical isolation and found "zero" (Electrical Isolation) |
