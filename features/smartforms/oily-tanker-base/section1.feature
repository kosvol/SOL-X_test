@section1
Feature: Section1
  As a ...
  I want to ...
  So that ...

  Scenario: Verify navigation dropdown is display on section 0
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Use of ODME in Manual Mode permit
    And I select NA permit for level 2
    Then I should see navigation dropdown

  Scenario: Verify permits details are pre-filled
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Use of ODME in Manual Mode permit
    And I select NA permit for level 2
    Then I should see permit details are pre-filled

  Scenario: Verify sea state dropdown input fields are correct
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Use of ODME in Manual Mode permit
    And I select NA permit for level 2
    Then I should see a list of sea states
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
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Use of ODME in Manual Mode permit
    And I select NA permit for level 2
    Then I should see a list of wind forces
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
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Use of ODME in Manual Mode permit
    And I select NA permit for level 2
    Then I should not see previous button exists

  Scenario Outline: Verify question input field exists for critical maintenance permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select <permit> permit for level 2
    Then I should see maintenance duration section and require text

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
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    Then I should not see maintenance duration section and require text

    Examples:
      | level_one_permit                                             | level_two_permit                                                        |
      | Cold Work                                                    | Cold Work - Cleaning Up of Spill                                        |
      | Enclosed Spaces Entry                                        | NA                                                                      |
      | Helicopter Operations                                        | NA                                                                      |
      | Hot Work                                                     | Hot Work Level-1 (Loaded & Ballast Passage)                             |
      | Personnel Transfer By Transfer Basket                        | NA                                                                      |
      | Rotational Portable Power Tools                              | Use of Portable Power Tools                                             |
      | Underwater Operations                                        | Underwater Operations at night for mandatory drug and contraband search |
      | Use of non-intrinsically safe Camera                         | NA                                                                      |
      | Use of ODME in Manual Mode                                   | NA                                                                      |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | NA                                                                      |
      | Work on Pressure Pipeline/Vessels                            | NA                                                                      |
      | Working Aloft/Overside                                       | NA                                                                      |
      | Working on Deck During Heavy Weather                         | NA                                                                      |

  Scenario: Verify user can fill up the form, save and proceed to next page
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 2
    Then I should see section 2 screen

  Scenario: Verify user can fill up the form, save and proceed to next page for critical maintenance permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 2
    And I should not see copy text regarding maintenance hour

