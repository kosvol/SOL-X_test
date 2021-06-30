@link-25-wearables
Feature: LocationTracking
    As a ...
    I want to ...
    So that ...

    Background:
        Given I clear wearable history and active users

    Scenario: Verify max wearable logins display correct total number of users
        Given I launch sol-x portal without unlinking wearable
        Then I should see 25 crews link to dashboard
        And I unlink all crew from wearable