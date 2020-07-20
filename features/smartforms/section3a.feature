@section3ADRA
Feature: Section3ADRA
  As a ...
  I want to ...
  So that ...

  # Scenario: Initialize the clock for automation
  #   Given I launch sol-x portal
  #   When I navigate to "SmartForms" screen
  #   And I navigate to create new permit

  Scenario: Verify permit number date and time is pre-filled in section 3a
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I fill up section 1
    And I navigate to section 3a
    Then I should see DRA number,Date and Time populated
    And I tear down created form

  Scenario Outline: Verify risk matrix meets criteria for low risk
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I fill up section 1
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix
    Then I should see risk as low risk

    Examples:
      | likelihood | consequence |
      | 1          | 1           |
      | 1          | 2           |
      | 1          | 3           |
      | 1          | 4           |
      | 2          | 1           |
      | 2          | 2           |
      | 2          | 3           |
      | 3          | 1           |
      | 3          | 2           |
      | 4          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for medium risk
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I fill up section 1
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix
    Then I should see risk as medium risk

    Examples:
      | likelihood | consequence |
      | 2          | 4           |
      | 3          | 3           |
      | 1          | 5           |
      | 4          | 2           |
      | 5          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for high risk
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I fill up section 1
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix
    Then I should see risk as high risk

    Examples:
      | likelihood | consequence |
      | 2          | 5           |
      | 3          | 5           |
      | 3          | 4           |
      | 4          | 4           |
      | 4          | 3           |
      | 5          | 2           |
      | 5          | 3           |

  Scenario Outline: Verify risk matrix meets criteria for very high risk
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I fill up section 1
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix
    Then I should see risk as very high risk

    Examples:
      | likelihood | consequence |
      | 4          | 5           |
      | 5          | 5           |
      | 5          | 4           |

#   Scenario Outline: Verify DRAs page 1 likelihood,consequence and risk indicator contents match
#     Given I launch sol-x portal
#     When I navigate to "SmartForms" screen
#     And I navigate to create new permit
#     And I enter pin 1212
#     And I select <level_one_permit> permit
#     And I select <level_two_permit> permit for level 2
#     And I fill up section 1
#     And I navigate to section 3a
#     Then I should see correct likelihood,consequence and risk indicator
#     And I tear down created form

#     Examples:
#       | level_one_permit               | level_two_permit      |
#       | Critical Equipment Maintenance | Maintenance on Anchor |
# # | Critical Equipment Maintenance            | Maintenance on Emergency Fire Pump                                                            |
# # | Critical Equipment Maintenance            | Maintenance on Emergency Generator                                                            |
# # | Critical Equipment Maintenance            | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment                    |
# # | Critical Equipment Maintenance            | Maintenance on Fire Detection Alarm System                                                    |
# # | Critical Equipment Maintenance            | Maintenance on Fixed Fire Fighting System                                                     |
# # | Critical Equipment Maintenance            | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel                         |
# # | Critical Equipment Maintenance            | Maintenance on Life/Rescue Boats and Davits                                                   |
# # | Critical Equipment Maintenance            | Maintenance on Lifeboat Engine                                                                |
# # | Critical Equipment Maintenance            | Maintenance on magnetic compass                                          |
# # | Critical Equipment Maintenance            | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device                         |
# # | Critical Equipment Maintenance            | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device |
# # | Critical Equipment Maintenance            | Maintenance on Oil Discharging Monitoring Equipment                                           |
# # | Critical Equipment Maintenance            | Maintenance on Oil Mist Detector Monitoring System                                            |
# # | Critical Equipment Maintenance            | Maintenance on Oily Water Separator                                                           |
# # | Critical Equipment Maintenance            | Maintenance on P/P Room Gas Detection Alarm System                                            |
# # | Critical Equipment Maintenance            | Maintenance on Radio Battery                                                                  |
# # | Underwater Operations                     | Underwater Operation during daytime without any simultaneous operations                       |
# # | Underwater Operations                     | Simultaneous underwater operation during daytime with other operation                         |
# # | Underwater Operations                     | Underwater Operation at night                                                                 |
# # | Use of non-intrinsically safe Camera      | Use of Non-Intrinsically Safe Camera                                                          |
# # | Use of ODME in Manual Mode                | Use of ODME in Manual Mode                                                                    |
# # | Enclosed Spaces Entry                     | Enclosed Space Entry                                                                          |
# # | Working Aloft/Overside                    | Working Aloft / Overside                                                                      |
# # | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                                                   |
# # | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                                         |
# # | Helicopter Operations                     | Helicopter Operation                                                                          |
# # | Rotational Portable Power Tool            | Use of Portable Power Tools                                                                   |
# # | Rotational Portable Power Tool            | Use of Hydro blaster/working with High-pressure tools                                         |
# # | Work on Electrical Equipment and Circuits | Working on Electrical Equipment - Low/High Voltage                                            |
# # | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard                       |
# # | Cold Work                                 | Cold Work - Cleaning Up of Spills                                                             |
# # | Cold Work                                 | Cold Work - Connecting and Disconnecting Pipelines                                            |
# # | Cold Work                                 | Cold Work - Working on Closed Electrical Equipment and Circuits                                           |
# # | Cold Work                                 | Cold Work - Maintenance Work on Machinery                                                     |
# # | Cold Work                                 | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds                         |
# # | Cold Work                                 | Cold Work - Working in Hazardous or Dangerous Area                                            |
# # | Hotwork                                   | Hot Work Level-2 outside E/R (Ballast Passage)                                                |
# # | Hotwork                                   | Hot Work Level-2 outside E/R (Loaded Passage)                                                 |
# # | Hotwork                                   | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage)               |
# # | Hotwork                                   | Hot Work Level-2 in Designated Area                                   |
# # | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage)                                                   |
# # | Working on Deck During Heavy Weather      | Working on Deck During Heavy Weather                                                          |
# ### | Rigging of Pilot/Combination Ladder | Rigging of Pilot/Combination Ladder |

#   Scenario Outline: Verify DRAs page 1 consequence content match
#     Given I launch sol-x portal
#     When I navigate to "SmartForms" screen
#     And I navigate to create new permit
#     And I enter pin 1212
#     And I select <level_one_permit> permit
#     And I select <level_two_permit> permit for level 2
#     And I navigate to section 3a
#     Then I should see correct DRA page 1 consequence content
#     And I tear down created form

#     Examples:
#       | level_one_permit                          | level_two_permit                                                                              |
#       | Critical Equipment Maintenance            | Maintenance on Anchor                                                                         |
#       | Critical Equipment Maintenance            | Maintenance on Emergency Fire Pump                                                            |
#       | Critical Equipment Maintenance            | Maintenance on Emergency Generator                                                            |
#       | Critical Equipment Maintenance            | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment                    |
#       | Critical Equipment Maintenance            | Maintenance on Fire Detection Alarm System                                                    |
#       | Critical Equipment Maintenance            | Maintenance on Fixed Fire Fighting System                                                     |
#       | Critical Equipment Maintenance            | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel                         |
#       | Critical Equipment Maintenance            | Maintenance on Life/Rescue Boats and Davits                                                   |
#       | Critical Equipment Maintenance            | Maintenance on Lifeboat Engine                                                                |
#       | Critical Equipment Maintenance            | Maintenance on magnetic compass                                          |
#       | Critical Equipment Maintenance            | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device                         |
#       | Critical Equipment Maintenance            | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device |
#       | Critical Equipment Maintenance            | Maintenance on Oil Discharging Monitoring Equipment                                           |
#       | Critical Equipment Maintenance            | Maintenance on Oil Mist Detector Monitoring System                                            |
#       | Critical Equipment Maintenance            | Maintenance on Oily Water Separator                                                           |
#       | Critical Equipment Maintenance            | Maintenance on P/P Room Gas Detection Alarm System                                            |
#       | Critical Equipment Maintenance            | Maintenance on Radio Battery                                                                  |
#       | Underwater Operations                     | Underwater Operation during daytime without any simultaneous operations                       |
#       | Underwater Operations                     | Simultaneous underwater operation during daytime with other operation                         |
#       | Underwater Operations                     | Underwater Operation at night                                                                 |
#       | Use of non-intrinsically safe Camera      | Use of Non-Intrinsically Safe Camera                                                          |
#       | Use of ODME in Manual Mode                | Use of ODME in Manual Mode                                                                    |
#       | Enclosed Spaces Entry                     | Enclosed Space Entry                                                                          |
#       | Working Aloft/Overside                    | Working Aloft / Overside                                                                      |
#       | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                                                   |
#       | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                                         |
#       | Helicopter Operations                     | Helicopter Operation                                                                          |
#       | Rotational Portable Power Tool            | Use of Portable Power Tools                                                                   |
#       | Rotational Portable Power Tool            | Use of Hydro blaster/working with High-pressure tools                                         |
#       | Work on Electrical Equipment and Circuits | Working on Electrical Equipment - Low/High Voltage                                            |
#       | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard                       |
#       | Cold Work                                 | Cold Work - Cleaning Up of Spills                                                             |
#       | Cold Work                                 | Cold Work - Connecting and Disconnecting Pipelines                                            |
#       | Cold Work                                 | Cold Work - Working on Closed Electrical Equipment and Circuits                                           |
#       | Cold Work                                 | Cold Work - Maintenance Work on Machinery                                                     |
#       | Cold Work                                 | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds                         |
#       | Cold Work                                 | Cold Work - Working in Hazardous or Dangerous Area                                            |
#       | Hotwork                                   | Hot Work Level-2 outside E/R (Ballast Passage)                                                |
#       | Hotwork                                   | Hot Work Level-2 outside E/R (Loaded Passage)                                                 |
#       | Hotwork                                   | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage)               |
#       | Hotwork                                   | Hot Work Level-2 in Designated Area                                   |
#       | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage)                                                   |
#       | Working on Deck During Heavy Weather      | Working on Deck During Heavy Weather                                                          |
#   ###| Rigging of Pilot/Combination Ladder       | Rigging of Pilot/Combination Ladder                                                           |

#   Scenario Outline: Verify DRAs page 1 risk indicator content match
#     Given I launch sol-x portal
#     When I navigate to "SmartForms" screen
#     And I navigate to create new permit
#     And I enter pin 1212
#     And I select <level_one_permit> permit
#     And I select <level_two_permit> permit for level 2
#     And I navigate to section 3a
#     Then I should see correct DRA page 1 risk indicator content
#     And I tear down created form

#     Examples:
#       | level_one_permit                          | level_two_permit                                                                              |
#       | Critical Equipment Maintenance            | Maintenance on Anchor                                                                         |
#       | Critical Equipment Maintenance            | Maintenance on Emergency Fire Pump                                                            |
#       | Critical Equipment Maintenance            | Maintenance on Emergency Generator                                                            |
#       | Critical Equipment Maintenance            | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment                    |
#       | Critical Equipment Maintenance            | Maintenance on Fire Detection Alarm System                                                    |
#       | Critical Equipment Maintenance            | Maintenance on Fixed Fire Fighting System                                                     |
#       | Critical Equipment Maintenance            | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel                         |
#       | Critical Equipment Maintenance            | Maintenance on Life/Rescue Boats and Davits                                                   |
#       | Critical Equipment Maintenance            | Maintenance on Lifeboat Engine                                                                |
#       | Critical Equipment Maintenance            | Maintenance on magnetic compass                                          |
#       | Critical Equipment Maintenance            | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device                         |
#       | Critical Equipment Maintenance            | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device |
#       | Critical Equipment Maintenance            | Maintenance on Oil Discharging Monitoring Equipment                                           |
#       | Critical Equipment Maintenance            | Maintenance on Oil Mist Detector Monitoring System                                            |
#       | Critical Equipment Maintenance            | Maintenance on Oily Water Separator                                                           |
#       | Critical Equipment Maintenance            | Maintenance on P/P Room Gas Detection Alarm System                                            |
#       | Critical Equipment Maintenance            | Maintenance on Radio Battery                                                                  |
#       | Underwater Operations                     | Underwater Operation during daytime without any simultaneous operations                       |
#       | Underwater Operations                     | Simultaneous underwater operation during daytime with other operation                         |
#       | Underwater Operations                     | Underwater Operation at night                                                                 |
#       | Use of non-intrinsically safe Camera      | Use of Non-Intrinsically Safe Camera                                                          |
#       | Use of ODME in Manual Mode                | Use of ODME in Manual Mode                                                                    |
#       | Enclosed Spaces Entry                     | Enclosed Space Entry                                                                          |
#       | Working Aloft/Overside                    | Working Aloft / Overside                                                                      |
#       | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                                                   |
#       | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                                         |
#       | Helicopter Operations                     | Helicopter Operation                                                                          |
#       | Rotational Portable Power Tool            | Use of Portable Power Tools                                                                   |
#       | Rotational Portable Power Tool            | Use of Hydro blaster/working with High-pressure tools                                         |
#       | Work on Electrical Equipment and Circuits | Working on Electrical Equipment - Low/High Voltage                                            |
#       | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard                       |
#       | Cold Work                                 | Cold Work - Cleaning Up of Spills                                                             |
#       | Cold Work                                 | Cold Work - Connecting and Disconnecting Pipelines                                            |
#       | Cold Work                                 | Cold Work - Working on Closed Electrical Equipment and Circuits                                           |
#       | Cold Work                                 | Cold Work - Maintenance Work on Machinery                                                     |
#       | Cold Work                                 | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds                         |
#       | Cold Work                                 | Cold Work - Working in Hazardous or Dangerous Area                                            |
#       | Hotwork                                   | Hot Work Level-2 outside E/R (Ballast Passage)                                                |
#       | Hotwork                                   | Hot Work Level-2 outside E/R (Loaded Passage)                                                 |
#       | Hotwork                                   | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage)               |
#       | Hotwork                                   | Hot Work Level-2 in Designated Area                                   |
#       | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage)                                                   |
#       | Working on Deck During Heavy Weather      | Working on Deck During Heavy Weather                                                          |
# ### | Rigging of Pilot/Combination Ladder       | Rigging of Pilot/Combination Ladder                                                           |

# Scenario: Verify Section 3A labels match

# Scenario: Verify time is populated when navigating back from previous or next page

# Scenario: Verify add risk button

# Scenario: Verify edit risk button

# Scenario: Verify delete risk button