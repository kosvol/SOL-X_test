@section7
Feature: Section7
  As a ...
  I want to ...
  So that ...

  # @sol-6553
  # Scenario: Verify validity from and to is correct with more than 0 ship time offset
  #   Given I change ship local time to +8 GMT
  #   When I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin for rank A/M
  #   And I select Hot Work permit
  #   And I select Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) permit for level 2
  #   And I fill up section 1 with default value
  #   And I navigate to section 4a
  #   And I press next for 1 times
  #   And I fill up compulsory fields
  #   And I press next for 1 times
  #   Then I submit permit for Master Review
  #   When I click on back to home
  #   And I click on pending approval filter
  #   And I set oa permit to office approval state manually
  #   And I click on pending approval filter
  #   And I navigate to OA link
  #   And I approve oa permit via oa link manually with from 0 hour to 01 hour
  #   And I click on pending approval filter
  #   And I approve permit
  #   And I click on back to home
  #   And I click on update needed filter
  #   And I update permit with A/M rank
  #   And I navigate to section 7
  #   # And I click on active filter   ### should be using this step but due to bug ####
  #   Then I should see valid validity from 8 to 9
  #   When I press next for 1 times
  #   Then I should see valid validity date and time

  @sol-6553
  Scenario: Verify validity from and to is correct for non OA permit
    Given I change ship local time to +8 GMT
    When I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I view permit with A/M rank
    And I press previous for 1 times
    Then I should see valid validity date and time

  @sol-6553
  Scenario: Verify validity from and to is correct for OA permit
    Given I change ship local time to +8 GMT
    And I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Hot Work permit
    And I select Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I click on pending approval filter
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I view permit with A/M rank
    And I press previous for 1 times
    Then I should see valid validity date and time

  Scenario Outline: Verify Master can see approve and update buttons for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I sleep for 1 seconds
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin for rank MAS
    And I press next for 11 times
    Then I should see approve and request update buttons

    Examples:
      | permit_types          | permit_payload             |
      | Enclosed Spaces Entry | submit_enclose_space_entry |
  # | underwater            | submit_underwater_simultaneous |

  Scenario Outline: Verify Master can review and update button for oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I sleep for 1 seconds
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master review
    And I enter pin for rank MAS
    And I press next for 10 times
    Then I should see submit for office approval and request update buttons

    Examples:
      | permit_types                         | permit_payload                |
      | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non Master will not see office approval, request update and close button for oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank
    And I press next for 10 times
    Then I should not see submit for office approval and request update buttons
    And I should see close button

    Examples:
      | rank             | pin  | permit_types                         | permit_payload                |
      | Addtional Master | 9015 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Chief Officer              | 8383 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Chief Officer   | 2761 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Second Officer             | 6268 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Second Officer  | 7865 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Chief Engineer             | 8248 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Chief Engineer  | 5718 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Second Engineer            | 2523 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Additional Second Engineer | 3030 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |
  # | Electro Technical Officer  | 0856 | Use of non-intrinsically safe Camera | submit_non_intrinsical_camera |

  Scenario Outline: Verify non Master will not see approve and request update button for non oa permit
    Given I submit permit <permit_payload> via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank
    And I press next for 10 times
    Then I should not see approve and request update buttons
    And I should see close button

    Examples:
      | rank             | pin  | permit_types          | permit_payload             |
      | Addtional Master | 9015 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Chief Officer              | 8383 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Chief Officer   | 2761 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Second Officer             | 6268 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Second Officer  | 7865 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Chief Engineer             | 8248 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Chief Engineer  | 5718 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Second Engineer            | 2523 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Additional Second Engineer | 3030 | Enclosed Spaces Entry | submit_enclose_space_entry |
#     | Electro Technical Officer  | 0856 | Enclosed Spaces Entry | submit_enclose_space_entry |