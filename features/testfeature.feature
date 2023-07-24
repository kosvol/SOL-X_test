@test_feature
Feature: LOA test

  Scenario Outline: Verify default ptw creator can create permit (SOL-8337)
    Given SmartForms open page
    And SmartForms click create permit to work
    When PinEntry enter pin for rank "<rank>"
    Then FormPrelude should see select permit type header
    Examples:
      | rank  |
      | A/M   |

  Scenario: Verify non default ptw creator can not create permit (SOL-8337)
    Given SmartForms open page
    And SmartForms click create permit to work
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
