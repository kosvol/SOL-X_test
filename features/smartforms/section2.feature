@section2AA
Feature: Section2ApprovalAuthority
  As a ...
  I want to ...
  So that ...

  Scenario: Verify user can see previous and next button
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select a any permits
    And I submit after filling up section 1
    Then I should see section 2
    And I should see previous and next buttons
    And I tear down created form

  Scenario: Verify user can proceed to section 3a
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select a any permits
    And I submit after filling up section 1
    Then I should see section 2
    When I proceed to section 3a
    Then I should see section 3a screen
    And I tear down created form

  Scenario Outline: Verify user can see the correct approval for non-OA
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level one permit> permit
    And I select <level two permit> permit for level 2
    And I submit after filling up section 1
    Then I should see correct approval details for non-OA
    And I tear down created form

    Examples:
      | level one permit                          | level two permit                                                        |
      | Hotwork                                   | Hot Work in E/R Workshop Level-2 (Loaded & Ballast Passage)             |
      | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage)                             |
      | Enclosed Spaces Entry                     | Enclosed Space Entry                                                    |
      | Working Aloft/Overside                    | Working Aloft / Overside                                                |
      | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                             |
      | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                   |
      | Helicopter Operations                     | Helicopter Operation                                                    |
      | Rotational Portable Power Tool            | Use of Portable Power Tools                                             |
      | Rotational Portable Power Tool            | Use of Hydro blaster/working with High-pressure tools                   |
      | Work on Electrical Equipment and Circuits | Working on Electrical Equipment - Low/High Voltage                      |
      | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard |
      | Cold Work                                 | Cold Work - Cleaning Up of Spills                                       |
      | Cold Work                                 | Cold Work - Connecting and Disconnecting Pipelines                      |
      | Cold Work                                 | Working on Closed Electrical Equipment and Circuits                     |
      | Cold Work                                 | Cold Work - Maintenance Work on Machinery                               |
      | Cold Work                                 | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds   |
      | Cold Work                                 | Cold Work - Working in Hazardous or Dangerous Area                      |

  Scenario Outline: Verify approval details are accurate if maintenance on critical equipment is more than 2 hours
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level one permit> permit
    And I select <level two permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    Then I should see correct approval details for maintenance duration more than 2 hours
    And I tear down created form

    Examples:
      | level one permit               | level two permit                                                                              |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                                            |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                                            |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment                    |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                                    |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                                     |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel                         |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                                   |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                                                |
      | Critical Equipment Maintenance | Maintenance on Critical Equipment - Magnetic Compass                                          |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device                         |
      | Critical Equipment Maintenance | Maintenance on Critical Equipment - Main Propulsion System - Shutdown Alarm & Tripping Device |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                                           |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                                            |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                                           |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                                            |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                                                  |

  Scenario Outline: Verify approval details are accurate if maintenance on critical equipment is less than 2 hours
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level one permit> permit
    And I select <level two permit> permit for level 2
    And I submit after filling up section 1 with duration less than 2 hours
    Then I should see correct approval details for maintenance duration less than 2 hours
    And I tear down created form

    Examples:
      | level one permit               | level two permit                                                                              |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                                            |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                                            |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment                    |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                                    |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                                     |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel                         |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                                   |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                                                |
      | Critical Equipment Maintenance | Maintenance on Critical Equipment - Magnetic Compass                                          |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device                         |
      | Critical Equipment Maintenance | Maintenance on Critical Equipment - Main Propulsion System - Shutdown Alarm & Tripping Device |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                                           |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                                            |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                                           |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                                            |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                                                  |

  Scenario Outline: Verify user can see the correct approval authority
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level one permit> permit
    And I select <level two permit> permit for level 2
    And I submit after filling up section 1
    Then I should see correct approval details OA <office approval> and ship approval <ship approval>
    And I tear down created form

    Examples:
      | level one permit                     | level two permit                                                                | ship approval | office approval                                                 |
      | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations         | Master        | Head, Fleet Operations                                          |
      | Underwater Operations                | Simultaneous underwater operation during daytime with other operation           | Master        | Director, Fleet Operations                                      |
      | Underwater Operations                | Underwater Operation at night                                                   | Master        | Director, Fleet Operations                                      |
      | Hotwork                              | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Master        | Head, Fleet Operations                                          |
      | Hotwork                              | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Master        | Director, Fleet Operations in concurrence with Director, QAHSSE |
      | Hotwork                              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Master        | VS/MS                                                           |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            | Master        | MS/VS                                                           |
      | Use of ODME in Manual Mode           | Use of ODME in Manual Mode                                                      | Master        | Director, Fleet Operations (shore Approving Authority)          |

  Scenario: Verify ship and office approval text field is disabled
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select a any permits
    And I submit after filling up section 1
    Then I should see ship and office approval text fields disabled