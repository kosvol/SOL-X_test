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
        And I review and withdraw permit with <rank> rank
        Then I should see competent person label change
        And I switch vessel to LNG

        Examples:
            | permit_types       | permit_payload                 | rank |
            | intrinsical camera | submit_non_intrinsical_camera  | A/M  |
            | underwater         | submit_underwater_simultaneous | C/O  |

    Scenario Outline: EIC section 8 issuing authority to change to Master and CE
        Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to active state
        And I set oa permit to ACTIVE state
        And I launch sol-x portal without unlinking wearable
        And I click on active filter
        And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
        And I review and withdraw permit with A/M rank
        Then I should see issuing authority label change
        When I sign EIC as issuing authority with rank MAS
        And I set time
        And I should see signed details
        Then I should see location <location_stamp> stamp
        And I switch vessel to LNG

        Examples:
            | user         | zoneid                     | mac               | location_stamp                   |
            | SIT_SOLX0001 | 000000YGJ2DC7WQPN532HRVVMV | A0:E6:F8:25:A6:7E | Bridge Electrical Equipment Room |

    Scenario: Switch back to LNG
        Given I switch vessel to LNG