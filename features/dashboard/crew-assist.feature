@crew-assist
Feature: CrewAssistScenarios

  Scenario: Verify alert dialog popup display crew rank,name and location
    Given I launch sol-x portal
    When I trigger crew assist
    Then I should see crew assist popup display crew rank,name and location on dashboard
    And I unlink all crew from wearable

  Scenario: Verify location pin is green
    Given I launch sol-x portal
    When I trigger crew assist
    Then I should crew location indicator is green
    And I unlink all crew from wearable

  Scenario: Verify multiple dialog show on screen
    Given I launch sol-x portal
    When I trigger crew assist
    When I trigger second crew assist
    And I should see two crew assist dialogs on dashboard
    And I unlink all crew from wearable

  Scenario: Verfiy crew assists dialog can be acknowledge by any crew

  Scenario: Verify crew assist dialog display current time ?

  Scenario: Verify crew assist dialog cannot be dismissed with invalid pin

  Scenario: Verify crew assist dialog dismiss from all other tablet