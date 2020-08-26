@pending-approval
Feature: PendingApproval
  As a ...
  I want to ...
  So that ...

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

  Scenario: Verify submitted by details are populated
