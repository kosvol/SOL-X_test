@section7
Feature: Section7
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify Master can see approve and update buttons for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I sleep for 1 seconds
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master approval
    And I press next for 11 times
    Then I should see approve and request update buttons

    Examples:
      | permit_types          | permit_payload             |
      | Enclosed Spaces Entry | submit_enclose_space_entry |

  Scenario Outline: Verify Master can review and update button for oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I sleep for 1 seconds
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master review
    And I press next for 10 times
    Then I should see submit for office approval and request update buttons

    Examples:
      | permit_types                         | permit_payload                |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non Master will not see office approval and request update button for oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank and <pin> pin
    And I press next for 10 times
    Then I should not see submit for office approval and request update buttons

    Examples:
      | rank             | pin  | permit_types                         | permit_payload                |
      | Addtional Master | 9015 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Chief Officer              | 8383 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Chief Officer   | 2761 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Second Officer             | 6268 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Second Officer  | 7865 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Chief Engineer             | 8248 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Chief Engineer  | 1122 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Second Engineer            | 2523 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Second Engineer | 3030 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Electro Technical Officer  | 0856 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non Master will not see approve and request update button for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank and <pin> pin
    And I press next for 10 times
    Then I should not see approve and request update buttons

    Examples:
      | rank             | pin  | permit_types          | permit_payload             |
      | Addtional Master | 9015 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Chief Officer              | 8383 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Chief Officer   | 2761 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Second Officer             | 6268 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Second Officer  | 7865 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Chief Engineer             | 8248 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Chief Engineer  | 2761 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Second Engineer            | 2523 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Second Engineer | 3030 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Electro Technical Officer  | 0856 | Enclosed Spaces Entry | submit_enclose_space_entry |