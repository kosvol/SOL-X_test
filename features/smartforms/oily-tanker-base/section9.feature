@section9
Feature: Section9
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify permit is removed from Pending Withdrawal filter after update requested
  # Scenario: Verify permit is removed from Pending Withdrawal filter after manual termination

  Scenario: Verify section 9 buttons display are correct via pending termination state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I set non oa permit to ACTIVE state
    And I set non oa permit to PENDING_TERMINATION state
    And I click on pending withdrawal filter
    And I open a permit pending termination with 5/E rank and 7551 pin
    Then I should see previous and close buttons

  Scenario Outline: Verify Master can see terminate and update buttons for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I sleep for 1 seconds
    And I launch sol-x portal without unlinking wearable
    And I set oa permit to ACTIVE state
    And I set oa permit to PENDING_TERMINATION state
    And I click on pending withdrawal filter
    And I click on permit for review and termination
    And I enter pin for rank MAS
    Then I should see terminate permit to work and request update buttons

    Examples:
      | permit_types          | permit_payload             |
      | Enclosed Spaces Entry | submit_enclose_space_entry |

  Scenario Outline: Verify Master can see terminate and update buttons for oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I sleep for 1 seconds
    And I launch sol-x portal without unlinking wearable
    And I set oa permit to ACTIVE state
    And I set oa permit to PENDING_TERMINATION state
    And I click on pending withdrawal filter
    And I click on permit for review and termination
    And I enter pin for rank MAS
    Then I should see terminate permit to work and request update buttons

    Examples:
      | permit_types                         | permit_payload                |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non Master will not see terminate and update button for oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I set oa permit to ACTIVE state
    And I set oa permit to PENDING_TERMINATION state
    And I click on pending withdrawal filter
    And I open a permit pending termination with <rank> rank and <pin> pin
    Then I should not see terminate permit to work and request update buttons

    Examples:
      | rank                      | pin  | permit_types                         | permit_payload                |
      # | Addtional Master | 9015 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | 3/E                       | 4685 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | A 3/E                     | 6727 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | 4/E                       | 1311 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | A 4/E                     | 0703 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      # | Chief Engineer | 8248 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      ## | Additional Chief Engineer  | 5718 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      ## | Second Engineer            | 2523 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      ## | Additional Second Engineer | 3030 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Electro Technical Officer | 0856 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non Master will not see approve and request update button for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I set oa permit to ACTIVE state
    And I set oa permit to PENDING_TERMINATION state
    And I click on pending withdrawal filter
    And I open a permit pending termination with <rank> rank and <pin> pin
    Then I should not see terminate permit to work and request update buttons

    Examples:
      | rank             | pin  | permit_types          | permit_payload             |
      | Addtional Master | 9015 | Enclosed Spaces Entry | submit_enclose_space_entry |

  Scenario Outline: Verify Status Update display as completed when user submit as continue
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I set oa permit to ACTIVE state
    And I click on active filter
    And I manually put the permit to pending termination state
    And I click on pending withdrawal filter
    Then I should <status> as task status

    Examples:
      | permit_types          | permit_payload             | status    |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Completed |
      | Enclosed Spaces Entry | submit_enclose_space_entry | Completed |
  # | Hot Work                           | submit_Hot Work               | Suspended |

  Scenario Outline: Verify date and time are pre-fill
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I sleep for 1 seconds
    And I launch sol-x portal without unlinking wearable
    And I set oa permit to ACTIVE state
    And I set oa permit to PENDING_TERMINATION state
    And I click on pending withdrawal filter
    And I click on permit for review and termination
    And I enter pin for rank MAS
    Then I should see date and time pre-fill on section 9

    Examples:
      | permit_types          | permit_payload             |
      | Enclosed Spaces Entry | submit_enclose_space_entry |