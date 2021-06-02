@pending-approval
Feature: PendingApprovalPermit
  As a ...
  I want to ...
  So that ...

  # @skip
  # Scenario: Verify view EIC certification exists if EIC certification form not filled
  #   Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
  #   And I launch sol-x portal without unlinking wearable
  #   And I click on pending approval filter
  #   And I click on permit for master approval
  #   And I enter pin for rank MAS
  #   And I navigate to section 4b
  #   Then I should see View EIC certification button

  Scenario: Verify submission text is correct after submitting to Office
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank C/O
    And I select Use of non-intrinsically safe Camera permit
    And I select Use of non-intrinsically safe Camera permit for level 2
    And I fill a full OA permit
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin for rank MAS
    And I navigate to section 6
    Then I should see correct OA submission text

  Scenario: Verify RA should not be able to edit EIC when pending master review
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank C/O
    And I select Use of non-intrinsically safe Camera permit
    And I select Use of non-intrinsically safe Camera permit for level 2
    And I fill a full OA permit
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin for rank A/M
    And I navigate to section 3a
    Then I should not be able to edit Use of non-intrinsically safe Camera DRA
    When I press next for 6 times
    Then I should not be able to edit EIC certification

  Scenario Outline: Verify RA and checklist only creator should not be able to edit DRA and EIC when pending master approval
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin <creator_pin>
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill a full enclosed workspace permit
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin <pin>
    And I navigate to section 3a
    Then I should not be able to edit Enclosed Spaces Entry DRA
    When I press next for 6 times
    Then I should not be able to edit EIC certification

    Examples:
      | rank   | creator_pin | pin  |
      | A/M    | 5718        | 9015 |
      | 3/E    | 2523        | 4685 |
      | PMAN   | 3030        | 4421 |
      | Master | 3030        | 1111 |


  Scenario: Verify user is brough back to listing screen after cancelling from pinpad
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master approval
    And I dismiss enter pin screen
    Then I should be navigated back to pending approval screen

  Scenario: Verify SOL-5474 - Fix Blank Screen when user accesses OA permits from Pending Approval state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    And I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I sleep for 230 seconds
    And I click on pending approval filter
    Then I should be able to open permit as master without seeing blank screen

  Scenario: Verify submitted time displayed
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration less than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    Then I should see the newly pending approval permit details listed on Pending Approval filter

  Scenario: Verify user should see Master Approval button
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    Then I should see Master Approval button

  Scenario: Verify user should see Master Review button
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    Then I should see Master Review button

  Scenario: Verify user should see Office Approval button
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    Then I should see Office Approval button