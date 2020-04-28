@SOL-3008 @SOL-3099
Feature: Access to office portal
  As ...
  I want to ...
  So that ...

  ### Manual test case; MVP
  Scenario: Verify unique link and password provided to user via email for selected user; MVP method
    Given the unique link and password
    When I click on the email's link
    Then I will be navigated to the portal

  Scenario: Verify user can login successfully with valid password

  Scenario: Verify user session is remember when logging in with Remember Me

  Scenario: Verify user cannot login with an invalid password

  Scenario: Verify user can see all his active vessels after login in alphanumeric ordering

  Scenario: Verify user can see total count of active vessels

  Scenario: Verify user can see total permits for each vessels

  Scenario: Verify user can see duration since last permit is created

  Scenario: Verify user can refresh last permit created duration

  Scenario: Verify user can see month year -> not sure what is this context

  Scenario: Verify user can see permit details after clicking into active vessel

  Scenario: Verify user can see All Forms, Permit to Work Forms and Other Forms total count after clicking into active vessel

  Scenario: Verify user can see Permit to Work Forms only display PTW,DRA,checklists

  Scenario: Verify user can see Other Permits only display Pump Room Entry, Rigging of Ladder

  Scenario: Verify user can see selected permit count

  Scenario: Verify user can clear selected permit

  Scenario: Verify user can see list of permits ordered by descending order on terminated date and alphanumeric

  Scenario: Verify user can load more permit if reaches pagination limit

  Scenario: Verify user can permit details upon permit selection

  ### Manual
  Scenario: Verify user can print permit

  Scenario: Verify user can filter by permit type base on current list ##### might be wrong need to check with dev or product

  Scenario: Verify user can only filter one permit type

  Scenario: Verify user can clear filter type

  ### Seems de-scope
  Scenario: Verify user can view View Pin button if is a captain

  