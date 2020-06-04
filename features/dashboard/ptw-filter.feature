@ptw-filter
Feature: PTWFilter

  Scenario: Verify permits filter displaying the right counts
    Given I launch sol-x portal
    Then I should see permits match backend results