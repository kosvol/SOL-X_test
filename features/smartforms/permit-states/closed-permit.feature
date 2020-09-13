@closed-permit
Feature: ClosedPermit
  As a ...
  I want to ...
  So that ...

  Scenario: Verify termination date is display
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    # And I fill ROL permit
    When I press next for 1 times
    Then I submit permit for Master Approval
    When I click on back to home
    And I set rol permit to active state with 1 duration
    When I click on back to home
    And I click on active filter
    And I terminate the permit
    Then I should see termination date display
