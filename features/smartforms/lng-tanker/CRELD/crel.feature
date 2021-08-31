@lng-crel
Feature: LNGCREL
  As a ...
  I want to ...
  So that ...

  Scenario: The log should display entries with the correct date
    Given I change ship local time to -11 GMT
    When  I submit a current CRE permit via service
    And I add new entry "A 2/O" CRE
    And I acknowledge the new entry log cre via service
    And I save permit date on Dashboard LOG
    When I terminate the PRE permit via service
    #And I sleep for 10 seconds
    Then I change ship local time to +12 GMT
    When I submit a current CRE permit via service
    And I add new entry "A 2/O" CRE
    And I acknowledge the new entry log cre via service
    And I save permit date on Dashboard LOG
    When I launch sol-x portal dashboard
    And I sleep for 5 seconds
    And I go to CRE log in dashboard
    Then I check permit date on Dashboard LOG

  Scenario: Entrant counter in Dashboard is updating
    Given I submit a current CRE permit via service
    And I add new entry "A 2/O,3/O,A 3/O,4/O" CRE
    And I sleep for 10 seconds
    And I acknowledge the new entry log cre via service
    When I launch sol-x portal dashboard
    And I check number 5 of entrants on dashboard
    When I signout entrants "A 2/O"
    And I check number 4 of entrants on dashboard
    And I terminate the PRE permit via service

  Scenario: Verify CRE permit is terminated after terminating via dashboard popup
    Given I submit a current CRE permit via service
    And I activate CRE form via service
    When I launch sol-x portal dashboard
    And I sleep for 5 seconds
    And I open new dashboard page
    And I sleep for 5 seconds
    And I switch to first tab in browser
    And I navigate to CRE Display
    And I enter pin via service for rank A C/O
    And I enter new entry log
    And I send entry report with 5 optional entrants
    And I switch to last tab in browser
    Then I should see alert message
    And I click terminate new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see red background color
    And I should see Permit Terminated CRE status on screen

  Scenario: CRE Dashboard Gas reading pop up should have a independent close option
    Given I get active PRE permit and terminate
    When I get active CRE permit and terminate
    Then I submit a current CRE permit via service
    And I activate CRE form via service
    When I launch sol-x portal dashboard
    And I sleep for 5 seconds
    And I open new dashboard page
    And I sleep for 5 seconds
    And I switch to first tab in browser
    And I navigate to CRE Display
    And I enter pin via service for rank A C/O
    And I sleep for 5 seconds
    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I acknowledge the new entry log cre via service
    And I sleep for 5 seconds
    And I dismiss gas reader dialog box
    And I enter random entry log with role 2/O
    And I send entry report with 1 optional entrants
    And I sleep for 5 seconds
    And I switch to last tab in browser
    Then I should see alert message
    And I click close new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see alert message

  Scenario: [ESEL] The ESEL is displayed separately from the PREL CREL and independent of it
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I take note of issued date and time
    And I click New Entrant button on Enclose Space Entry PWT
    And Get PWT id
    And I enter new entry log
    And I fill entry report with 1 required entrants
    And I send Report
    And I sleep for 3 seconds
    And I acknowledge the new entry log via service
    Then I submit a current CRE permit via service
    And I add new entry "A 3/O,4/O" CRE
    And I sleep for 10 seconds
    And I acknowledge the new entry log cre via service
    And I open new dashboard page
    And I sleep for 5 seconds
    And I go to ESE log in dashboard
    And I check the entrants "A 3/O,4/O" are not presents in dashboard log

  Scenario: User should be able to see "Change gas readings" pop-up every time when gas readings are changed
    Given I submit a current CRE permit via service
    And I activate CRE form via service
    When I launch sol-x portal dashboard
    And I open new dashboard page
    And I switch to first tab in browser
    And I navigate to CRE Display
    And I enter pin via service for rank A C/O
    And I enter new entry log
    And I send entry report with 5 optional entrants
    And I dismiss gas reader dialog box
    And I acknowledge the new entry log cre via service
    And I click on back arrow
    And I enter random entry log
    And I send entry report with 1 optional entrants
    And I dismiss gas reader dialog box
    And I switch to last tab in browser
    Then I should see alert message
