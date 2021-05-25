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
    And I should see Since item on the vessel card
    And I should see Last Permit 0 days ago on the vessel card

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
    Given I terminate permit submit_work_on_pressure_line via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I check the forms number on the vessel card
    Then I should see the same number on the All Permits

  Scenario: Verify the last terminated permit appears at the top of the list in the Office Portal (5133)
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I select filter value with permit type "Permit to Work Forms"
    Then I should see the terminated form at the top of the forms list

  Scenario: Verify counters are updated after the form termination (3781, 4468)
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I remember the current permits quantity
    And I terminate permit submit_enclose_space_entry via service with 9015 user on the auto vessel
    And I refresh the browser
    And I check the forms number on the vessel card
    Then I should see the the form number is updated
    And I should see the same number on the All Permits

  Scenario: Verify the permit types list in the filter drop-down (5195, 3747)
    Given I terminate permit submit_work_on_pressure_line via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I click on Add Filter button
    Then I should the Permit Types list for filter

  #Scenario: Verify permits are filtered properly (3394)

  Scenario: Verify users can select a form for review (4807, 3316)
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I select filter value with permit type "Permit to Work Forms"
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the selected form in a new tab
    And I should see the form contains 9 sections
    And I should see the Print Permit button at the bottom bar

  #Scenario: Verify the stand alone RoL permit is displayed in the Office Portal

  #Scenario: Verify the stand alone PRE permit is displayed in the Office Portal (COT)

  #Scenario: Verify the stand alone CRE permit is displayed in the Office Portal (LNG)

  Scenario: Verify all forms are selected after check the check box near the "Permit No." title
    Given I terminate permit submit_cold_work_clean_spill via service with 9015 user on the auto vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I check the checkbox near the Permit No. title
    Then I should see all the forms are selected
    And I should see the forms quantity on the top bar is the same as on the All Permits title

  Scenario: Verify that the selection for the forms is reset when switching to another vessel or proceeding to the vessel list (5734)
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel
    And I terminate permit submit_cold_work_clean_spill via service with 9015 user on the sit vessel
    When I log in to the Office Portal
    And I select the "Auto" vessel
    And I check the checkbox near the Permit No. title
    Then I should see all the forms are selected
    And I click on the Home icon
    And I select the "Auto" vessel
    Then I should see all the forms are not selected
    And I check the checkbox near the Permit No. title
    Then I should see all the forms are selected
    And I click on the Cross icon
    And I select the "Auto" vessel
    Then I should see all the forms are not selected
    And I check the checkbox near the Permit No. title
    Then I should see all the forms are selected
    And I select the "LNGSIT" vessel
    And I select the "Auto" vessel
    Then I should see all the forms are not selected

#Scenario: Verify the several forms are displayed after multi-selection (4479, 6401)

#Scenario: Verify the "Load More Permits" button appears when there are more than 100 terminated permits (6403)