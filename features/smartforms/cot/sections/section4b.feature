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


  Scenario: Verify EIC sub questions
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
