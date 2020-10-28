@section8
Feature: Section8
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify competent and issuing authority detail display on read only mode if not signed

  Scenario: Verify extra section8 questions shown for crit,electrical and pipe permit
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 9015
    And I select Work on Pressure Pipeline/Vessels permit
    And I select Work on Pressure Pipeline/Vessels permit for level 2
    And I navigate to section 4a
    And I select the matching Critical Equipment Maintenance Checklist checklist
    And I select the matching Work on Electrical Equipment and Circuits checklist
    And I press next for 6 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I press next for 13 times
    And I sign the permit for submission to pending state
    And I click on back to home
    And I click on active filter
    And I terminate permit with A/M rank and 9015 pin
    Then I should see all extra section8 questions

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I set oa permit to ACTIVE state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should not see EIC normalize extra questions

    Examples:
      | permit_types       | permit_payload                | rank | pin  |
      | intrinsical camera | submit_non_intrinsical_camera | A/M  | 9015 |
  # | underwater   | submit_underwater_simultaneous | Chief Officer | 8383 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I set oa permit to ACTIVE state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types | permit_payload                 | rank          | pin  |
      # | intrinsical camera | submit_non_intrinsical_camera | A/M  | 9015 |
      | underwater   | submit_underwater_simultaneous | Chief Officer | 8383 |

  Scenario Outline: Verify user should see two additional question when terminating Work on Pressure Pipeline permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC extra questions for work on pressure pipe permit

    Examples:
      | permit_types          | permit_payload               | rank | pin  |
      | Work on Pressure Line | submit_work_on_pressure_line | A/M  | 9015 |

  Scenario Outline: Verify section 8 EIC can only be signed by RA for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <terminator_pin> pin
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign EIC section 8 with RA <pin>

    Examples:
      | permit_types          | permit_payload               | terminator_rank | terminator_pin | rank           | pin  | user         | zoneid                     | mac               | location_stamp |
      | Work on Pressure Line | submit_work_on_pressure_line | C/O             | 8383           | A/M Atif Hayat | 9015 | SIT_SOLX0012 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Aft Station    |

  Scenario Outline: Verify section 8 EIC can only be signed by Issue authority for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <terminator_pin> pin
    And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
    Then I sign EIC as issuing authority with pin <pin>
    And I should see <rank> rank and name for section 8
    And I should see signed date and time for section 8
    And I should see location <location_stamp> stamp

    Examples:
      | permit_types                     | permit_payload               | terminator_rank | terminator_pin | rank             | pin  | user         | zoneid                     | mac               | location_stamp   |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | C/O             | 8383           | C/E Alex Pisarev | 8248 | SIT_SOLX0002 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |

  Scenario Outline: Verify section 8 EIC can only be signed by EIC competent person for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    Then I sign EIC as competent person with pin <pin>
    And I should see <rank> rank and name for section 8
    And I should see signed date and time for section 8
    And I should see location <location_stamp> stamp

    Examples:
      | permit_types | permit_payload | rank          | pin  | user         | zoneid                     | mac               | location_stamp   |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | C/O Alister Leong | 8383 | SIT_SOLX0004 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |
      # | Enclosed Spaces Entry | submit_enclose_space_entry | 2/E Poon Choryi | 2523 | SIT_SOLX0013 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom    |
      | Hot Work     | submit_hotwork | ETO Reza Ilmi | 0856 | SIT_SOLX0017 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should not see EIC normalize extra questions

    Examples:
      | permit_types | permit_payload | rank                     | pin  |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | A/M                      | 9015 |
      ## | Enclosed Spaces Entry              | submit_enclose_space_entry   | Chief Officer | 8383 |
      | Hot Work     | submit_hotwork | Additional Chief Officer | 2761 |
  ## | Hot Work                           | submit_hotwork               | Second Officer             | 6268 |
  ## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Second Officer  | 7865 |
  ## | Enclosed Spaces Entry              | submit_enclose_space_entry   | Chief Engineer             | 8248 |
  ## | Hot Work                           | submit_hotwork               | Additional Chief Engineer  | 2761 |
  ## | Hot Work                           | submit_hotwork               | Second Engineer            | 2523 |
  ## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Second Engineer | 3030 |
  ## | Hot Work                           | submit_hotwork               | Electro Technical Officer  | 0856 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with <rank> rank and <pin> pin
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types                     | permit_payload               | rank | pin  |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | A/M  | 9015 |
# | Enclosed Spaces Entry            | submit_enclose_space_entry   | Chief Officer | 8383 |
## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Chief Officer   | 2761 |
## | Hot Work                           | submit_hotwork               | Second Officer             | 6268 |
## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Second Officer  | 7865 |
## | Enclosed Spaces Entry              | submit_enclose_space_entry   | Chief Engineer             | 8248 |
## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Chief Engineer  | 2761 |
## | Hot Work                           | submit_hotwork               | Second Engineer            | 2523 |
## | Enclosed Spaces Entry              | submit_enclose_space_entry   | Additional Second Engineer | 3030 |
## | Hot Work                           | submit_hotwork               | Electro Technical Officer  | 0856 |
