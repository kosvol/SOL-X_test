@link-25-wearables
Feature: LocationTracking
    As a ...
    I want to ...
    So that ...

    Scenario: Verify max wearable logins display correct total number of users
        When I launch sol-x portal without unlinking wearable
        Then I should see 25 crews link to dashboard
        And I unlink all crew from wearable