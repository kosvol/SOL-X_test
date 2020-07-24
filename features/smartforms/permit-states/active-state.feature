@active-permit
Feature: ActivePermit
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify user land on section 6 after clicking on Update Reader on active permit
  # Scenario: Verify in view mode all section is disabled

  Scenario: Verify all underwater permit only valid for 4 hours

  Scenario: Verify all maintenance permit with long duration no then permit valid for 2 hours

  Scenario: Verify all maintenance permit with long duration yes then permit valid for 8 hours

  Scenario: Verify RoL permit validity will be based on user selection

  Scenario: Verify all other permits valid for 8 hour

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reader is needed for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending office approval state
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button enabled

    Examples:
      | permit_types | permit_payload                 | rank | pin  |
      # | intrinsical camera | submit_non_intrinsical_camera  | Master | 1111 |
      | underwater   | submit_underwater_simultaneous | A/M  | 1212 |

  Scenario Outline: Verify AGT cannot add gas reading when permit is in active state if Gas Reader is not needed for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with gas reading not require
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should not see gas reader sections

    Examples:
      | permit_types       | permit_payload                 | rank   | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | Master | 1111 |
      | underwater         | submit_underwater_simultaneous | A/M    | 1212 |

  Scenario Outline: Verify non AGT cannot add gas reading when permit is in active state if Gas Reader is needed for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types       | permit_payload                 | rank  | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | 4/E   | 2323 |
      | underwater         | submit_underwater_simultaneous | A 4/E | 2424 |
      | underwater         | submit_underwater_simultaneous | ETO   | 1717 |

  Scenario Outline: Verify View button display when permit does not require Gas Permit for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending office approval state and no gas reading
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see View as button text

    Examples:
      | permit_types       | permit_payload                 |
      | intrinsical camera | submit_non_intrinsical_camera  |
      | underwater         | submit_underwater_simultaneous |

  Scenario Outline: Verify Update Reading button display when permit requires Gas Permit for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending office approval state
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see Update Readings as button text

    Examples:
      | permit_types       | permit_payload                 |
      | intrinsical camera | submit_non_intrinsical_camera  |
      | underwater         | submit_underwater_simultaneous |

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reader is needed for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button enabled

    Examples:
      | permit_types                      | permit_payload               | rank                       | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Master                     | 1111 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | A/M                        | 1212 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | C/O                        | 5912 |
      | Hotwork                           | submit_hotwork               | A C/O                      | 5555 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | 2/O                        | 5545 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | A 2/O                      | 7777 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | 3/O                        | 8888 |
      | Hotwork                           | submit_hotwork               | A 3/O                      | 9999 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Chief Engineer             | 7507 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Additional Chief Engineer  | 0110 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Second Engineer            | 1313 |
      | Hotwork                           | submit_hotwork               | Additional Second Engineer | 1414 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | 3/E                        | 4092 |
      | Hotwork                           | submit_hotwork               | A 3/E                      | 1515 |

  Scenario Outline: Verify AGT cannot add gas reading when permit is in active state if Gas Reader is not needed for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with gas reading not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should not see gas reader sections

    Examples:
      | permit_types                      | permit_payload               | rank                       | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Master                     | 1111 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | A/M                        | 1212 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | C/O                        | 5912 |
      | Hotwork                           | submit_hotwork               | A C/O                      | 5555 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | 2/O                        | 5545 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | A 2/O                      | 7777 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | 3/O                        | 8888 |
      | Hotwork                           | submit_hotwork               | A 3/O                      | 9999 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Chief Engineer             | 7507 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Additional Chief Engineer  | 0110 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Second Engineer            | 1313 |
      | Hotwork                           | submit_hotwork               | Additional Second Engineer | 1414 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | 3/E                        | 4092 |
      | Hotwork                           | submit_hotwork               | A 3/E                      | 1515 |

  Scenario Outline: Verify non AGT cannot add gas reading when permit is in active state if Gas Reader is needed for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types                      | permit_payload               | rank  | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | 4/E   | 2323 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | A 4/E | 2424 |
      | Hotwork                           | submit_hotwork               | ETO   | 1717 |

  Scenario Outline: Verify Update Reading button display when permit requires Gas Permit for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see Update Readings as button text

    Examples:
      | permit_types                      | permit_payload               |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill |
      | Enclosed Space Entry              | submit_enclose_space_entry   |
      | Enclosed Space Entry              | submit_enclose_space_entry   |
      | Hotwork                           | submit_hotwork               |

  Scenario Outline: Verify View button display when permit does not require Gas Permit for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state and no gas reading
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    Then I should see View as button text

    Examples:
      | permit_types                      | permit_payload               |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill |
      | Enclosed Space Entry              | submit_enclose_space_entry   |
      | Enclosed Space Entry              | submit_enclose_space_entry   |
      | Hotwork                           | submit_hotwork               |
