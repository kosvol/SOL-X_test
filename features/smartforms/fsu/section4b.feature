@fsu-section-4b
Feature: LNGSmartFormsPermission
    As a ...
    I want to ...
    So that ...

    Background:
        Given I switch vessel to FSU

    Scenario: EIC certification section 4b competent person label change to CO 2E
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin 2523
        And I select Enclosed Spaces Entry permit
        And I select Enclosed Spaces Entry permit for level 2
        And I navigate to section 4b
        And I select yes to EIC
        And I click on create EIC certification button
        Then I should see competent person label change
        And I switch vessel to LNG

    Scenario Outline: EIC certification section 4b issuing authority to add Master
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin 2523
        And I select Enclosed Spaces Entry permit
        And I select Enclosed Spaces Entry permit for level 2
        And I navigate to section 4b
        And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
        And I select yes to EIC
        And I click on create EIC certification button
        Then I should see issuing authority label change
        When I sign EIC as issuing authority with pin 1111
        And I set time
        And I should see signed details
        Then I should see location <location_stamp> stamp
        And I switch vessel to LNG

        Examples:
            | user         | zoneid                     | mac               | location_stamp |
            | SIT_SOLX0001 | 01EVXD0J3J9ERQG7ZBF51HY4E5 | 00:00:00:00:00:3B | Ballast Pump   |