@active-permit
Feature: ActivePermit
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify user land on section 6 after clicking on Update Reader on active permit
  # Scenario: Verify in view mode all section is disabled

  Scenario Outline: Verify user should see two additional question when terminating Work on Pressure Pipeline permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with EIC not require
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC extra questions for work on pressure pipe permit

    Examples:
      | permit_types          | permit_payload               | rank | pin  |
      | Work on Pressure Line | submit_work_on_pressure_line | A/M  | 1212 |

  Scenario Outline: Verify section 8 EIC can only be signed by RA for non oa permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <terminator_pin> pin
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    And I sign EIC section 8 with RA <pin>
    And I should see <rank> rank and name for section 8
    And I should see signed date and time for section 8
    And I should see location <location_stamp> stamp

    Examples:
      | permit_types          | permit_payload               | terminator_rank | terminator_pin | rank           | pin  | user         | zoneid                     | mac               | location_stamp   |
      | Work on Pressure Line | submit_work_on_pressure_line | C/O             | 5912           | A/M Atif Hayat | 1212 | SIT_SOLX0012 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |

  Scenario Outline: Verify section 8 EIC can only be signed by Issue authority for non oa permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <terminator_pin> pin
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    Then I sign EIC as issuing authority with pin <pin>
    And I should see <rank> rank and name for section 8
    And I should see signed date and time for section 8
    And I should see location <location_stamp> stamp

    Examples:
      | permit_types                      | permit_payload               | terminator_rank | terminator_pin | rank             | pin  | user         | zoneid                     | mac               | location_stamp   |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | C/O             | 5912           | C/E Alex Pisarev | 7507 | SIT_SOLX0002 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |

  Scenario Outline: Verify section 8 EIC can only be signed by EIC competent person for non oa permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    Then I sign EIC as competent person with pin <pin>
    And I should see <rank> rank and name for section 8
    And I should see signed date and time for section 8
    And I should see location <location_stamp> stamp

    Examples:
      | permit_types                      | permit_payload               | rank              | pin  | user         | zoneid                     | mac               | location_stamp   |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | C/O Alister Leong | 5912 | SIT_SOLX0004 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |
      | Enclosed Space Entry              | submit_enclose_space_entry   | 2/E Poon Choryi   | 1313 | SIT_SOLX0004 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |
      | Hotwork                           | submit_hotwork               | ETO Reza Ilmi     | 1717 | SIT_SOLX0004 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reader is needed for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending office approval state
    And I set oa permit to active state
    And I launch sol-x portal
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button enabled

    Examples:
      | permit_types       | permit_payload                 | rank   | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | Master | 1111 |
      | underwater         | submit_underwater_simultaneous | A/M    | 1212 |

  Scenario Outline: Verify AGT cannot add gas reading when permit is in active state if Gas Reader is not needed for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with gas reading not require
    And I set oa permit to active state
    And I launch sol-x portal
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
    And I launch sol-x portal
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types       | permit_payload                 | rank  | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | 4/E   | 2323 |
      | underwater         | submit_underwater_simultaneous | A 4/E | 2424 |
      | underwater         | submit_underwater_simultaneous | ETO   | 1717 |

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with EIC not require
    And I set oa permit to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should not see EIC normalize extra questions

    Examples:
      | permit_types       | permit_payload                 | rank          | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | A/M           | 1212 |
      | underwater         | submit_underwater_simultaneous | Chief Officer | 5912 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I set oa permit to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types       | permit_payload                 | rank          | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | A/M           | 1212 |
      | underwater         | submit_underwater_simultaneous | Chief Officer | 5912 |

  Scenario Outline: Verify View button display when permit does not require Gas Permit for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending office approval state and no gas reading
    And I set oa permit to active state
    And I launch sol-x portal
    And I click on active filter
    Then I should see View as button text

    Examples:
      | permit_types       | permit_payload                 |
      | intrinsical camera | submit_non_intrinsical_camera  |
      | underwater         | submit_underwater_simultaneous |

  Scenario Outline: Verify Update Reading button display when permit requires Gas Permit for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending office approval state
    And I set oa permit to active state
    And I launch sol-x portal
    And I click on active filter
    Then I should see Update Readings as button text

    Examples:
      | permit_types       | permit_payload                 |
      | intrinsical camera | submit_non_intrinsical_camera  |
      | underwater         | submit_underwater_simultaneous |

  Scenario Outline: Verify AGT can add gas reading when permit is in active state if Gas Reader is needed for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
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
    And I launch sol-x portal
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
    And I launch sol-x portal
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button disabled

    Examples:
      | permit_types                      | permit_payload               | rank  | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | 4/E   | 2323 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | A 4/E | 2424 |
      | Hotwork                           | submit_hotwork               | ETO   | 1717 |

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with EIC not require
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should not see EIC normalize extra questions

    Examples:
      | permit_types                      | permit_payload               | rank                       | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | A/M                        | 1212 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Officer              | 5912 |
      | Hotwork                           | submit_hotwork               | Additional Chief Officer   | 5555 |
      | Hotwork                           | submit_hotwork               | Second Officer             | 5545 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Second Officer  | 7777 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Engineer             | 7507 |
      | Hotwork                           | submit_hotwork               | Additional Chief Engineer  | 0110 |
      | Hotwork                           | submit_hotwork               | Second Engineer            | 1313 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Second Engineer | 1414 |
      | Hotwork                           | submit_hotwork               | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types                      | permit_payload               | rank                       | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | A/M                        | 1212 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Officer              | 5912 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Chief Officer   | 5555 |
      | Hotwork                           | submit_hotwork               | Second Officer             | 5545 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Second Officer  | 7777 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Engineer             | 7507 |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Chief Engineer  | 0110 |
      | Hotwork                           | submit_hotwork               | Second Engineer            | 1313 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Additional Second Engineer | 1414 |
      | Hotwork                           | submit_hotwork               | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify Update Reading button display when permit requires Gas Permit for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
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
    And I launch sol-x portal
    And I click on active filter
    Then I should see View as button text

    Examples:
      | permit_types                      | permit_payload               |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill |
      | Enclosed Space Entry              | submit_enclose_space_entry   |
      | Enclosed Space Entry              | submit_enclose_space_entry   |
      | Hotwork                           | submit_hotwork               |