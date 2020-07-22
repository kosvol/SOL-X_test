@section7
Feature: Section7
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify only Master can approve and send form for update for non oa permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending approval state
    And I launch sol-x portal
    And I click on pending approval filter
    And I click on permit for master approval
    And I press next for 10 times
    Then I should see approve and request update button

    Examples:
      | permit_types         | permit_payload             |
      | Enclosed Space Entry | submit_enclose_space_entry |

  Scenario Outline: Verify only Master can approve and send form for update for oa permit
    Given I submit permit <permit_payload> via service with 1212 user and set to pending approval state
    And I launch sol-x portal
    And I click on pending approval filter
    And I click on permit for master review
    And I press next for 9 times
    Then I should see submit for office approval and request update button

    Examples:
      | permit_types                         | permit_payload                |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non Master cannot open permit pending Master Review
    Given I submit permit <permit_payload> via service with 1212 user and set to pending approval state
    And I launch sol-x portal
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank and <pin> pin
    Then I should see not authorize error message

    Examples:
      | rank                       | pin  | permit_types                         | permit_payload                |
      | Addtional Master           | 1212 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Chief Officer              | 5912 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Additional Chief Officer   | 5555 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Second Officer             | 5545 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Additional Second Officer  | 7777 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Chief Engineer             | 7507 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Additional Chief Engineer  | 0110 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Second Engineer            | 1313 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Additional Second Engineer | 1414 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
      | Electro Technical Officer  | 1717 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non master cannot open permit pending Master Approval
    Given I submit permit <permit_payload> via service with 1212 user and set to pending approval state
    And I launch sol-x portal
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank and <pin> pin
    Then I should see not authorize error message

    Examples:
      | rank                       | pin  | permit_types         | permit_payload             |
      | Addtional Master           | 1212 | Enclosed Space Entry | submit_enclose_space_entry |
      | Chief Officer              | 5912 | Enclosed Space Entry | submit_enclose_space_entry |
      | Additional Chief Officer   | 5555 | Enclosed Space Entry | submit_enclose_space_entry |
      | Second Officer             | 5545 | Enclosed Space Entry | submit_enclose_space_entry |
      | Additional Second Officer  | 7777 | Enclosed Space Entry | submit_enclose_space_entry |
      | Chief Engineer             | 7507 | Enclosed Space Entry | submit_enclose_space_entry |
      | Additional Chief Engineer  | 0110 | Enclosed Space Entry | submit_enclose_space_entry |
      | Second Engineer            | 1313 | Enclosed Space Entry | submit_enclose_space_entry |
      | Additional Second Engineer | 1414 | Enclosed Space Entry | submit_enclose_space_entry |
      | Electro Technical Officer  | 1717 | Enclosed Space Entry | submit_enclose_space_entry |