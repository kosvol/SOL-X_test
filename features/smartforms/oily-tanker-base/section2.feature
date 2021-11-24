@section2
Feature: Section 2: Approving Authority

  Scenario: Verify user can see previous and next button
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    When CommonSection navigate to "Section 2"
    Then Section2 should see Previous and Next buttons

  Scenario Outline: Verify user can see the level1 permits correct approval for non-OA
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    When CommonSection navigate to "Section 2"
    Then Section2 check Approving Authority
      | ship_approval | office_approval |
      | Master        | N/A             |

    Examples:
      | level_one_permit                                             |
      | Enclosed Spaces Entry                                        |
      | Working Aloft/Overside                                       |
      | Work on Pressure Pipeline/Vessels                            |
      | Personnel Transfer By Transfer Basket                        |
      | Work on Electrical Equipment and Circuits – Low/High Voltage |
      | Working on Deck During Heavy Weather                         |
      | Helicopter Operations                                        |

  Scenario Outline: Verify user can see the level2 permits correct approval for non-OA
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    When CommonSection navigate to "Section 2"
    Then Section2 check Approving Authority
      | ship_approval | office_approval |
      | Master        | N/A             |

    Examples:
      | level_one_permit                | level_two_permit                                                      |
      | Hot Work                        | Hot Work Level-2 in Designated Area                                   |
      | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage)                           |
      | Rotational Portable Power Tools | Use of Portable Power Tools                                           |
      | Rotational Portable Power Tools | Use of Hydro blaster/working with High-pressure tools                 |
      | Cold Work                       | Cold Work - Blanking/Deblanking of Pipelines and Other Openings       |
      | Cold Work                       | Cold Work - Cleaning Up of Spill                                      |
      | Cold Work                       | Cold Work - Connecting and Disconnecting Pipelines                    |
      | Cold Work                       | Cold Work - Maintenance on Closed Electrical Equipment and Circuits   |
      | Cold Work                       | Cold Work - Maintenance Work on Machinery                             |
      | Cold Work                       | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds |
      | Cold Work                       | Cold Work - Working in Hazardous or Dangerous Areas                   |


  Scenario Outline: Verify OA is require if maintenance on critical equipment is more than 2 hours
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And Section1 answer duration of maintenance over 2 hours as "Yes"
    When CommonSection navigate to "Section 2"
    Then Section2 check Approving Authority
      | ship_approval | office_approval |
      | Master        | VS              |

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                      |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                 |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                             |
      | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      |
      | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                        |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                        |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                               |

  Scenario Outline: Verify OA is not require if maintenance on critical equipment is less than 2 hours
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And Section1 answer duration of maintenance over 2 hours as "No"
    When Section1 click Save & Next
    Then Section2 check Approving Authority
      | ship_approval | office_approval |
      | Master        | N/A             |

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                      |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                 |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                             |
      | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      |
      | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                        |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                        |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                               |

  Scenario Outline: Verify user can see the level1 permits correct approval authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    When CommonSection navigate to "Section 2"
    Then Section2 check Approving Authority
      | ship_approval | office_approval   |
      | Master        | <office_approval> |

    Examples:
      | level_one_permit                                                                | office_approval                                        |
      | Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces | MS/VS                                                  |
      | Use of ODME in Manual Mode                                                      | Director, Fleet Operations (shore Approving Authority) |


  Scenario Outline: Verify user can see the level2 permits correct approval authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    When CommonSection navigate to "Section 2"
    Then Section2 check Approving Authority
      | ship_approval | office_approval   |
      | Master        | <office_approval> |

    Examples:
      | level_one_permit      | level_two_permit                                                                | office_approval                                                 |
      | Underwater Operations | Underwater Operation during daytime without any simultaneous operations         | Head, Fleet Operations                                          |
      | Underwater Operations | Underwater Operation at night or concurrent with other operations               | Director, Fleet Operations                                      |
      | Underwater Operations | Underwater Operations at night for mandatory drug and contraband search         | Head, Fleet Operations                                          |
      | Hot Work              | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Head, Fleet Operations                                          |
      | Hot Work              | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Director, Fleet Operations in concurrence with Director, QAHSSE |
      | Hot Work              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | VS/MS                                                           |
