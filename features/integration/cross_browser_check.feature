@rol-integration
Feature: CrossBrowserRiggingOfLadder
    As a ...
    I want to ...
    So that ...

    @cb-rigging-of-ladder-1
    Scenario: Verify full rol permit from one browser
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin for rank C/O
        And I select Rigging of Gangway & Pilot Ladder permit
        And I select NA permit for level 2
        And I fill rol permit
        And I submit permit for Master Approval
        And I click on back to home
        And I click on pending approval filter
        And I set rol permit to active state with 1 duration
        And I sleep for 3 seconds

    @cb-rigging-of-ladder-2
    Scenario: Verify data persist on another browser
        Given I launch sol-x portal without unlinking wearable
        And I click on active filter
        And I open up active rol permit
        And I enter pin for rank C/O
        Then I should see data persisted on page 1
        And I press next for 1 times
        And I should see data persisted on page 2