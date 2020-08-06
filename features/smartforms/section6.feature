@section6
Feature: Section6
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify Gas Reader screen should be shown for these permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 6
    Then I should see gas reader sections
    And I tear down created form

    Examples:
      | level_one_permit                     | level_two_permit                                                                | checklist                        |
      | Hotwork                              | Hot Work Level-2 in Designated Area                                             | Hot Work Within Designated Area  |
      | Hotwork                              | Hot Work Level-1 (Loaded & Ballast Passage)                                     | Hot Work Outside Designated Area |
      | Hotwork                              | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area |
      | Hotwork                              | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Hot Work Outside Designated Area |
      | Hotwork                              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area |
      | Enclosed Spaces Entry                | Enclosed Space Entry                                                            | Enclosed Space Entry Checklist   |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            | Use of Camera Checklist          |

  # PRE gas reader

  # Scenario: Verify user is able to save Gas Reading contents with toxic gas

  Scenario Outline: Verify Gas Reader screen should not be shown for these permits by default
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    Then I should not see gas reader sections
    And I tear down created form

    Examples:
      | level_one_permit                                              | level_two_permit                                                      | checklist                                                     |
      | Working Aloft/Overside                                        | Working Aloft / Overside                                              | Working Aloft/Overside                                        |
      | Work on Pressure Pipeline/Vessels                             | Work on pressure pipelines/pressure vessels                           | Work on Pressure Pipelines                                    |
      | Personal Transfer By Transfer Basket                          | Personnel Transfer by Transfer Basket                                 | Personnel Transfer by Transfer Basket                         |
      | Helicopter Operations                                         | Helicopter Operation                                                  | Helicopter Operation Checklist                                |
      | Rotational Portable Power Tool                                | Use of Portable Power Tools                                           | Rotational Portable Power Tools (PPT)                         |
      # | Rotational Portable Power Tool            | Use of Hydro blaster/working with High-pressure tools                   | Rotational Portable Power Tools (PPT)     |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                    | Work on Electrical Equipment and Circuits – Low/High Voltage |
      # | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard | Cold Work Operation Checklist             |
      # | Cold Work                                 | Cold Work - Cleaning Up of Spill                                       | Cold Work Operation Checklist             |
      # | Cold Work                                 | Cold Work - Connecting and Disconnecting Pipelines                      | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Working on Closed Electrical Equipment and Circuits       | Cold Work Operation Checklist                                 |
      | Cold Work                                                     | Cold Work - Maintenance Work on Machinery                             | Cold Work Operation Checklist                                 |
      # | Cold Work                                 | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds   | Cold Work Operation Checklist             |
      # | Cold Work                                 | Cold Work - Working in Hazardous or Dangerous Area                      | Cold Work Operation Checklist             |
      | Working on Deck During Heavy Weather                          | Working on Deck During Heavy Weather                                  | Work on Deck During Heavy Weather                             |
      # | Underwater Operations                     | Underwater Operation during daytime without any simultaneous operations | Underwater Operation                      |
      | Underwater Operations                                         | Simultaneous underwater operation during daytime with other operation | Underwater Operation                                          |
      # | Underwater Operations                     | Underwater Operation at night                                           | Underwater Operation                      |
      | Use of ODME in Manual Mode                                    | Use of ODME in Manual Mode                                            | Use of ODME in Manual Mode                                    |

  Scenario Outline: Verify Gas Reader screen should not be shown for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration less than 2 hours
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 4 times
    Then I should not see gas reader sections
    And I tear down created form

    Examples:
      | level_one_permit               | level_two_permit                   | checklist                                |
      | Critical Equipment Maintenance | Maintenance on Anchor              | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Emergency Generator                                         | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                 | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                             | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                        | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                        | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Radio Battery                                               | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify non-OA ptw display submit for master approval on button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 4 times
    Then I should see master approval button only
    And I tear down created form

    Examples:
      | level_one_permit                                              | level_two_permit                                                | checklist                                                     |
      | Hotwork                                                       | Hot Work Level-2 in Designated Area                             | Hot Work Within Designated Area                               |
      | Hotwork                                                       | Hot Work Level-1 (Loaded & Ballast Passage)                     | Hot Work Outside Designated Area                              |
      | Enclosed Spaces Entry                                         | Enclosed Space Entry                                            | Enclosed Space Entry Checklist                                |
      | Working Aloft/Overside                                        | Working Aloft / Overside                                        | Working Aloft/Overside                                        |
      | Work on Pressure Pipeline/Vessels                             | Work on pressure pipelines/pressure vessels                     | Work on Pressure Pipelines                                    |
      | Personal Transfer By Transfer Basket                          | Personnel Transfer by Transfer Basket                           | Personnel Transfer by Transfer Basket                         |
      | Helicopter Operations                                         | Helicopter Operation                                            | Helicopter Operation Checklist                                |
      | Rotational Portable Power Tool                                | Use of Portable Power Tools                                     | Rotational Portable Power Tools (PPT)                         |
      # | Rotational Portable Power Tool            | Use of Hydro blaster/working with High-pressure tools | Rotational Portable Power Tools (PPT)     |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage              | Work on Electrical Equipment and Circuits – Low/High Voltage |
      # | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard | Cold Work Operation Checklist             |
      # | Cold Work                                 | Cold Work - Cleaning Up of Spill                                       | Cold Work Operation Checklist             |
      | Cold Work                                                     | Cold Work - Connecting and Disconnecting Pipelines              | Cold Work Operation Checklist                                 |
      | Cold Work                                                     | Cold Work - Working on Closed Electrical Equipment and Circuits | Cold Work Operation Checklist                                 |
      # | Cold Work                                 | Cold Work - Maintenance Work on Machinery                               | Cold Work Operation Checklist             |
      # | Cold Work                                 | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds   | Cold Work Operation Checklist             |
      # | Cold Work                                 | Cold Work - Working in Hazardous or Dangerous Area                      | Cold Work Operation Checklist             |
      | Working on Deck During Heavy Weather                          | Working on Deck During Heavy Weather                            | Work on Deck During Heavy Weather                             |

  Scenario Outline: Verify OA ptw display submit for master review on button for maintenance duration more than 2 hours
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 4 times
    Then I should see master review button only
    And I tear down created form

    Examples:
      | level_one_permit               | level_two_permit                | checklist                                |
      # | Critical Equipment Maintenance | Maintenance on Anchor                                                      | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Emergency Generator                                         | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                 | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine  | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Magnetic Compass | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                        | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                        | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         | Critical Equipment Maintenance Checklist |
  # | Critical Equipment Maintenance | Maintenance on Radio Battery                                               | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify OA ptw display submit for master review on button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 4 times
    Then I should see master review button only
    And I tear down created form

    Examples:
      | level_one_permit                     | level_two_permit                                                                | checklist                        |
      # | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation             |
      # | Underwater Operations                | Simultaneous underwater operation during daytime with other operation           | Underwater Operation             |
      | Underwater Operations                | Underwater Operation at night                                                   | Underwater Operation             |
      # | Hotwork                              | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area |
      # | Hotwork                              | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Hot Work Outside Designated Area |
      | Hotwork                              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            | Use of Camera Checklist          |
      | Use of ODME in Manual Mode           | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode       |