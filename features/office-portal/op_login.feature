@op_login_page
Feature: Office Portal Login
  Correct credentials for test
  email: qa-test-group@sol-x.co
  password: Solxtester12345!

  Scenario: Verify new login page attributes (Desktop) (7782)
    Given OfficeLogin open page
    Then OfficeLogin should see all the Login page attributes

  Scenario: Verify the correct error message when leave all fields empty (7899)
    Given OfficeLogin open page
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the "Email" field is highlighted in red
    And OfficeLogin should see the "Password" field is highlighted in red
    And OfficeLogin should see the error message below the heading
      | heading  | message                    |
      | Email    | Please enter your Email    |
      | Password | Please enter your password |

  Scenario Outline: Verify the correct error message when enter an invalid Email (7900)
    Given OfficeLogin open page
    When OfficeLogin enter email "<example>"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    And OfficeLogin should see the error message below the heading
      | heading | message                         |
      | Login   | Email or password is incorrect. |
    Examples:
    |example       |
    |test          |
    |test@         |
    |test@.com     |
    |test.test.com |
    |test@@test.com|
    |test@test/com |

  Scenario: Verify the correct error message when enter an unregistered Email (7902)
    Given OfficeLogin open page
    When OfficeLogin enter email "test@test.com"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the error message below the heading
      | heading | message                         |
      | Login   | Email or password is incorrect. |

  Scenario: Verify users should be redirected to the Permit Archive page when enter the correct email and password
    Given OfficeLogin open page
    When OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed

  Scenario: Verify the correct error message when enter a different incorrect password three times (7901, 8046)
    Given OfficeLogin open page
    When OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "test"
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the error message below the heading
      | heading | message                         |
      | Login   | Email or password is incorrect. |
    When OfficeLogin remove password
    And OfficeLogin enter password "1234"
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the error message below the heading
      | heading | message                         |
      | Login   | Email or password is incorrect. |
    When OfficeLogin remove password
    And OfficeLogin enter password "NewPassword"
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the error message below the heading
      | heading | message                         |
      | Login   | Email or password is incorrect. |
    When OfficeLogin remove password
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then OfficeLogin should see the error message below the heading
      | heading | message                                                                          |
      | Login   | Your account is temporarily locked to prevent unauthorized use. Try again later. |

  Scenario: Verify users should be redirected to the email verification page when click Forgot Password (7907)
    Given OfficeLogin open page
    When OfficeLogin click Forgot password
    Then EmailVerification page should be displayed