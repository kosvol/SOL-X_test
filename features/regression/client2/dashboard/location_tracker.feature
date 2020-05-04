@gx
Feature: LocationTracking
  As a ...
  I want to ...
  So that ...

  Scenario: Verify inactive crew count is correct
    Given I launch sol-x portal
    Then I should see inacive crew count is correct
    And I unlink all crew from wearable

  Scenario: Verify active crew count is correct
    Given I launch sol-x portal
    Then I should see acive crew count is correct
    And I unlink all crew from wearable

  Scenario: Verify active crew with location details are correct
    Given I launch sol-x portal
    Then I should see acive crew details
    And I unlink all crew from wearable

  # Scenario: Verify when active crew not link to beacon should not have location shown

  # Scenario: Verify active crew member name longer than 3 chars to display on map

  # Scenario: Verify active crew member location changed

  Scenario: Verify active duration countdown starts at 15s
    Given I launch sol-x portal
    Then I should see countdown starts at 15s
    And I unlink all crew from wearable

  Scenario: Verify active crew last seen status is Just now
    Given I launch sol-x portal
    Then I should see Just now as current active crew
    And I unlink all crew from wearable

  Scenario: Verify active crew member indicator is green below 30s
    Given I launch sol-x portal
    Then I should see activity indicator is green below 30s
    And I unlink all crew from wearable

  Scenario: Verify active crew member indicator is yellow after 30s
    Given I launch sol-x portal
    Then I should see activity indicator is yellow after 30s
    And I unlink all crew from wearable

  # Scenario: Verify active crew member indicator is red after PANIC triggered

  # Scenario: Verify active crew member count is correct on engine room against full ship

  # Scenario: Verify active crew member count is correct on pump room against full ship 

  # Scenario: Verify active crew member count is correct on funnel stack against full ship 

  # Scenario: Verify active crew member count is correct on upper deck against full ship 

  # Scenario: Verify active crew member count is correct on accommodation against full ship 

  # Scenario: Verify active crew member count is correct on nav bridge against full ship 

  # Scenario: Verify active crew member count is correct on all location against full ship 
