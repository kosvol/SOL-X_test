@section8
Feature: Section8
  As a ...
  I want to ...
  So that ...

  Scenario: Verify section 8 Competent Person sign button is disable for read only user via pending termination state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with A/M rank
    And I submit permit for termination
    And I sign with valid A/M rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I withdraw permit with MAS rank
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with PMAN rank
    And I press next for 3 times
    Then I should not see issuing and competence authority button

  Scenario: Verify non RA cannot fill section 8 for termination
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with PMAN rank
    Then I should see section 8 in read only mode

  Scenario: Verify task commenced at should be populated with permit activated time
    Given I launch sol-x portal
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select Work on Pressure Pipeline/Vessels permit
    And I select NA permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with A/M rank
    And I press next for 11 times
    And I sign the permit for submission to active state
    And I click on back to home
    And I set time
    And I click on active filter
    And I take note of issued date and time
    And I review and withdraw permit with A/M rank
    Then I should see task commenced data and time populated with permit activated date and timestamp

  Scenario: Verify extra section8 questions shown for pipe permit
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Work on Pressure Pipeline/Vessels permit
    And I select NA permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 11 times
    And I sign the permit for submission to active state
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see extra section8 questions for pipe permit

  Scenario: Verify extra section8 questions shown for electrical permit
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Work on Electrical Equipment and Circuits – Low/High Voltage permit
    And I select NA permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 11 times
    And I sign the permit for submission to active state
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see extra section8 questions for electrical permit

  Scenario: Verify extra section8 questions shown for crit
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I fill only location of work and duration less than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 11 times
    And I sign the permit for submission to active state
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see extra section8 questions for critical maintenance permit

  Scenario: Verify extra section8 questions shown when Critical Equipment Maintenance Checklist selected
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
    And I fill only location of work
    And I navigate to section 4a
    And I select the matching Critical Equipment Maintenance Checklist checklist
    And I press next for 1 times
    And I sign checklist with C/O as valid rank
    And I press next for 1 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 12 times
    And I sign the permit for submission to active state
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see extra section8 questions for critical maintenance permit

  Scenario: Verify extra section8 questions shown when Work on Electrical Equipment and Circuits
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
    And I fill only location of work
    And I navigate to section 4a
    And I select the matching Work on Electrical Equipment and Circuits checklist
    And I press next for 1 times
    And I sign checklist with C/O as valid rank
    And I press next for 1 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 12 times
    And I sign the permit for submission to active state
    And I click on back to home
    And I click on active filter
    And I review and withdraw permit with A/M rank
    Then I should see extra section8 questions for electrical permit

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I set oa permit to ACTIVE state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with <rank> rank
    Then I should not see EIC normalize extra questions

    Examples:
      | permit_types       | permit_payload                | rank | pin  |
      | intrinsical camera | submit_non_intrinsical_camera | A/M  | 9015 |
  # | underwater   | submit_underwater_simultaneous | C/O | 8383 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I set oa permit to ACTIVE state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with <rank> rank
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types | permit_payload                 | rank | pin  |
      # | intrinsical camera | submit_non_intrinsical_camera | A/M  | 9015 |
      | underwater   | submit_underwater_simultaneous | C/O  | 8383 |

  Scenario Outline: Verify user should see two additional question when terminating Work on Pressure Pipeline permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with <rank> rank
    Then I should see EIC extra questions for work on pressure pipe permit

    Examples:
      | permit_types          | permit_payload               | rank | pin  |
      | Work on Pressure Line | submit_work_on_pressure_line | A/M  | 9015 |

  Scenario Outline: Verify section 8 EIC can only be signed by RA for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I review and withdraw permit with <terminator_rank> rank
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign EIC section 8 with RA A/M rank

    Examples:
      | permit_types          | permit_payload               | terminator_rank | terminator_pin | rank           | pin  | user          | zoneid        | mac               | location_stamp |
      | Work on Pressure Line | submit_work_on_pressure_line | C/O             | 8383           | A/M Atif Hayat | 9015 | AUTO_SOLX0012 | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    |

  Scenario Outline: Verify section 8 EIC can only be signed by Issue authority for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I review and withdraw permit with <terminator_rank> rank
    And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
    Then I sign EIC as issuing authority with rank <rank>
    And I set time
    And I should see <rank_name> rank and name for section 8
    And I should see signed date and time for section 8
    And I should see location <location_stamp> stamp

    Examples:
      | permit_types                     | permit_payload               | terminator_rank | terminator_pin | rank_name   | rank | user          | zoneid        | mac               | location_stamp |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | C/O             | 8383           | C/E COT C/E | C/E  | AUTO_SOLX0002 | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    |

  Scenario Outline: Verify section 8 EIC can only be signed by EIC competent person for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal
    And I click on active filter
    And I review and withdraw permit with A/M rank
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    # And I navigate to section 8
    Then I sign EIC as competent person with rank <rank>
    And I set time
    And I should see <rank_name> rank and name for section 8
    And I should see signed date and time for section 8
    And I should see location <location_stamp> stamp

    Examples:
      | permit_types | permit_payload | rank_name   | rank | user          | zoneid        | mac               | location_stamp |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | C/O Alister Leong | 8383 | AUTO_SOLX0004 | Z-AFT-STATION  | 00:00:00:00:00:10 | Aft Station |
      # | Enclosed Spaces Entry | submit_enclose_space_entry | 2/E Poon Choryi | 2523 | AUTO_SOLX0013 | Z-AFT-STATION  | 00:00:00:00:00:10 | Aft Station    |
      | Hot Work     | submit_hotwork | ETO COT ETO | ETO  | AUTO_SOLX0017 | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    |

  Scenario Outline: Verify EIC normalization not displayed when EIC is No during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with <rank> rank
    # And I navigate to section 8
    Then I should not see EIC normalize extra questions

    Examples:
      | permit_types | permit_payload | rank  | pin  |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | A/M                      | 9015 |
      ## | Enclosed Spaces Entry              | submit_enclose_space_entry   | C/O | 8383 |
      | Hot Work     | submit_hotwork | A C/O | 2761 |
  ## | Hot Work                           | submit_hotwork               | Second Officer             | 6268 |
  ## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Second Officer  | 7865 |
  ## | Enclosed Spaces Entry              | submit_enclose_space_entry   | Chief Engineer             | 8248 |
  ## | Hot Work                           | submit_hotwork               | Additional Chief Engineer  | 5718 |
  ## | Hot Work                           | submit_hotwork               | Second Engineer            | 2523 |
  ## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Second Engineer | 3030 |
  ## | Hot Work                           | submit_hotwork               | Electro Technical Officer  | 0856 |

  Scenario Outline: Verify EIC normalization displayed when EIC is Yes during permit creation for non OA permit
    Given I submit permit <permit_payload> via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with <rank> rank
    Then I should see EIC normalize extra questions

    Examples:
      | permit_types                     | permit_payload               | rank | pin  |
      | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | A/M  | 9015 |
# | Enclosed Spaces Entry            | submit_enclose_space_entry   | C/O | 8383 |
## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional C/O   | 2761 |
## | Hot Work                           | submit_hotwork               | Second Officer             | 6268 |
## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Second Officer  | 7865 |
## | Enclosed Spaces Entry              | submit_enclose_space_entry   | Chief Engineer             | 8248 |
## | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Additional Chief Engineer  | 5718 |
## | Hot Work                           | submit_hotwork               | Second Engineer            | 2523 |
## | Enclosed Spaces Entry              | submit_enclose_space_entry   | Additional Second Engineer | 3030 |
## | Hot Work                           | submit_hotwork               | Electro Technical Officer  | 0856 |
