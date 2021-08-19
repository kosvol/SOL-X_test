@crew-assist
Feature: CrewAssist

  # Background: Given I clear wearable history and active users

  Scenario: Verify alert dialog popup display crew rank,name and location
    Given I clear wearable history and active users
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    Then I should see crew assist popup display crew rank,name and location on dashboard
    And I unlink all crew from wearable

  # @skip
  # Scenario: Verify location pin is red
  #   Given I launch sol-x portal
  #   When I trigger crew assist from wearable
  #   Then I should crew location indicator is red
  #   And I unlink all crew from wearable

  Scenario: Verify multiple dialog show on screen
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    When I trigger second crew assist
    And I should see two crew assist dialogs on dashboard
    And I unlink all crew from wearable

  # @skip
  # Scenario: Verify crew assist dialog display current time ?

  # @skip
  # Scenario: Verify map location pin turn red after triggering crew assist ?

  # @skip
  # Scenario: Verify active permits display on crew assists dialog box

  # @skip
  # Scenario: Versify pending permits display on crew assists dialog box

  Scenario: Verify crew assist dialog should not display on refresh after acknowledging
    Given I launch sol-x portal
    And I trigger crew assist from wearable
    And I acknowledge the assistance with pin 1111
    Then I should not see crew assist dialog
    When I refresh the browser
    Then I should not see crew assist dialog
    And I unlink all crew from wearable

  Scenario: Verify crew assist dialog still display after cancel from pin screen
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    And I acknowledge the assistance with invalid pin 1234
    And I dismiss enter pin screen
    Then I should see crew assist popup display crew rank,name and location on dashboard
    And I unlink all crew from wearable

  Scenario: Verify crew assist dialog cannot be dismissed with invalid pin
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    And I acknowledge the assistance with invalid pin 1234
    Then I should see invalid pin message
    And I unlink all crew from wearable

  Scenario: Verify crew assist dialog dismiss from all other tablet after acknowledge
    Given I launch sol-x portal
    And I launch sol-x portal on another tab
    When I trigger crew assist from wearable
    And I acknowledge the assistance with pin 8383
    Then I should see crew assist dialog dismiss in both tab
    And I unlink all crew from wearable

  Scenario: Verify crew can dismiss from multiple browser after dismiss from wearable
    Given I launch sol-x portal
    And I launch sol-x portal on another tab
    When I trigger crew assist from wearable
    And I dismiss crew assist from wearable
    Then I should see crew assist dialog dismiss in both tab
    And I unlink all crew from wearable
