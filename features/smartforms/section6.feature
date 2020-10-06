@section6
Feature: Section6
  As a ...
  I want to ...
  So that ...

  Scenario: Verify gas reading don't get cleared after cancel from signing
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings and cancel from pin screen
    Then I should see gas reading still exists
    And I tear down created form

  Scenario: Verify gas reading dead flow not exists
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings and back from signing screen
    Then I should be able to continue to next page
    And I tear down created form

  Scenario: Verify user can add gas reading
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings
    And I will see popup dialog
    Then I should see gas reading display with toxic gas
    And I tear down created form

  Scenario: Verify user can delete added toxic gas
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I am able to delete toxic gas inputs
    And I tear down created form

  Scenario: Verify new gas reading without the initial tosic gas will show '-' on the row
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings
    And I will see popup dialog
    Then I should see gas reading display with toxic gas
    And I add only normal gas readings
    And I will see popup dialog
    Then I should see gas reading display without toxic gas
    And I tear down created form

  Scenario Outline: Verify non-OA ptw display submit for master approval on button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 6
    Then I should see master approval button only
    And I tear down created form

    Examples:
      | level_one_permit                                              | level_two_permit                                                | checklist                                                     |
      | Hot Work                                                      | Hot Work Level-2 in Designated Area                             | Hot Work Within Designated Area                               |
      | Hot Work                                                      | Hot Work Level-1 (Loaded & Ballast Passage)                     | Hot Work Outside Designated Area                              |
      | Enclosed Spaces Entry                                         | Enclosed Spaces Entry                                           | Enclosed Space Entry Checklist                                |
      | Working Aloft/Overside                                        | Working Aloft / Overside                                        | Working Aloft/Overside                                        |
      | Work on Pressure Pipeline/Vessels                             | Work on pressure pipelines/pressure vessels                     | Work on Pressure Pipelines                                    |
      | Personnel Transfer By Transfer Basket                         | Personnel Transfer by Transfer Basket                           | Personnel Transfer by Transfer Basket                         |
      | Helicopter Operations                                         | Helicopter Operation                                            | Helicopter Operation Checklist                                |
      # | Rotational Portable Power Tools      | Use of Portable Power Tools                 | Rotational Portable Power Tools (PPT) |
      | Rotational Portable Power Tools                               | Use of Hydro blaster/working with High-pressure tools           | Rotational Portable Power Tools (PPT)                         |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage              | Work on Electrical Equipment and Circuits – Low/High Voltage |
      | Cold Work                                                     | Cold Work - Blanking/Deblanking of Pipelines and Other Openings | Cold Work Operation Checklist                                 |
      # | Cold Work                            | Cold Work - Cleaning Up of Spill            | Cold Work Operation Checklist          |
      # | Cold Work                                                     | Cold Work - Connecting and Disconnecting Pipelines                      | Cold Work Operation Checklist                                 |
      # | Cold Work                                                     | Cold Work - Maintenance on Closed Electrical Equipment and Circuits     | Cold Work Operation Checklist                                 |
      # | Cold Work                                                     | Cold Work - Maintenance Work on Machinery                               | Cold Work Operation Checklist                                 |
      # | Cold Work                                                     | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds   | Cold Work Operation Checklist                                 |
      | Working on Deck During Heavy Weather                          | Working on Deck During Heavy Weather                            | Work on Deck During Heavy Weather                             |

  Scenario: Verify Cold Work - Working in Hazardous or Dangerous Areas have two checklist selected
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Cold Work permit
    And I select Cold Work - Working in Hazardous or Dangerous Areas permit for level 2
    And I navigate to section 4a
    Then I should see correct checklist Cold Work Operation Checklist pre-selected
    And I should see correct checklist Work on Hazardous Substances pre-selected
    And I tear down created form

  Scenario Outline: Verify OA ptw display submit for master review on button for maintenance duration more than 2 hours
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 6
    Then I should see master review button only
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

  Scenario Outline: Verify OA ptw display submit for master review on button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 6
    Then I should see master review button only
    And I tear down created form

    Examples:
      | level_one_permit                     | level_two_permit                                                                | checklist                        |
      | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation             |
      | Underwater Operations                | Simultaneous underwater operation during daytime with other operation           | Underwater Operation             |
      | Underwater Operations                | Underwater Operation at night                                                   | Underwater Operation             |
      | Hot Work                             | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area |
      | Hot Work                             | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Hot Work Outside Designated Area |
      | Hot Work                             | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            | Use of Camera Checklist          |
      | Use of ODME in Manual Mode           | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode       |

  Scenario Outline: Verify gas reading can disable and enable
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 6
    And  I press the N/A button to disable gas testing
    Then I should see warning label
    And  I should not see gas_equipment_input
    And  I should not see gas_sr_number_input
    And  I should not see gas_last_calibration_button
    And I press the Yes button to enable gas testing
    Then I should not see warning label
    And  I should see gas_equipment_input
    And  I should see gas_sr_number_input
    And  I should see gas_last_calibration_button
    And I tear down created form

    Examples:
      | level_one_permit      | level_two_permit     |
      | Helicopter Operations | Helicopter Operation |