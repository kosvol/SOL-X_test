@lng-cred
Feature: LNGCRED
  As a ...
  I want to ...
  So that ...

  Scenario: CRED should not displayed permit terminated when new CRE permit is created
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And Get CRE id
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I activate the current CRE form
    And I navigate to CRE Display
    And I enter pin for rank C/O
    And I should see Permit Activated PRE status on screen
    And I should see green background color
    When I submit a current CRE permit via service
    And I sleep for 30 seconds
    And I should see green background color

  Scenario: [CRED] Just exited entrant can create new entry again api
    Given  I submit a current CRE permit via service
    And I add new entry "A 2/O,3/O,A 3/O"
    And I sleep for 20 seconds
    And I acknowledge the new entry log cre via service
    When I launch sol-x portal without unlinking wearable
    And I navigate to CRE Display
    And I enter pin for rank C/O
    And I should see Permit Activated PRE status on screen
    When I signout entrants "A 2/O"
    And I sleep for 15 seconds
    And I add new entry "A 2/O"
    And I sleep for 20 seconds
    And I acknowledge the new entry log cre via service
    Then I should see entrant count equal 3

  Scenario: CRED Just exited entrant can create new entry again
    Given I submit a current CRE permit via service
    And I launch sol-x portal without unlinking wearable
    And I open the current CRE with status Active. Rank: A C/O
    And Get CRE id
    And I click on back arrow
    And I sleep for 5 seconds
    And I navigate to CRE Display
    And I enter pin for rank C/O
    And I should see Permit Activated PRE status on screen
    And I enter new entry log
    And I fill entry report with 5 optional entrants
    And I send Report
    And I sleep for 20 seconds
    And I acknowledge the new entry log via service
    And I sleep for 3 seconds
    And I click on back arrow
    And I signout the entrant
    Then I should see entrant count equal 5
    And I sleep for 5 seconds
    And I enter new entry log
    And I fill entry report with 1 optional entrants
    And I send Report
    And I sleep for 20 seconds
    And I acknowledge the new entry log via service
    And I click on back arrow
    Then I should see entrant count equal 7

  Scenario: Verify user can't add new entry without an initial gas readings
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And Get CRE id
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I activate the current CRE form
    And I activate CRE form via service
    And I navigate to CRE Display
    And I enter pin for rank C/O
    And I should see Permit Activated PRE status on screen
    And I click on permit tab
    Then I check initial gas readings is not exist
    When I click on back arrow
    And I enter new entry log
    And I fill entry report with 1 optional entrants
    And I just send Report
    And I check report not send