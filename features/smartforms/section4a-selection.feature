@section4AChecklistSelection
Feature: Section4AChecklistSelection
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify checklist is pre-selected for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 4a
    Then I should see correct checklist <checklist> pre-selected
    And I tear down created form

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

  Scenario Outline: Verify checklist is pre-selected for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    # And I fill up section 1 with default value
    And I navigate to section 4a
    Then I should see correct checklist <checklist> pre-selected
    And I tear down created form

    Examples:
      | level_one_permit                                              | level_two_permit                                                                | checklist                                 |
      | Hot Work                                                      | Hot Work Level-2 in Designated Area                                             | Hot Work Within Designated Area           |
      | Hot Work                                                      | Hot Work Level-1 (Loaded & Ballast Passage)                                     | Hot Work Outside Designated Area          |
      | Hot Work                                                      | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area          |
      | Hot Work                                                      | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Hot Work Outside Designated Area          |
      | Hot Work                                                      | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area          |
      | Enclosed Spaces Entry                                         | Enclosed Spaces Entry                                                           | Enclosed Space Entry Checklist            |
      | Underwater Operations                                         | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation                      |
      | Underwater Operations                                         | Simultaneous underwater operation during daytime with other operation           | Underwater Operation                      |
      | Underwater Operations                                         | Underwater Operation at night                                                   | Underwater Operation                      |
      | Working Aloft/Overside                                        | Working Aloft / Overside                                                        | Working Aloft/Overside                    |
      | Work on Pressure Pipeline/Vessels                             | Work on pressure pipelines/pressure vessels                                     | Work on Pressure Pipelines                |
      | Use of ODME in Manual Mode                                    | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode                |
      | Personnel Transfer By Transfer Basket                         | Personnel Transfer by Transfer Basket                                           | Personnel Transfer by Transfer Basket     |
      | Helicopter Operations                                         | Helicopter Operation                                                            | Helicopter Operation Checklist            |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                              | Work on Electrical Equipment and Circuits |
      | Rotational Portable Power Tools                               | Use of Portable Power Tools                                                     | Rotational Portable Power Tools (PPT)     |
      | Rotational Portable Power Tools                               | Use of Hydro blaster/working with High-pressure tools                           | Rotational Portable Power Tools (PPT)     |
      | Use of non-intrinsically safe Camera                          | Use of Non-Intrinsically Safe Camera                                            | Use of Camera Checklist                   |
      | Working on Deck During Heavy Weather                          | Working on Deck During Heavy Weather                                            | Work on Deck During Heavy Weather         |
      | Cold Work                                                     | Cold Work - Blanking/Deblanking of Pipelines and Other Openings                 | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Cleaning Up of Spill                                                | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Connecting and Disconnecting Pipelines                              | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Maintenance on Closed Electrical Equipment and Circuits             | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Maintenance Work on Machinery                                       | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds           | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Working in Hazardous or Dangerous Areas                             | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Working in Hazardous or Dangerous Areas                             | Work on Hazardous Substances              |