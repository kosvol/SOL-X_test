@permit-list
Feature: PermitList
  As a ...
  I want to ...
  So that ...

  Scenario: Verify vessels are displayed in alphanumeric order (3582)
    Given I log in to the Office Portal
    Then I should see vessel cards are in alphanumeric order

  Scenario: Verify the vessel name is displayed at the top bar and permits list after selecting (3579)
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    Then I should see the vessel name at the top bar and permits list

  Scenario: Verify user is redirected to the Home screen after pressing the Home icon or "Cross" icon (3580, 5859, 5735)
    Given I terminate permit submit_enclose_space_entry via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I click on the Home icon
    Then I should see the Vessel List page
    And I select the "Auto" vessel
    And I click on the Cross icon
    Then I should see the Vessel List page
#find out how to reduce the waiting time

  Scenario: Verify the the forms quantity on the vessel card is the same as on the "All Permits" title (3733)
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I check the forms number on the vessel card
    Then I should see the same number on the All Permits

  Scenario: Verify the last terminated permit appears at the top of the list in the Office Portal (5133)
    Given I terminate permit submit_enclose_space_entry via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    Then I should see the terminated form at the top of the forms list
@ska
  Scenario: Verify counters are updated after the form termination (3781, 4468)
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I check the forms number on the vessel card
    And I terminate permit submit_enclose_space_entry via service with 9015 user on the auto vessel
    And I reload the page
    And I check the forms number on the vessel card
    Then I should see the same number on the All Permits
  #find the way how to compare the numbers

  Scenario: Verify the permit types list in the filter drop-down (5195, 3747)
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I click on Add Filter button
    Then I should the Permit Types list for filter

  Scenario: Verify permits are filtered properly

  Scenario: Verify users can select a form for review (4807)
    Given I terminate permit submit_enclose_space_entry via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the selected form in a new tab

  Scenario: Verify the stand alone permits (PRE, RoL) are displayed in the Office Portal

  Scenario: Verify all forms are selected after check the check box near the "Permit No." title
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I check the checkbox near the Permit No. title
    Then I should see all the forms are selected
    And I should see the forms quantity on the top bar is the same as on the All Permits title

  Scenario: Verify the several forms are displayed after multi-selection (4479)

  Scenario: Verify the "Load More Permits" button appears when there are more than 100 terminated permits