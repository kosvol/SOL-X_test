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
