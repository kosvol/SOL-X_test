@section2AA
Feature: Section2ApprovalAuthority
  As a ...
  I want to ...
  So that ...

  Scenario: Verify user can see previous and next button
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 2
    Then I should see previous and next buttons

  Scenario Outline: Verify user can see the correct approval for non-OA
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 2
    Then I should see correct approval details for non-OA

    Examples:
      | level_one_permit                                             | level_two_permit                                                |
      | Hot Work                                                     | Hot Work Level-2 in Designated Area                             |
      | Hot Work                                                     | Hot Work Level-1 (Loaded & Ballast Passage)                     |
      | Enclosed Spaces Entry                                        | NA                                                              |
      | Working Aloft/Overside                                       | NA                                                              |
      | Work on Pressure Pipeline/Vessels                            | NA                                                              |
      | Personnel Transfer By Transfer Basket                        | NA                                                              |
      | Helicopter Operations                                        | Helicopter Operation                                            |
      | Rotational Portable Power Tools                              | Use of Portable Power Tools                                     |
      | Rotational Portable Power Tools                              | Use of Hydro blaster/working with High-pressure tools           |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | NA                                                              |
      | Cold Work                                                    | Cold Work - Blanking/Deblanking of Pipelines and Other Openings |
      # | Cold Work                                                    | Cold Work - Cleaning Up of Spill                                      |
      | Cold Work                                                    | Cold Work - Connecting and Disconnecting Pipelines              |
      # | Cold Work                                                    | Cold Work - Maintenance on Closed Electrical Equipment and Circuits   |
      | Cold Work                                                    | Cold Work - Maintenance Work on Machinery                       |
      # | Cold Work                                                    | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds |
      | Cold Work                                                    | Cold Work - Working in Hazardous or Dangerous Areas             |
      | Working on Deck During Heavy Weather                         | NA                                                              |

  Scenario Outline: Verify OA is require if maintenance on critical equipment is more than 2 hours
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 2
    Then I should see correct approval details for maintenance duration more than 2 hours

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      # | Critical Equipment Maintenance | Maintenance on Anchor                                                      |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         |
      # | Critical Equipment Maintenance | Maintenance on Emergency Generator                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      # | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                 |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  |
      # | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                |
      # | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                             |
      | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            |
      # | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      |
      | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   |
      # | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                        |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         |
      # | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                        |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         |
  # | Critical Equipment Maintenance | Maintenance on Radio Battery                                               |

  Scenario Outline: Verify OA is not require if maintenance on critical equipment is less than 2 hours
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill section 1 of maintenance permit with duration less than 2 hours
    And I navigate to section 2
    Then I should see correct approval details for maintenance duration less than 2 hours

    Examples:
      | level_one_permit               | level_two_permit                                                      |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                 |
      # | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                    |
      # | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                            |
      # | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel |
      # | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                        |
      # | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device |
      # | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                   |
      # | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                   |
      # | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                          |

  Scenario Outline: Verify user can see the correct approval authority
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 2
    Then I should see correct approval details OA <office approval> and ship approval <ship approval>

    Examples:
      | level_one_permit                     | level_two_permit                                                                | ship approval | office approval                                                 |
      | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations         | Master        | Head, Fleet Operations                                          |
      | Underwater Operations                | Underwater Operation at night or concurrent with other operations               | Master        | Director, Fleet Operations                                      |
      | Underwater Operations                | Underwater Operations at night for mandatory drug and contraband search         | Master        | Head, Fleet Operations                                          |
      | Hot Work                             | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Master        | Head, Fleet Operations                                          |
      | Hot Work                             | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Master        | Director, Fleet Operations in concurrence with Director, QAHSSE |
      | Hot Work                             | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Master        | VS/MS                                                           |
      | Use of non-intrinsically safe Camera | NA                                                                              | Master        | MS/VS                                                           |
      | Use of ODME in Manual Mode           | NA                                                                              | Master        | Director, Fleet Operations (shore Approving Authority)          |

  Scenario: Verify section2 screen text
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 2
    Then I should see display texts match for section2