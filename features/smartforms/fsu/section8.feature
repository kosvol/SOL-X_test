@fsu-section-8
Feature: LNGSmartFormsPermission
    As a ...
    I want to ...
    So that ...

    Background:
        Given I switch vessel to FSU

    Scenario Outline: EIC section 8 competent person label change to CO 2E
        Given I submit permit <permit_payload> via service with 9015 user and set to active state
        And I set oa permit to ACTIVE state
        And I launch sol-x portal without unlinking wearable
        And I click on active filter
        And I terminate permit with <rank> rank and <pin> pin
        Then I should see competent person label change
        And I switch vessel to LNG

        Examples:
            | permit_types | permit_payload                 | rank          | pin  |
            # | intrinsical camera | submit_non_intrinsical_camera | A/M  | 9015 |
            | underwater   | submit_underwater_simultaneous | Chief Officer | 8383 |

    Scenario Outline: EIC section 8 issuing authority to change to Master and CE
        Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to active state
        And I set oa permit to ACTIVE state
        And I launch sol-x portal without unlinking wearable
        And I click on active filter
        And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
        And I terminate permit with A/M rank and 9015 pin
        Then I should see issuing authority label change
        When I sign EIC as issuing authority with pin 1111
        And I set time
        And I should see signed details
        Then I should see location <location_stamp> stamp
        And I switch vessel to LNG

        Examples:
            | user         | zoneid                     | mac               | location_stamp |
            | SIT_SOLX0002 | 01EVXD0J3J9ERQG7ZBF51HY4E5 | 00:00:00:00:00:3B | Ballast Pump   |