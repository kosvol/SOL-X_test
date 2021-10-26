@section1
Feature: Section1 Task Description

  Scenario: Verify navigation dropdown is display on section 0
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And Section1 should see section header

  Scenario: Verify permits details are pre-filled
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Use of ODME in Manual Mode"
    Then Section1 verify permit details

  Scenario: Verify sea state dropdown input fields are correct
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Use of ODME in Manual Mode"
    Then Section1 verify dropdown for "sea states"
      | 0 : Calm (glassy)     |
      | 1 : Calm (rippled)    |
      | 2 : Smooth (wavelets) |
      | 3 : Slight            |
      | 4 : Moderate          |
      | 5 : Rough             |
      | 6 : Very Rough        |
      | 7 : High              |
      | 8 : Very High         |
      | 9 : Phenomenal        |

  Scenario: Verify wind force dropdown input fields are correct
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Use of ODME in Manual Mode"
    Then Section1 verify dropdown for "wind forces"
      | 0 : Calm             |
      | 1 : Light Air        |
      | 2 : Light Breeze     |
      | 3 : Gentle Breeze    |
      | 4 : Moderate Breeze  |
      | 5 : Fresh Breeze     |
      | 6 : Strong Breeze    |
      | 7 : Near Gale        |
      | 8 : Gale             |
      | 9 : Strong Gale      |
      | 10 : Storm           |
      | 11 : Violent Storm   |
      | 12 : Hurricane Force |

  Scenario: Verify there is no Previous button
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Use of ODME in Manual Mode"
    Then Section1 should see not see previous button

  Scenario Outline: Verify question input field exists for critical maintenance permit
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "<permit>"
    Then Section1 "should" see duration of maintenance dropdown
    Examples:
      | permit                                                                     |
      | Maintenance on Anchor                                                      |
      | Maintenance on Emergency Fire Pump                                         |
      | Maintenance on Emergency Generator                                         |
      | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      | Maintenance on Fire Detection Alarm System                                 |
      | Maintenance on Fixed Fire Fighting System                                  |
      | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      |
      | Maintenance on Life/Rescue Boats and Davits                                |
      | Maintenance on Lifeboat Engine                                             |
      | Maintenance on Magnetic Compass                                            |
      | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      |
      | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   |
      | Maintenance on Oil Discharging Monitoring Equipment                        |
      | Maintenance on Oil Mist Detector Monitoring System                         |
      | Maintenance on Oily Water Separator                                        |
      | Maintenance on P/P Room Gas Detection Alarm System                         |
      | Maintenance on Radio Battery                                               |

  Scenario Outline: Verify question input field does not exists in permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "<permit>"
    Then Section1 "should not" see duration of maintenance dropdown
    Examples:
      | permit                                                                          |
      | Enclosed Spaces Entry                                                           |
      | Helicopter Operations                                                           |
      | Personnel Transfer By Transfer Basket                                           |
      | Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces |
      | Use of ODME in Manual Mode                                                      |
      | Work on Electrical Equipment and Circuits – Low/High Voltage                    |
      | Work on Pressure Pipeline/Vessels                                               |
      | Working Aloft/Overside                                                          |
      | Working on Deck During Heavy Weather                                            |

  Scenario Outline: Verify question input field does not exists in level2 permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    Then Section1 "should not" see duration of maintenance dropdown
    Examples:
      | level_one_permit                | level_two_permit                                                        |
      | Cold Work                       | Cold Work - Cleaning Up of Spill                                        |
      | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage)                             |
      | Rotational Portable Power Tools | Use of Portable Power Tools                                             |
      | Underwater Operations           | Underwater Operations at night for mandatory drug and contraband search |

  Scenario: Verify user can fill up the form, save and proceed to next page
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    When Section1 click Save & Next
    Then Section2 should see section header

  Scenario: Verify user can fill up the form, save and proceed to next page for critical maintenance permit
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Radio Battery"
    And Section1 answer duration of maintenance over 2 hours as "Yes"
    When Section1 click Save & Next
    Then Section2 should see section header
