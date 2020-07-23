@ptw-filter
Feature: PTWFilter

  Scenario: Verify permits filter displaying the right counts
    Given I launch sol-x portal
    Then I should see permits match backend results

  Scenario Outline: Verify pending approval permit filter listing match counter
    Given I launch sol-x portal
    And I click on <filter> filter
    Then I should see <filter> permits listing match counter

    Examples:
      | filter             |
      | pending approval   |
      | update needed      |
      | active             |
      | pending withdrawal |