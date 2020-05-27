@crew-list
Feature: CrewList
  As a ...
  I want to ...
  So that ...

  Scenario: Verify table column headers are correct
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see correct column headers

  Scenario: Verify crew count match
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see total crew count match inactive crew

# Scenario: Verify crew latest location is updated on crew listing
# Scenario: Verify total crew member count is display
