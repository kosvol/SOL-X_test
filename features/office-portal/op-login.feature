@op-login-page
Feature: OpLoginPage
    As a ...
    I want to ...
    So that ...

  Scenario: Verify the name of the portal is "Office Portal"(5761)
    Given I launch Office Portal
    Then I should see the "Office Portal" name on the top bar and page body

  Scenario: Verify the warning message appears for an invalid password (3501)
    Given I launch Office Portal
    When I enter a invalid password
    And I click on Log In Now button
    Then I should see the text 'Incorrect Password'

  Scenario: Verify users can log in to the Office Portal (3099)
    Given I launch Office Portal
    When I enter a valid password
    And I click on Log In Now button
    Then I should see the Vessel List page
@ska
  Scenario: Verify the "Remember me" checkbox is editable (3494)
    Given I launch Office Portal
    And I see the checkbox is checked
    When I uncheck the checkbox
    Then I see the checkbox is unchecked