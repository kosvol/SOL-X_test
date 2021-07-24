@closed-permit
Feature: ClosedPermit
  As a ...
  I want to ...
  So that ...

  Scenario: Verify termination date is display
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click on Submit for Termination
    And I enter pin for rank A/M
    And I submit permit for termination
    And i sign with valid A/M rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I terminate the permit with MAS rank via Pending Withdrawal
    And I set time
    And I navigate to "Withdrawn" screen for forms
    Then I should see termination date display
    And I should be able to view close permit

