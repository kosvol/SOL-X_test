@pending-approval
Feature: PendingApprovalPermit
  As a ...
  I want to ...
  So that ...

  Scenario: Verify SOL-5474
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    When I press next for 10 times
    Then I submit permit for Master Review
    And I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I click on pending approval filter
    Then I should be able to open permit as master without seeing blank screen

  Scenario: Verify submitted time displayed
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration less than 2 hours
    When I press next for 10 times
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