@lng-crel
Feature: LNGCREL
  As a ...
  I want to ...
  So that ...

  Scenario: The log should display entries with the correct date
    Given I change ship local time to -11 GMT
    When  I submit a current CRE permit via service
    And I add new entry "A 2/O" CRE
    And I sleep for 10 seconds
    And I acknowledge the new entry log cre via service
    And I save permit date on Dashboard LOG
    When I terminate the PRE permit via service
    And I sleep for 10 seconds
    Then I change ship local time to +12 GMT
    When  I submit a current CRE permit via service
    And I add new entry "A 2/O" CRE
    And I sleep for 10 seconds
    And I acknowledge the new entry log cre via service
    When I launch sol-x portal dashboard
    And I sleep for 5 seconds
    And I go to CRE log in dashboard
    Then I check permit date on Dashboard LOG

  Scenario: Entrant counter in Dashboard is updating
    Given  I submit a current CRE permit via service
    And I add new entry "A 2/O,3/O,A 3/O,4/O" CRE
    And I sleep for 10 seconds
    And I acknowledge the new entry log cre via service
    When I launch sol-x portal dashboard
    And I sleep for 5 seconds
    And I check number 4 of entrants on dashboard
    When I signout entrants "A 2/O"
    And I sleep for 10 seconds
    And I check number 3 of entrants on dashboard
    And I terminate the PRE permit via service


