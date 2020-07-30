@section8
Feature: Section8
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with EIC not require
    And I set oa permit to active state
    And I launch sol-x portal without unlinking wearable
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
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types       | permit_payload                 | rank          | pin  |
      | intrinsical camera | submit_non_intrinsical_camera  | A/M           | 1212 |
      | underwater         | submit_underwater_simultaneous | Chief Officer | 5912 |

  Scenario Outline: Verify user should see two additional question when terminating Work on Pressure Pipeline permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
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
      | Enclosed Space Entry              | submit_enclose_space_entry   | 2/E Poon Choryi   | 1313 | SIT_SOLX0013 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |
      | Hotwork                           | submit_hotwork               | ETO Reza Ilmi     | 1717 | SIT_SOLX0017 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should not see EIC normalize extra questions

    Examples:
      | permit_types                      | permit_payload               | rank                     | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | A/M                      | 1212 |
      ## | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Officer | 5912 |
      | Hotwork                           | submit_hotwork               | Additional Chief Officer | 5555 |
  ## | Hotwork                           | submit_hotwork               | Second Officer             | 5545 |
  ## | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Second Officer  | 7777 |
  ## | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Engineer             | 7507 |
  ## | Hotwork                           | submit_hotwork               | Additional Chief Engineer  | 0110 |
  ## | Hotwork                           | submit_hotwork               | Second Engineer            | 1313 |
  ## | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Second Engineer | 1414 |
  ## | Hotwork                           | submit_hotwork               | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 1212 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types                      | permit_payload               | rank          | pin  |
      | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | A/M           | 1212 |
      | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Officer | 5912 |
## | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Chief Officer   | 5555 |
## | Hotwork                           | submit_hotwork               | Second Officer             | 5545 |
## | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Second Officer  | 7777 |
## | Enclosed Space Entry              | submit_enclose_space_entry   | Chief Engineer             | 7507 |
## | Cold Work - Cleaning Up of Spills | submit_cold_work_clean_spill | Additional Chief Engineer  | 0110 |
## | Hotwork                           | submit_hotwork               | Second Engineer            | 1313 |
## | Enclosed Space Entry              | submit_enclose_space_entry   | Additional Second Engineer | 1414 |
## | Hotwork                           | submit_hotwork               | Electro Technical Officer  | 1717 |
