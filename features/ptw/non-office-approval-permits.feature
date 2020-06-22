@non-office-approval-permits
Feature: NonOfficeApprovalPermits
  As a ...
  I want to ...
  So that ...

  @x1
  Scenario: Verify permits details are pre-filled
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit to work
    And I enter RA pin 1212
    And I select a any permits
    Then I should see permit details are pre-filled
    And I tear down created form

  Scenario: Verify sea state dropdown input fields are correct

  Scenario: Verify wind force dropdown input fields are correct

  Scenario: Verify question input field exists
  Scenario: Verify question input field does not exists in permits

