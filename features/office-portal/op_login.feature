@op-login-page
Feature: Office Portal Login Page

  Scenario: Verify new login page attributes (Desktop) (7782)
    Given OfficeLogin open page
    Then OfficeLogin should see all the Login page attributes

  Scenario: Verify the correct error message when leave all fields empty (7899)
    Given OfficeLogin open page
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the "Email" field is highlighted in red
    And OfficeLogin should see the error message "Please enter your Email Address" below the "Email" heading
    And OfficeLogin should see the "Password" field is highlighted in red
    And OfficeLogin should see the error message "Please enter your password" below the "Password" heading

  Scenario Outline: Verify the correct error message when enter an invalid Email (7900)
    Given OfficeLogin open page
    When OfficeLogin enters an "<example>" in the "Email" field
    And OfficeLogin enters an "test" in the "Password" field
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the "Email" field is highlighted in red
    And OfficeLogin should see the error message "Please enter a valid email address." below the "Email" heading
    Examples:
    |example       |
    |test          |
    |test@         |
    |test@.com     |
    |test.test.com |
    |test@@test.com|
    |test@test/com |

  Scenario: Verify the correct error message when enter an incorrect password (7901)
    Given OfficeLogin open page
    When OfficeLogin enters an "valid_creds" in the "Email" field
    And OfficeLogin enters an "test" in the "Password" field
    And OfficeLogin click the Sign in button
    And OfficeLogin should see the error message "Your password is incorrect" below the "Log in" heading

  Scenario: Verify the correct error message when enter an unregistered Email (7902)
    Given OfficeLogin open page
    When OfficeLogin enters an "test@test.com" in the "Email" field
    And OfficeLogin enters an "valid_creds" in the "Password" field
    And OfficeLogin click the Sign in button
    And OfficeLogin should see the error message "We can't seem to find your account" below the "Log in" heading