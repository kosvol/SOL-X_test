@section4AChecklistSelection
Feature: Section 4A: Safety Checklist selection

  Scenario: Verify checklist display are correct to vessel type
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    When CommonSection navigate to "Section 4A"
    Then Section4A verify checklist
      | Cold Work Operation Checklist             |
      | Critical Equipment Maintenance Checklist  |
      | Enclosed Space Entry Checklist            |
      | Helicopter Operation Checklist            |
      | Hot Work Outside Designated Area          |
      | Hot Work Within Designated Area           |
      | Personnel Transfer by Transfer Basket     |
      | Pump Room Entry Checklist                 |
      | Rotational Portable Power Tools (PPT)     |
      | Underwater Operation                      |
      | Use of Camera Checklist                   |
      | Use of ODME in Manual Mode                |
      | Work on Deck During Heavy Weather         |
      | Work on Electrical Equipment and Circuits |
      | Work on Hazardous Substances              |
      | Work on Pressure Pipelines                |
      | Working Aloft/Overside                    |


  Scenario Outline: Verify checklist is pre-selected for maintenance permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    When CommonSection navigate to "Section 4A"
    Then Section4A verify pre-selected checklist "<checklist>"
    Examples:
      | level_one_permit               | level_two_permit                                                           | checklist                                |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                      | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                 | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                             | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                        | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                        | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                               | Critical Equipment Maintenance Checklist |


  Scenario Outline: Verify checklist is pre-selected for non maintenance level2 permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    When CommonSection navigate to "Section 4A"
    Then Section4A verify pre-selected checklist "<checklist>"
    Examples:
      | level_one_permit                | level_two_permit                                                                | checklist                             |
      | Hot Work                        | Hot Work Level-2 in Designated Area                                             | Hot Work Within Designated Area       |
      | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage)                                     | Hot Work Outside Designated Area      |
      | Hot Work                        | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area      |
      | Hot Work                        | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Hot Work Outside Designated Area      |
      | Hot Work                        | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area      |
      | Underwater Operations           | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation                  |
      | Underwater Operations           | Underwater Operation at night or concurrent with other operations               | Underwater Operation                  |
      | Underwater Operations           | Underwater Operations at night for mandatory drug and contraband search         | Underwater Operation                  |
      | Rotational Portable Power Tools | Use of Portable Power Tools                                                     | Rotational Portable Power Tools (PPT) |
      | Rotational Portable Power Tools | Use of Hydro blaster/working with High-pressure tools                           | Rotational Portable Power Tools (PPT) |
      | Cold Work                       | Cold Work - Blanking/Deblanking of Pipelines and Other Openings                 | Cold Work Operation Checklist         |
      | Cold Work                       | Cold Work - Cleaning Up of Spill                                                | Cold Work Operation Checklist         |
      | Cold Work                       | Cold Work - Connecting and Disconnecting Pipelines                              | Cold Work Operation Checklist         |
      | Cold Work                       | Cold Work - Maintenance on Closed Electrical Equipment and Circuits             | Cold Work Operation Checklist         |
      | Cold Work                       | Cold Work - Maintenance Work on Machinery                                       | Cold Work Operation Checklist         |
      | Cold Work                       | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds           | Cold Work Operation Checklist         |
      | Cold Work                       | Cold Work - Working in Hazardous or Dangerous Areas                             | Cold Work Operation Checklist         |
      | Cold Work                       | Cold Work - Working in Hazardous or Dangerous Areas                             | Work on Hazardous Substances          |


  Scenario Outline: Verify checklist is pre-selected for non maintenance level1 permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    When CommonSection navigate to "Section 4A"
    Then Section4A verify pre-selected checklist "<checklist>"
    Examples:
      | level_one_permit                                                                | checklist                                 |
      | Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces | Use of Camera Checklist                   |
      | Working on Deck During Heavy Weather                                            | Work on Deck During Heavy Weather         |
      | Enclosed Spaces Entry                                                           | Enclosed Space Entry Checklist            |
      | Working Aloft/Overside                                                          | Working Aloft/Overside                    |
      | Work on Pressure Pipeline/Vessels                                               | Work on Pressure Pipelines                |
      | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode                |
      | Personnel Transfer By Transfer Basket                                           | Personnel Transfer by Transfer Basket     |
      | Helicopter Operations                                                           | Helicopter Operation Checklist            |
      | Work on Electrical Equipment and Circuits – Low/High Voltage                    | Work on Electrical Equipment and Circuits |
