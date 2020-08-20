@active-permit
Feature: ActivePermit
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify user land on section 6 after clicking on Update Reader on active permit
  # Scenario: Verify in view mode all section is disabled

  Scenario: Verify maintenance permit issue date is display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I submit after filling up section 1 with duration less than 2 hours
    When I press next for 9 times
    Then I submit permit for Master Approval
    When I click on back to home
    And I click on pending approval filter
    And I approve maintenance permit
    When I click on back to home
    And I click on active filter
    Then I should see issue date display

  Scenario: Verify RoL permit issue date is display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    # And I fill ROL permit
    And I press next from section 1
    Then I submit permit for Master Approval
    When I click on back to home
    And I set rol permit to active state with 1 duration
    And I click on active filter
    Then I should see issue date display

  # Scenario: Verify all underwater permit only valid for 4 hours
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 9015
  #   And I select Underwater Operations permit
  #   And I select Simultaneous underwater operation during daytime with other operation permit for level 2
  #   And I fill up section 1
  #   When I press next for 9 times
  #   Then I submit permit for Master Review
  #   When I click on back to home
  #   And I set oa permit to active state
  #   And I click on active filter
  #   Then I should see permit valid for 4 hours

  Scenario: Verify all maintenance permit with long duration no then permit valid for 2 hours
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I submit after filling up section 1 with duration less than 2 hours
    When I press next for 9 times
    Then I submit permit for Master Approval
    When I click on back to home
    And I click on pending approval filter
    And I approve maintenance permit
    When I click on back to home
    And I click on active filter
    Then I should see permit valid for 2 hours

  # Scenario: Verify all maintenance permit with long duration yes then permit valid for 8 hours
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 9015
  #   And I select Critical Equipment Maintenance permit
  #   And I select Maintenance on Magnetic Compass permit for level 2
  #   And I submit after filling up section 1 with duration more than 2 hours
  #   When I press next for 9 times
  #   Then I submit permit for Master Approval
  #   When I click on back to home
  #   And I set oa permit to active state
  #   And I click on active filter
  #   Then I should see permit valid for 8 hours

  Scenario Outline: Verify RoL permit validity will be based on user selection
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next from section 1
    Then I submit permit for Master Approval
    When I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with <duration> duration
    And I click on back to home
    And I click on active filter
    Then I should see permit valid for <duration> hours

    Examples:
      | duration |
      | 1        |
      | 2        |
      | 3        |
      | 4        |
      | 5        |
      | 6        |
      | 7        |
      | 8        |

  Scenario Outline: Verify non maintenance non oa permits valid for 8 hour
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    When I press next for 9 times
    Then I submit permit for Master Approval
    When I click on back to home
    And I click on pending approval filter
    And I approve maintenance permit
    When I click on back to home
    And I click on active filter
    Then I should see permit valid for 8 hours

    Examples:
      | level_one_permit                                              | level_two_permit                                                        |
      | Hotwork                                                       | Hot Work Level-2 in Designated Area                                     |
      | Hotwork                                                       | Hot Work Level-1 (Loaded & Ballast Passage)                             |
      | Enclosed Spaces Entry                                         | Enclosed Spaces Entry                                                   |
      | Working Aloft/Overside                                        | Working Aloft / Overside                                                |
      | Work on Pressure Pipeline/Vessels                             | Work on pressure pipelines/pressure vessels                             |
      | Personal Transfer By Transfer Basket                          | Personnel Transfer by Transfer Basket                                   |
      | Helicopter Operations                                         | Helicopter Operation                                                    |
      | Rotational Portable Power Tool                                | Use of Portable Power Tools                                             |
      | Rotational Portable Power Tool                                | Use of Hydro blaster/working with High-pressure tools                   |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                      |
      | Cold Work                                                     | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard |
      | Cold Work                                                     | Cold Work - Cleaning Up of Spill                                        |
      | Cold Work                                                     | Cold Work - Connecting and Disconnecting Pipelines                      |
      | Cold Work                                                     | Cold Work - Working on Closed Electrical Equipment and Circuits         |
      | Cold Work                                                     | Cold Work - Maintenance Work on Machinery                               |
      | Cold Work                                                     | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds   |
      | Cold Work                                                     | Cold Work - Working in Hazardous or Dangerous Area                      |
      | Working on Deck During Heavy Weather                          | Working on Deck During Heavy Weather                                    |

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reader is needed for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending office approval state
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button enabled

    Examples:
      | permit_types | permit_payload                 | rank | pin  |
      # | intrinsical camera | submit_non_intrinsical_camera  | Master | 1111 |
      | underwater   | submit_underwater_simultaneous | A/M  | 9015 |

  Scenario Outline: Verify AGT cannot add gas reading when permit is in active state if Gas Reader is not needed for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with gas reading not require
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should not see gas reader sections on active permit

    Examples:
      | permit_types | permit_payload                 | rank | pin  |
      # | intrinsical camera | submit_non_intrinsical_camera  | Master | 1111 |
      | underwater   | submit_underwater_simultaneous | A/M  | 9015 |

  Scenario Outline: Verify non AGT cannot add gas reading when permit is in active state if Gas Reader is needed for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types | permit_payload                 | rank | pin  |
      # | intrinsical camera | submit_non_intrinsical_camera  | 4/E   | 1311 |
      # | underwater         | submit_underwater_simultaneous | A 4/E | 6894 |
      | underwater   | submit_underwater_simultaneous | ETO  | 0856 |

  Scenario Outline: Verify View button display when permit does not require Gas Permit for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending office approval state and no gas reading
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see View as button text

    Examples:
      | permit_types       | permit_payload                |
      | intrinsical camera | submit_non_intrinsical_camera |
  # | underwater         | submit_underwater_simultaneous |

  Scenario Outline: Verify Update Reading button display when permit requires Gas Permit for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending office approval state
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see Update Readings as button text

    Examples:
      | permit_types | permit_payload                 |
      # | intrinsical camera | submit_non_intrinsical_camera  |
      | underwater   | submit_underwater_simultaneous |

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reader is needed for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button enabled

    Examples:
      | permit_types                     | permit_payload               | rank   | pin  |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Master | 1111 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | A/M                        | 9015 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | C/O                        | 8383 |
  # | Hotwork                           | submit_hotwork               | A C/O                      | 2761 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 2/O                        | 6268 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | A 2/O                      | 7865 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | 3/O                        | 0159 |
  # | Hotwork                           | submit_hotwork               | A 3/O                      | 2674 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Chief Engineer             | 5122 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | Additional Chief Engineer  | 0110 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Second Engineer            | 2523 |
  # | Hotwork                           | submit_hotwork               | Additional Second Engineer | 3030 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 3/E                        | 4844 |
  # | Hotwork                           | submit_hotwork               | A 3/E                      | 6727 |

  Scenario Outline: Verify AGT cannot add gas reading when permit is in active state if Gas Reader is not needed for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with gas reading not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should not see gas reader sections on active permit

    Examples:
      | permit_types                     | permit_payload               | rank   | pin  |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Master | 1111 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | A/M                        | 9015 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | C/O                        | 8383 |
  # | Hotwork                           | submit_hotwork               | A C/O                      | 2761 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 2/O                        | 6268 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | A 2/O                      | 7865 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | 3/O                        | 0159 |
  # | Hotwork                           | submit_hotwork               | A 3/O                      | 2674 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Chief Engineer             | 5122 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | Additional Chief Engineer  | 0110 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Second Engineer            | 2523 |
  # | Hotwork                           | submit_hotwork               | Additional Second Engineer | 3030 |
  # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 3/E                        | 4844 |
  # | Hotwork                           | submit_hotwork               | A 3/E                      | 6727 |

  Scenario Outline: Verify non AGT cannot add gas reading when permit is in active state if Gas Reader is needed for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types                     | permit_payload               | rank | pin  |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | 4/E  | 1311 |
  # | Enclosed Spaces Entry              | submit_enclose_space_entry   | A 4/E | 6894 |
  # | Hotwork                           | submit_hotwork               | ETO   | 0856 |

  Scenario Outline: Verify Update Reading button display when permit requires Gas Permit for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see Update Readings as button text

    Examples:
      | permit_types | permit_payload |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill |
      # | Enclosed Spaces Entry              | submit_enclose_space_entry   |
      # | Enclosed Spaces Entry              | submit_enclose_space_entry   |
      | Hotwork      | submit_hotwork |

  Scenario Outline: Verify View button display when permit does not require Gas Permit for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state and no gas reading
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see View as button text

    Examples:
      | permit_types | permit_payload |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill |
      # | Enclosed Spaces Entry              | submit_enclose_space_entry   |
      # | Enclosed Spaces Entry              | submit_enclose_space_entry   |
      | Hotwork      | submit_hotwork |
