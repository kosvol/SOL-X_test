@op-email-verification-page
Feature: Office Portal Email Verification Page

  Scenario: Verify user should see the login page when click Cancel before entering an Email
    Given EmailVerification is opened
    And EmailVerification click Cancel
    Then OfficeLogin should see all the Login page attributes

  Scenario: Verify the correct error message when click Send Code with the Email field empty
    Given EmailVerification is opened
    When EmailVerification click Send verification code
    Then EmailVerification should see the error message below the heading
      | heading  | message                       |
      | Email    | This information is required. |

  Scenario Outline: Verify the correct error message when enter an invalid Email
    Given EmailVerification is opened
    And EmailVerification enter email "<example>"
    And EmailVerification click Send verification code
    Then EmailVerification should see the error message below the heading
      | heading | message                             |
      | Email   | Please enter a valid email address. |
    Examples:
      |example       |
      |test          |
      |test@         |
      |test@.com     |
      |test.test.com |
      |test@@test.com|
      |test@test/com |

  Scenario: Verify new elements appear when enter a valid email and click Send code
    Given EmailVerification is opened
    When EmailVerification enter email "ksergeenko@ipolecat.com"
    And EmailVerification click Send verification code
    Then EmailVerification should see the email "ksergeenko@ipolecat.com" entered
    And EmailVerification should see new elements

  Scenario: Verify user should see the login page when click Cancel after entering a valid Email
    Given EmailVerification is opened
    When EmailVerification enter email "ksergeenko@ipolecat.com"
    And EmailVerification click Send verification code
    And EmailVerification wait until the "verification_code" field exists
    And EmailVerification click Cancel
    Then OfficeLogin should see all the Login page attributes

  Scenario: Verify the correct error message when click Verify Code with the Code field empty
    Given EmailVerification is opened
    When EmailVerification enter email "ksergeenko@ipolecat.com"
    And EmailVerification click Send verification code
    And EmailVerification click Verify code
    Then EmailVerification should see the error message below the heading
      | heading      | message                       |
      | Verification | This information is required. |

  Scenario: Verify the correct error message when enter an incorrect verification code
    Given EmailVerification is opened
    When EmailVerification enter email "ksergeenko@ipolecat.com"
    And EmailVerification click Send verification code
    And EmailVerification enter verification code "code"
    And EmailVerification click Verify code
    Then EmailVerification should see the error message below the heading
      | heading | message                                   |
      | Account | That code is incorrect. Please try again. |

  Scenario: Verify user should see the Email verification page before entering an email if do any changes to the email entered
    Given EmailVerification is opened
    When EmailVerification enter email "ksergeenko@ipolecat.com"
    And EmailVerification click Send verification code
    And EmailVerification wait until the "verification_code" field exists
    And EmailVerification remove the last character from the Email
    Then EmailVerification should see all the page attributes