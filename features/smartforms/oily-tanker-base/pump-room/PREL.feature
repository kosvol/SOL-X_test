@PREL
Feature: PumpRoomEntry
    As a ...
    I want to ...
    So that ...

    Scenario: PRE Dashboard Gas reading pop up should have a independent close option
        Given I launch sol-x portal
        When I submit a current CRE permit via service
        And I sleep for 3 seconds
        And I add new entry "A 2/O" CRE
        And I sleep for 3 seconds
        And I acknowledge the new entry log cre via service
        And I sleep for 5 seconds
        And I add new entry "3/O,A 3/O" CRE with different gas readings
        And I sleep for 20 seconds
        Then I should see alert message
