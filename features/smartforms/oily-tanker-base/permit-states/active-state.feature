@active-permit
Feature: ActivePermit
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify Gas Tester2 should not be able to add gas reading on no CRE/PRE permit

  Scenario Outline: Verify maintenance more than 2 hours AND oa permits land at section 6 via Update Reading with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I click on pending approval filter
    And I navigate to OA link
    And I approve oa permit via oa link manually
    #And I sleep for 230 seconds
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I add gas to permit with A/M rank
    Then I should see section 6 screen

    Examples:
      | level_one_permit               | level_two_permit      |
      | Critical Equipment Maintenance | Maintenance on Anchor |

  Scenario Outline: Verify maintenance less than 2 hours AND oa permits land at section 6 via Update Reading with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work and duration less than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I add gas to permit with A/M rank
    Then I should see section 6 screen

    Examples:
      | level_one_permit               | level_two_permit                   |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump |

  Scenario Outline: Verify maintenance more than 2 hours AND oa permits land at section 8 via Submit for Termination with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I click on pending approval filter
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see section 8 screen

    Examples:
      | level_one_permit               | level_two_permit      |
      | Critical Equipment Maintenance | Maintenance on Anchor |

  Scenario Outline: Verify maintenance less than 2 hours AND oa permits land at section 8 via Submit for Termination with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work and duration less than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see section 8 screen

    Examples:
      | level_one_permit               | level_two_permit                   |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump |

  Scenario Outline: Verify non maintenance AND oa permits land at section 6 via Update Reading with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I click on pending approval filter
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I add gas to permit with A/M rank
    Then I should see section 6 screen

    Examples:
      | level_one_permit           | level_two_permit                                                                |
      | Underwater Operations      | Underwater Operation during daytime without any simultaneous operations         |
      # | Underwater Operations                | Underwater Operation at night or concurrent with other operations           |
      # | Underwater Operations                | Underwater Operations at night for mandatory drug and contraband search                                                   |
      # | Hot Work                             | Hot Work Level-2 outside E/R (Ballast Passage)                                  |
      # | Hot Work                             | Hot Work Level-2 outside E/R (Loaded Passage)                                   |
      | Hot Work                   | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) |
      # | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            |
      | Use of ODME in Manual Mode | Use of ODME in Manual Mode                                                      |

  Scenario Outline: Verify non maintenance AND oa permits land at section 8 via Submit for Termination with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see section 8 screen

    Examples:
      | level_one_permit                     | level_two_permit                                                                |
      # | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations         |
      # | Underwater Operations                | Underwater Operation at night or concurrent with other operations           |
      | Underwater Operations                | Underwater Operations at night for mandatory drug and contraband search         |
      # | Hot Work                             | Hot Work Level-2 outside E/R (Ballast Passage)                                  |
      # | Hot Work                             | Hot Work Level-2 outside E/R (Loaded Passage)                                   |
      | Hot Work                             | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                            |
  # | Use of ODME in Manual Mode           | Use of ODME in Manual Mode                                                      |

  Scenario Outline: Verify non maintenance AND non oa permits land at section 8 via Submit for Termination with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see section 8 screen

    Examples:
      | level_one_permit                     | level_two_permit                                      |
      # | Hot Work                          | Hot Work Level-2 in Designated Area                   |
      # | Hot Work                                                     | Hot Work Level-1 (Loaded & Ballast Passage)           |
      # | Enclosed Spaces Entry             | Enclosed Spaces Entry                                 |
      # | Working Aloft/Overside                                       | Working Aloft / Overside                              |
      | Work on Pressure Pipeline/Vessels    | Work on pressure pipelines/pressure vessels           |
      # | Personnel Transfer By Transfer Basket                        | Personnel Transfer by Transfer Basket                 |
      | Helicopter Operations                | Helicopter Operation                                  |
      # | Rotational Portable Power Tools                              | Use of Portable Power Tools                           |
      | Rotational Portable Power Tools      | Use of Hydro blaster/working with High-pressure tools |
      # | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage    |
      # | Cold Work                                                    | Cold Work - Blanking/Deblanking of Pipelines and Other Openings       |
      # | Cold Work                         | Cold Work - Cleaning Up of Spill                      |
      # | Cold Work                                                    | Cold Work - Connecting and Disconnecting Pipelines                    |
      # | Cold Work                                                    | Cold Work - Maintenance on Closed Electrical Equipment and Circuits   |
      # | Cold Work                                                    | Cold Work - Maintenance Work on Machinery                             |
      # | Cold Work                                                    | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds |
      # | Cold Work                                                    | Cold Work - Working in Hazardous or Dangerous Areas                   |
      | Working on Deck During Heavy Weather | Working on Deck During Heavy Weather                  |

  Scenario Outline: Verify non maintenance AND non oa permits land at section 6 via Update Reading with RA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I add gas to permit with A/M rank
    Then I should see section 6 screen


    Examples:
      | level_one_permit                      | level_two_permit                                   |
      # | Hot Work                                                     | Hot Work Level-2 in Designated Area                 |
      | Hot Work                              | Hot Work Level-1 (Loaded & Ballast Passage)        |
      # | Enclosed Spaces Entry                                        | Enclosed Spaces Entry                               |
      | Working Aloft/Overside                | Working Aloft / Overside                           |
      # | Work on Pressure Pipeline/Vessels                            | Work on pressure pipelines/pressure vessels         |
      | Personnel Transfer By Transfer Basket | Personnel Transfer by Transfer Basket              |
      # | Helicopter Operations                                        | Helicopter Operation                                |
      # | Rotational Portable Power Tools       | Use of Portable Power Tools                         |
      # | Rotational Portable Power Tools                              | Use of Hydro blaster/working with High-pressure tools |
      # | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage  |
      # | Cold Work                                                    | Cold Work - Blanking/Deblanking of Pipelines and Other Openings       |
      # | Cold Work                                                    | Cold Work - Cleaning Up of Spill                                      |
      | Cold Work                             | Cold Work - Connecting and Disconnecting Pipelines |
  # | Cold Work                                                    | Cold Work - Maintenance on Closed Electrical Equipment and Circuits   |
  # | Cold Work                                                    | Cold Work - Maintenance Work on Machinery                             |
  # | Cold Work                                                    | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds |
  # | Cold Work                             | Cold Work - Working in Hazardous or Dangerous Areas |
  # | Working on Deck During Heavy Weather  | Working on Deck During Heavy Weather                |

  Scenario: Verify section 8 buttons display are correct
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with 5/E rank
    Then I should see previous and close buttons

  Scenario: Verify section 8 Competent Person sign button is disable for read only user
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with 5/E rank
    Then I should not see competent and issuing person sign button exists

  Scenario: Verify section 8 Issuing Authority sign button is disable for read only user
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with PMAN rank
    Then I should not see competent and issuing person sign button exists

  Scenario: Verify maintenance permit issue date is display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration less than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    Then I should see issue date display

  Scenario: Verify RoL permit issue date is display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with 1 duration
    And I click on back to home
    And I click on active filter
    Then I should see issue date display

  Scenario: Verify all underwater permit only valid for 4 hours
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Underwater Operations permit
    And I select Underwater Operation at night or concurrent with other operations permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I click on pending approval filter
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    Then I should see permit valid for 4 hours

  Scenario: Verify all maintenance permit with duration less than 2 hours should have 2 hours validity
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration less than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    Then I should see permit valid for 2 hours

  Scenario: Verify all maintenance permit with duration more than 2 hours should have 8 hours validity
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I approve oa permit via oa link manually
    #And I sleep for 230 seconds
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    Then I should see permit valid for 8 hours

  Scenario Outline: Verify RoL permit validity will be based on user selection
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    Then I submit permit for Master Approval
    When I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with <duration> duration
    And I click on back to home
    And I sleep for 3 seconds
    And I click on active filter
    Then I should see permit valid for <duration> hours

    Examples:
      | duration |
      | 1        |
      # | 2        |
      # | 3        |
      | 4        |
      # | 5        |
      # | 6        |
      # | 7        |
      | 8        |

  Scenario Outline: Verify non maintenance non oa permits valid for 8 hour
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    Then I should see permit valid for 8 hours

    Examples:
      | level_one_permit                                             | level_two_permit                                   |
      | Hot Work                                                     | Hot Work Level-2 in Designated Area                |
      # | Hot Work                                                      | Hot Work Level-1 (Loaded & Ballast Passage)                             |
      # | Enclosed Spaces Entry                                         | Enclosed Spaces Entry                                                   |
      # | Working Aloft/Overside                                        | Working Aloft / Overside                                                |
      | Work on Pressure Pipeline/Vessels                            | Work on pressure pipelines/pressure vessels        |
      | Personnel Transfer By Transfer Basket                        | Personnel Transfer by Transfer Basket              |
      | Helicopter Operations                                        | Helicopter Operation                               |
      | Rotational Portable Power Tools                              | Use of Portable Power Tools                        |
      # | Rotational Portable Power Tools                               | Use of Hydro blaster/working with High-pressure tools                   |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage |
      # | Cold Work                                                     | Cold Work - Blanking/Deblanking of Pipelines and Other Openings |
      | Cold Work                                                    | Cold Work - Cleaning Up of Spill                   |
      # | Cold Work                                                     | Cold Work - Connecting and Disconnecting Pipelines                      |
      # | Cold Work                                                     | Cold Work - Maintenance on Closed Electrical Equipment and Circuits     |
      # | Cold Work                                                     | Cold Work - Maintenance Work on Machinery                               |
      # | Cold Work                                                     | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds   |
      # | Cold Work                                                     | Cold Work - Working in Hazardous or Dangerous Areas                     |
      | Working on Deck During Heavy Weather                         | Working on Deck During Heavy Weather               |

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reader is needed for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I add gas to permit with <rank> rank
    Then I should see gas reading section enabled in active state

    Examples:
      | permit_types       | permit_payload                 | rank  | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | MAS   | 1111 |
      | underwater         | submit_underwater_simultaneous | CGENG | 1393 |

  Scenario Outline: Verify AGT cannot add gas reading when permit is in active state if Gas Reader is not needed for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending office approval state and no gas reading
    And I navigate to OA link
    And I approve oa permit via oa link manually
    #And I sleep for 230 seconds
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I view permit with <rank> rank
    And I navigate to section 6
    Then I should not see gas reader sections on active permit

    Examples:
      | permit_types | permit_payload                 | rank  | pin  |
      # | intrinsical camera | submit_non_intrinsical_camera  | C/O | 3903 |
      | underwater   | submit_underwater_simultaneous | A C/O | 2761 |

  Scenario Outline: Verify non AGT cannot add gas reading when permit is in active state if Gas Reader is needed for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I approve oa permit via oa link manually
    #And I sleep for 230 seconds
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I add gas to permit with <rank> rank
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types | permit_payload                 | rank | pin  |
      | underwater   | submit_underwater_simultaneous | OLR  | 0450 |
  # | underwater   | submit_underwater_simultaneous | ETO  | 0856 |

  Scenario: Verify user is brough back to listing screen after cancelling from pinpad
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click on permit for Update Readings
    And I dismiss enter pin screen
    Then I should be navigated back to active screen

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reading is needed for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I add gas to permit with <rank> rank
    Then I should see gas reading section enabled in active state

    Examples:
      | permit_types                     | permit_payload               | rank  | pin  |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 2/O   | 6268 |
      | Enclosed Spaces Entry            | submit_enclose_space_entry   | A 2/O | 7865 |
      | Enclosed Spaces Entry            | submit_enclose_space_entry   | 3/O   | 0159 |
      | Hot Work                         | submit_hotwork               | A 3/O | 2674 |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | C/E   | 8248 |
      | Enclosed Spaces Entry            | submit_enclose_space_entry   | A C/E | 5718 |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 2/E   | 2523 |
      | Hot Work                         | submit_hotwork               | A 2/E | 3030 |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 3/E   | 4685 |
      | Hot Work                         | submit_hotwork               | A 3/E | 6727 |
      | Hot Work                         | submit_hotwork               | 4/E   | 1311 |
      | Hot Work                         | submit_hotwork               | MAS   | 1111 |
      | Hot Work                         | submit_hotwork               | A 4/E | 0703 |
      | Hot Work                         | submit_hotwork               | CGENG | 1393 |

  Scenario Outline: Verify AGT cannot add gas reading when permit is in active state if Gas Reader is not needed for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with gas reading not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I view permit with <rank> rank
    And I navigate to section 6
    Then I should not see gas reader sections on active permit

    Examples:
      | permit_types                     | permit_payload               | rank  | pin  |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | A 4/E | 0703 |
  # # | Enclosed Spaces Entry              | submit_enclose_space_entry   | A 2/O                      | 7865 |
  # | Enclosed Spaces Entry            | submit_enclose_space_entry   | 3/O    | 0159 |
  # # | Hot Work                           | submit_hotwork               | A 3/O                      | 2674 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Chief Engineer             | 8248 |
  # | Enclosed Spaces Entry            | submit_enclose_space_entry   | Additional Chief Engineer  | 5718 |
  # # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Second Engineer            | 2523 |
  # | Hot Work                         | submit_hotwork              | Additional Second Engineer | 3030 |
  # # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 3/E                        | 4685 |
  # | Hot Work                         | submit_hotwork              | A 3/E                      | 6727 |

  Scenario Outline: Verify non AGT cannot add gas reading when permit is in active state if Gas Reader is needed for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I add gas to permit with <rank> rank
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types          | permit_payload             | rank | pin  |
      | Enclosed Spaces Entry | submit_enclose_space_entry | PMAN | 4421 |
      | Hot Work              | submit_hotwork             | A/B  | 6316 |
# | Hot Work                           | submit_hotwork               | ETO   | 0856 |