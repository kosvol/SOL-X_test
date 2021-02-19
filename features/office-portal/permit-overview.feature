@permit-overview
Feature: PermitOverview
  As a ...
  I want to ...
  So that ...

  Scenario: Verify the standard PTW form contains all sections (9)
    Given I log in to the Office Portal
    When I select the "lngsit" vessel
    And I select the permit 6
    And I click on View Permit button
    Then I should see the form contains 9 sections

  Scenario: Verify users can print the final copy of a form
    Given I log in to the Office Portal
    When I select the "lngsit" vessel
    And I select the permit 6
    And I click on View Permit button
    Then I should see the Print Permit button at the bottom bar

  Scenario: Verify the "Approved date" is displayed at the bottom of the OA PTW form (5460)
    Given I log in to the Office Portal
    When I select the "lngdev" vessel
    And I select the permit 2
    And I click on View Permit button
    And I should see This Permit Has been approved on label with the correct date