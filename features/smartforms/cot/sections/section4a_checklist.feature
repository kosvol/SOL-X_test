@section4a_checklist
Feature: Section 4A: Safety Checklist

  Scenario Outline: Verify checklist questions in level1 permits
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level1_permit>"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist questions "<checklist>"
    Examples:
      | level1_permit                                                                   | checklist                                 |
      | Enclosed Space Entry                                                            | Enclosed Spaces Entry                     |
      | Working Aloft / Overside                                                        | Working Aloft Overside                    |
      | Work on Pressure Pipeline/Vessels                                               | Work on Pressure Pipelines                |
      | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode                |
      | Personnel Transfer by Transfer Basket                                           | Personnel Transfer by Transfer Basket     |
      | Helicopter Operation                                                            | Helicopter Operation                      |
      | Work on Electrical Equipment and Circuits                                       | Work on Electrical Equipment and Circuits |
      | Working on Deck During Heavy Weather                                            | Work on Deck During Heavy Weather         |
      | Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces | Use of Camera                             |


  Scenario Outline: Verify checklist questions in level2 permits
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level1_permit>"
    And FormPrelude select level2 "<level2_permit>"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist questions "<checklist>"
    Examples:
      | level1_permit                   | level2_permit                                                           | checklist                             |
      | Hot Work                        | Hot Work Level-2 outside E/R (Ballast Passage)                          | Hot Work Outside Designated Area      |
      | Hot Work                        | Hot Work Level-2 in Designated Area                                     | Hot Work Within Designated Area       |
      | Underwater Operations           | Underwater Operation during daytime without any simultaneous operations | Underwater Operation                  |
      | Rotational Portable Power Tools | Use of Hydro blaster/working with High-pressure tools                   | Rotational Portable Power Tools (PPT) |
      | Critical Equipment Maintenance  | Maintenance on Anchor                                                   | Critical Equipment Maintenance        |
      | Cold Work                       | Cold Work - Cleaning Up of Spill                                        | Cold Work Operation                   |

  Scenario: Verify Working in Hazardous or Dangerous Area questions
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Cold Work"
    And FormPrelude select level2 "Cold Work - Working in Hazardous or Dangerous Areas"
    When CommonSection navigate to "Section 4A"
    And Section4A uncheck all checklist
    And Section4A select checklist "work_on_hazard_our_substances"
    And CommonSection click Save & Next
    And CommonSection sleep for "2" sec
    Then Checklist verify checklist questions "Work on Hazardous Substances"


  Scenario: Verify Enclosed Space Entry checklist boxes
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist box
      | checklist             | box_type |
      | Enclosed Spaces Entry | info_box |
    Then Checklist verify checklist box
      | checklist             | box_type    |
      | Enclosed Spaces Entry | warning_box |


  Scenario: Verify Hot Work Outside Designated Area checklist info box
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 outside E/R (Ballast Passage)"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist box
      | checklist                        | box_type |
      | Hot Work Outside Designated Area | info_box |


  Scenario: Verify Use of ODME in Manual Mode checklist warning box
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist box
      | checklist                  | box_type    |
      | Use of ODME in Manual Mode | warning_box |


  Scenario: Verify Work on Deck During Heavy Weather checklist heavy weather note box
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Working on Deck During Heavy Weather"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist box
      | checklist                         | box_type               |
      | Work on Deck During Heavy Weather | heavy_weather_note_box |


  Scenario: Verify Use of ODME in Manual Mode checklist warning box
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist box
      | checklist                       | box_type    |
      | Hot Work Within Designated Area | warning_box |


  Scenario: Verify checklist creator signature can be signed on checklist for maintenance permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    And Section1 answer duration of maintenance over 2 hours as "Yes"
    And CommonSection navigate to "Section 4A"
    And CommonSection sleep for "2" sec
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "2/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Checklist should see location stamp "No. 1 Cargo Tank Port"
    And Checklist verify signature rank "2/O"


  Scenario: Verify non checklist creator signature cannot signed on checklist for maintenance permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    And Section1 answer duration of maintenance over 2 hours as "Yes"
    And CommonSection navigate to "Section 4A"
    And CommonSection sleep for "2" sec
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "MAS"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"


  Scenario Outline: Verify checklist form is pre-populated with PTW permit number, data and time for non maintenance permit
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    Then Checklist verify checklist answer
    Examples:
      | level_one_permit                      |
      | Working Aloft / Overside              |
      | Work on Pressure Pipeline/Vessels     |
      | Use of ODME in Manual Mode            |
      | Personnel Transfer by Transfer Basket |
      | Helicopter Operation                  |
      | Use of non-intrinsically safe Camera  |
      | Working on Deck During Heavy Weather  |


  Scenario Outline: Verify checklist form is pre-populated with PTW permit number, data and time for maintenance permit
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And Section1 answer duration of maintenance over 2 hours as "Yes"
    And CommonSection navigate to "Section 4A"
    And CommonSection sleep for "2" sec
    And CommonSection click Save & Next
    Then Checklist verify checklist answer
    Examples:
      | level_one_permit               | level_two_permit             |
      | Critical Equipment Maintenance | Maintenance on Anchor        |
      | Critical Equipment Maintenance | Maintenance on Radio Battery |