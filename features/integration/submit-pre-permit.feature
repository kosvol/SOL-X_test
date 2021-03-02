@pre-integration
Feature: PREIntegration
    As a ...
    I want to ...
    So that ...

    Scenario: Verify PRE can be terminated manually integration
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new PRE
        And I enter pin 8383
        Then I fill up PRE. Duration 4. Delay to activate 2
        And Get PRE id
        And for pre I submit permit for Officer Approval
        And I getting a permanent number from indexedDB
        Then I activate the current PRE form
        When I navigate to "Scheduled" screen for PRE
        And I should see the current PRE in the "Scheduled" list
        And I click on back arrow
        And I sleep for 120 seconds
        And I navigate to "Active" screen for PRE
        And I should see the current PRE in the "Active PRE" list
        And I click on back arrow
        Then I terminate the PRE
        When I navigate to "Terminated" screen for PRE
        And I should see the current PRE in the "Closed PRE" list