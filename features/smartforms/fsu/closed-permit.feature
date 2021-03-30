@fsu-closed-permit
Feature: LNGClosedPermit
    As a ...
    I want to ...
    So that ...

    Background:
        Given I switch vessel to FSU

    Scenario: CE and Master can withdraw all permit for FSU
        Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
        When I launch sol-x portal without unlinking wearable
        And I click on active filter
        And I click on Submit for Termination
        And I enter pin for rank A/M
        And I submit permit for termination
        And I sign on canvas with valid 9015 pin
        And I click on back to home
        And I click on pending withdrawal filter
        And I terminate the permit with 8248 pin
        And I set time
        And I navigate to "Withdrawn" screen for forms
        Then I should see termination date display
        And I switch vessel to LNG

    Scenario: CE and Master can request for update in pending withdrawal state
        Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
        When I launch sol-x portal without unlinking wearable
        And I click on active filter
        And I click on Submit for Termination
        And I enter pin for rank A/M
        And I submit permit for termination
        And I sign on canvas with valid 9015 pin
        And I click on back to home
        And I click on pending withdrawal filter
        And I request terminating permit to be updated with 8248 pin
        And I request update for permit
        And I click on back to home
        And I click on update needed filter
        And I update permit in pending update state with 8383 pin
        And I switch vessel to LNG

    Scenario: Switch back to LNG
        Given I switch vessel to LNG