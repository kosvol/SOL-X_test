@section6
Feature: Section6
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify user can view/edit EIC certificate after selecting Yes

  # Scenario: Verify date and time is display after selecting Yes

  # Scenario: Verify master cannot sign on EIC

  # Scenario: Verify name and signature still display even after navigating back to Sign and cancel out


  Scenario Outline: Verify Gas Reader screen should be shown for these permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 6
    # Then
    And I tear down created form

    Examples:
      | level_one_permit                     | level_two_permit                                                                |
      | Hotwork                              | Hot Work in E/R Workshop Level-2 (Loaded & Ballast Passage)                     |
      | Hotwork                              | Hot Work Level-1 (Loaded & Ballast Passage)                                     |
      | Hotwork                              | Hot Work Level-2 outside E/R (Ballast Passage)                                  |
      | Hotwork                              | Hot Work Level-2 outside E/R (Loaded Passage)                                   |
      | Hotwork                              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) |
      | Enclosed Spaces Entry                | Enclosed Space Entry                                                            |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            |

  Scenario Outline: Verify non-OA ptw display submit for master approval on button
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 6
    Then I should see master approval button only
    And I tear down created form

    Examples:
      | level_one_permit                          | level_two_permit                                                        |
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
      | Working on Deck During Heavy Weather      | Working on Deck During Heavy Weather                                    |

  Scenario Outline: Verify OA ptw display submit for master review on button for maintenance duration more than 2 hours
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    And I navigate to section 6
    Then I should see master review button only
    And I tear down created form

    Examples:
      | level_one_permit               | level_two_permit                                                                              |
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

  Scenario Outline: Verify OA ptw display submit for master review on button
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 6
    Then I should see master review button only
    And I tear down created form

    Examples:
      | level_one_permit                     | level_two_permit                                                                |
      | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations         |
      | Underwater Operations                | Simultaneous underwater operation during daytime with other operation           |
      | Underwater Operations                | Underwater Operation at night                                                   |
      | Hotwork                              | Hot Work Level-2 outside E/R (Ballast Passage)                                  |
      | Hotwork                              | Hot Work Level-2 outside E/R (Loaded Passage)                                   |
      | Hotwork                              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            |
      | Use of ODME in Manual Mode           | Use of ODME in Manual Mode                                                      |