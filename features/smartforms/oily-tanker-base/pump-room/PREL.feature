@PREL
Feature: PumpRoomEntry
    As a ...
    I want to ...
    So that ...

    @wip
    Scenario: PRE Dashboard Gas reading pop up should have a independent close option
        Given I submit a scheduled PRE permit
        And I activate PRE form via service
        When I launch sol-x portal dashboard
        And I sleep for 5 seconds
        And I add new entry "A 2/O" PRE with different gas readings
        And I sleep for 20 seconds
#And I acknowledge the new entry log cre via service
#And I save permit date on Dashboard LOG
#When I terminate the PRE permit via service