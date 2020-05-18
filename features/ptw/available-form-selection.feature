@available-form-selection
Feature: FormSelection
  As a ...
  I want to ...
  So that ...

  Scenario: Verify list of PTW forms available for selection
    Given I launch sol-x portal
    When I navigate to "Forms" screen
    And I navigate to create new permit to work
    Then I should see a list of available forms for selections
    | Cold Work Operations |
    | Hot Work Operations  |
    | Enclosed Space Entry |