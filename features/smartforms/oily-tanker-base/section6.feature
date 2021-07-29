@section6
Feature: Section6
  As a ...
  I want to ...
  So that ...

  Scenario: Verify incomplete fields warning message displays
    Given I change ship local time to +8 GMT
    When I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I fill zone details
    And I navigate to section 3c
    And I uncheck dra member
    And I press next for 6 times
    Then I should see incomplete fields warning message display
    And I should see incomplete signature field warning message display

  Scenario: Verify copy text display when gas selection is yes
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    Then I should see gas reading copy text

  Scenario: Verify submit button is disable before compulsory fields filled
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    Then I should see submit button disabled

  Scenario: Verify gas reading don't get cleared after cancel from signing
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings and cancel from pin screen
    Then I should see gas reading still exists

  Scenario: Verify gas reading dead flow not exists
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings and back from signing screen
    Then I should be able to continue to next page

  Scenario: Verify user can delete added toxic gas
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I am able to delete toxic gas inputs

  Scenario Outline: Verify non AGT cannot add gas readings
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings
    And I enter pin for rank <rank>
    Then I should see not authorize error message

    Examples:
      | rank  | pin  |
      | A/B   | 6316 |
      | 4/O   | 2637 |
      | A 4/O | 5574 |
      | BOS   | 1018 |

  Scenario Outline: Verify AGT can add gas readings
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I fill only location of work
    And I navigate to section 4a
    And I press next for 1 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I press the Yes button to enable gas testing
    And I add all gas readings
    And I enter pin for rank <rank>
    And I set time
    Then I will see popup dialog with <rank_name> crew rank and name
    When I dismiss gas reader dialog box
    Then I should see gas reading display with toxic gas and <rank_name> rank and name
    And I should see submit button enabled

    Examples:
      | rank  | pin  | rank_name       |
      | MAS   | 1111 | MAS COT MAS     |
      # | Additional Master          | 9015 | By A/M Atif Hayat       |
      # | Chief Officer              | 8383 | By C/O Alister Leong    |
      # | Additional Chief  Officer  | 2761 | By A C/O Nigel Koh      |
      | 2/O   | 6268 | 2/O COT 2/O     |
      # | Additional Second Officer  | 7865 | By A 2/O Qasim Khan     |
      # | Third Officer              | 0159 | By 3/O Tim Kinzer       |
      | A 3/O | 2674 | A 3/O COT A 3/O |
      # | Chief Engineer             | 8248 | By C/E Alex Pisarev     |
      | A C/E | 5718 | A C/E COT A C/E |
      # | Second Engineer            | 2523 | By 2/E Poon Choryi      |
      | A 2/E | 3030 | A 2/E COT A 2/E |
      # | Third Engineer             | 4685 | By 3/E Cs Ow            |
      | A 3/E | 6727 | A 3/E COT A 3/E |
      | A 4/E | 1311 | 4/E COT 4/E     |
      | CGENG | 1311 | CGENG COT CGENG |

  Scenario: Verify new gas reading without the initial toxic gas will show '-' on the row
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Helicopter Operations permit
    And I select Helicopter Operations permit for level 2
    And I navigate to section 6
    And I press the Yes button to enable gas testing
    And I add all gas readings
    And I enter pin for rank A/M
    And I set time
    Then I will see popup dialog with By A/M COT A/M crew rank and name
    When I dismiss gas reader dialog box
    Then I should see gas reading display with toxic gas and By A/M COT A/M rank and name
    And I add only normal gas readings
    And I enter pin for rank A/M
    And I set time
    Then I will see popup dialog with By A/M COT A/M crew rank and name
    When I dismiss gas reader dialog box
    Then I should see gas reading display without toxic gas and By A/M COT A/M rank and name

  # Scenario Outline: Verify non-OA Hotwork ptw display submit for master approval on button
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin for rank A/M
  #   And I select <level_one_permit> permit
  #   And I select <level_two_permit> permit for level 2
  #   And I navigate to section 6
  #   Then I should see master approval button only
  #   And I should not see extra previous and save button

  #   Examples:
  #     | level_one_permit | level_two_permit                    | checklist                       |
  #     | Hot Work         | Hot Work Level-2 in Designated Area | Hot Work Within Designated Area |

  Scenario Outline: Verify non-OA ptw display submit for master approval on button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 6
    Then I should see master approval button only

    Examples:
      | level_one_permit                                             | level_two_permit                                                | checklist                                                    |
      | Hot Work                                                     | Hot Work Level-2 in Designated Area                             | Hot Work Within Designated Area                              |
      | Hot Work                                                     | Hot Work Level-1 (Loaded & Ballast Passage)                     | Hot Work Outside Designated Area                             |
      | Enclosed Spaces Entry                                        | Enclosed Spaces Entry                                           | Enclosed Space Entry Checklist                               |
      | Working Aloft/Overside                                       | Working Aloft / Overside                                        | Working Aloft/Overside                                       |
      | Work on Pressure Pipeline/Vessels                            | Work on pressure pipelines/pressure vessels                     | Work on Pressure Pipelines                                   |
      | Personnel Transfer By Transfer Basket                        | Personnel Transfer by Transfer Basket                           | Personnel Transfer by Transfer Basket                        |
      | Helicopter Operations                                        | Helicopter Operation                                            | Helicopter Operation Checklist                               |
      # | Rotational Portable Power Tools      | Use of Portable Power Tools                 | Rotational Portable Power Tools (PPT) |
      | Rotational Portable Power Tools                              | Use of Hydro blaster/working with High-pressure tools           | Rotational Portable Power Tools (PPT)                        |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage              | Work on Electrical Equipment and Circuits – Low/High Voltage |
      | Cold Work                                                    | Cold Work - Blanking/Deblanking of Pipelines and Other Openings | Cold Work Operation Checklist                                |
      # | Cold Work                            | Cold Work - Cleaning Up of Spill            | Cold Work Operation Checklist          |
      # | Cold Work                                                     | Cold Work - Connecting and Disconnecting Pipelines                      | Cold Work Operation Checklist                                 |
      # | Cold Work                                                     | Cold Work - Maintenance on Closed Electrical Equipment and Circuits     | Cold Work Operation Checklist                                 |
      # | Cold Work                                                     | Cold Work - Maintenance Work on Machinery                               | Cold Work Operation Checklist                                 |
      # | Cold Work                                                     | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds   | Cold Work Operation Checklist                                 |
      | Working on Deck During Heavy Weather                         | Working on Deck During Heavy Weather                            | Work on Deck During Heavy Weather                            |

  Scenario: Verify Cold Work - Working in Hazardous or Dangerous Areas have two checklist selected
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Cold Work permit
    And I select Cold Work - Working in Hazardous or Dangerous Areas permit for level 2
    And I navigate to section 4a
    And I sleep for 1 seconds
    Then I should see correct checklist Cold Work Operation Checklist pre-selected
    And I should see correct checklist Work on Hazardous Substances pre-selected

  Scenario Outline: Verify OA ptw display submit for master review on button for maintenance duration more than 2 hours
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I navigate to section 6
    Then I should see master review button only

    Examples:
      | level_one_permit               | level_two_permit                                                      | checklist                                |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                 | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                    | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                            | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                        | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                   | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                   | Critical Equipment Maintenance Checklist |
      # | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                          | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify OA ptw display submit for master review on button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 6
    Then I should see master review button only
    And I should not see extra previous and save button

    Examples:
      | level_one_permit                     | level_two_permit                                                        | checklist                        |
      | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations | Underwater Operation             |
      # | Underwater Operations                | Underwater Operation at night or concurrent with other operations           | Underwater Operation             |
      | Underwater Operations                | Underwater Operations at night for mandatory drug and contraband search | Underwater Operation             |
      # | Hot Work                             | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area |
      | Hot Work                             | Hot Work Level-2 outside E/R (Loaded Passage)                           | Hot Work Outside Designated Area |
      # | Hot Work                             | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                    | Use of Camera Checklist          |
  # | Use of ODME in Manual Mode           | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode       |

  Scenario Outline: Verify gas reading can disable and enable
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work
    And I navigate to section 4a
    And I press next for 1 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I press the N/A button to disable gas testing
    Then I should see warning label
    And I should not see gas_equipment_input
    And I should not see gas_sr_number_input
    And I should not see gas_last_calibration_button
    And I press the Yes button to enable gas testing
    Then I should not see warning label
    And I should see gas_equipment_input
    And I should see gas_sr_number_input
    And I should see gas_last_calibration_button

    Examples:
      | level_one_permit      | level_two_permit     |
      | Helicopter Operations | Helicopter Operation |