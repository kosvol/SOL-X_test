@permit-list
Feature: PermitList
  As a ...
  I want to ...
  So that ...

  Scenario: Verify vessels are displayed in alphanumeric order (3582)
@ska
  Scenario: Verify the vessel name is displayed at the top bar and permits list after selecting (3579)
    Given I log in to the Office Portal
    When I select the "sit" vessel
    Then I should see the vessel name at the top bar and permits list

  Scenario: Verify user is redirected to the Home screen after pressing the Home icon or "Cross" button (3580, 5859, 5735)

  Scenario: Verify the last terminated permit appears at the top of the list in the Office Portal (5133)

  Scenario: Verify the stand alone permits (PRE, RoL) are displayed in the Office Portal

  Scenario: Verify the the forms quantity on the vessel card is the same as on the "All Permits" title (3733)

  Scenario: Verify counters are updated after the form termination (3781, 4468)

  Scenario: Verify the permit types list in the filter drop-down (5195, 3747)

  Scenario: Verify permits are filtered properly

  Scenario: Verify users can select a form for review

  Scenario: Verify all forms are selected after check the check box near the "Permit No." title

  Scenario: Verify the several forms are displayed after multi-selection (4479)

  Scenario: Verify the "Load More Permits" button appears when there are more than 100 terminated permits