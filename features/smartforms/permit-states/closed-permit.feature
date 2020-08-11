@closed-permit
Feature: ClosedPermit
  As a ...
  I want to ...
  So that ...

  Scenario: Verify termination date is display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Rigging of Pilot/Combination Ladder permit
    And I select Rigging of Pilot/Combination Ladder permit for level 2
    # And I fill ROL permit
    And I press next from section 1
    Then I submit permit for Master Approval
    When I click on back to home
    And I set rol permit to active state with 1 duration
    And I click on active filter
    And I terminate the permit
    Then I should see termination date display
