@permit-overview
Feature: PermitOverview
  As a ...
  I want to ...
  So that ...

  Scenario: Verify the standard PTW form contains all sections (9)
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the form contains 9 sections

  Scenario: Verify users can print the final copy of a form
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the Print Permit button at the bottom bar

  #Need to terminate the OA form
   # Scenario: Verify the "Approved date" is displayed at the bottom of the OA PTW form (5460)
   # Given I terminate permit submit_enclose_space_entry via service with 9015 user on the auto vessel
   # When I log in to the Office Portal
   # And I select the "Auto" vessel
   # And I select the recently terminated form
   # And I click on View Permit button
   # And I should see This Permit Has been approved on label with the correct date