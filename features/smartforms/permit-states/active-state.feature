@active-permit
Feature: ActivePermit
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify user land on section 6 after clicking on Update Reader on active permit

  Scenario Outline: Verify AGT can edit Gas Reader when permit is in active state if Gas Reader is needed for both OA and non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button enabled
    # Then I should see Update Readings as button text

    Examples:
      | permit_types                         | permit_payload                | rank                       | pin  |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | Master                     | 1111 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | A/M                        | 1212 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | C/O                        | 5912 |
      | Hotwork                              | submit_hotwork                | A C/O                      | 5555 |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | 2/O                        | 5545 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | A 2/O                      | 7777 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | 3/O                        | 8888 |
      | Hotwork                              | submit_hotwork                | A 3/O                      | 9999 |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | Chief Engineer             | 7507 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | Additional Chief Engineer  | 0110 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | Second Engineer            | 1313 |
      | Hotwork                              | submit_hotwork                | Additional Second Engineer | 1414 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | 3/E                        | 4092 |
      | Hotwork                              | submit_hotwork                | A 3/E                      | 1515 |

  Scenario Outline: Verify AGT cannot edit Gas Reader when permit is in active state if Gas Reader is not needed for both OA and non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I update active permit with <rank> rank and <pin> pin
    Then I should see Add Gas Reading button disabled
    # Then I should see Update Readings as button text

    Examples:
      | permit_types                         | permit_payload                | rank  | pin  |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | 4/E   | 2323 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | A 4/E | 2424 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | ETO   | 1717 |

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for both OA and non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with EIC not require
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should not see EIC normalize extra questions
    # Then I should see the terminated permit cannot be seen on active filter listing
    # And I should see the terminated permit can be seen on pending withdrawal filter listing

    Examples:
      | permit_types                         | permit_payload                | rank                       | pin  |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | A/M                        | 1212 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | Chief Officer              | 5912 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | Additional Chief Officer   | 5555 |
      | Hotwork                              | submit_hotwork                | Second Officer             | 5545 |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | Additional Second Officer  | 7777 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | Chief Engineer             | 7507 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | Additional Chief Engineer  | 0110 |
      | Hotwork                              | submit_hotwork                | Second Engineer            | 1313 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | Additional Second Engineer | 1414 |
      | Hotwork                              | submit_hotwork                | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for both OA and non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC normalize extra questions
    # Then I should see the terminated permit cannot be seen on active filter listing
    # And I should see the terminated permit can be seen on pending withdrawal filter listing

    Examples:
      | permit_types                         | permit_payload                | rank                       | pin  |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | A/M                        | 1212 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | Chief Officer              | 5912 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | Additional Chief Officer   | 5555 |
      | Hotwork                              | submit_hotwork                | Second Officer             | 5545 |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  | Additional Second Officer  | 7777 |
      | Enclosed Space Entry                 | submit_enclose_space_entry    | Chief Engineer             | 7507 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | Additional Chief Engineer  | 0110 |
      | Hotwork                              | submit_hotwork                | Second Engineer            | 1313 |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera | Additional Second Engineer | 1414 |
      | Hotwork                              | submit_hotwork                | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify Update Reading button display when permit requires Gas Permit for both OA and non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    Then I should see Update Readings as button text

    Examples:
      | permit_types                         | permit_payload                |
      | Cold Work - Cleaning Up of Spills    | submit_cold_work_clean_spill  |
      | Enclosed Space Entry                 | submit_enclose_space_entry    |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Hotwork                              | submit_hotwork                |

# Scenario: Verify in view mode all section is disabled
