@pending-approval
Feature: PendingApprovalPermit
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify all screen is in read only mode when open up by any crew while in pending state

  Scenario: Verify view EIC certification exists if EIC certification form not filled
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin 1111
    And I navigate to section 4b
    Then I should see View EIC certification button

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
    And I enter pin 9015
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
    And I click on pending approval filter
    Then I should be able to open permit as master without seeing blank screen

  Scenario: Verify submitted time displayed
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
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