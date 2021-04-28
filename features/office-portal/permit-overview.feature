@permit-overview
Feature: PermitOverview
  As a ...
  I want to ...
  So that ...

  Scenario: Verify PRE will be activated and auto terminated at the specified time [Office portal]
    Given I create PRE via service with static env
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I sleep for 3 seconds
    And I check the checkbox near the first permit in the list
    And I click on View Permit button
    And I sleep for 5 seconds
    Then I check the element value "Test Automation" by title "Reason for Entry"

  Scenario: An Entrant's rank, name, second name should be displayed in the ESE logs table [Office portal]
    Given I create submit_enclose_space_entry via service with static env
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I click on Add Filter button
    And I select filter value with permit type "Enclosed Spaces Entry"
    And I sleep for 3 seconds
    And I check the checkbox near the first permit in the list
    And I click on View Permit button
    And I check that Entry log is present
    And I check all headers of Entry Log table without toxic gas on portal
    And I check rank and full name of Entrant without toxic "A 2/O"

