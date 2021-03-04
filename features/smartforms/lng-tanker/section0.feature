@lng-section-0
Feature: LNGSmartFormsPermission
    As a ...
    I want to ...
    So that ...

    Scenario: Two LNG forms to be dispalyed in maintenance permit
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin 9015
        When I select Critical Equipment Maintenance permit
        Then I should see two additional permits

    Scenario Outline: CE and Master can approve on all permit for FSU
        Given I launch sol-x portal without unlinking wearable
        When I navigate to create new permit
        And I enter pin 9015
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I fill section 1 of maintenance permit with duration more than 2 hours
        And I navigate to section 2
        Then I should see correct approval details for maintenance duration more than 2 hours
        When I press next for 4 times
        And I sign DRA section 3d with 9015 as valid pin
        When I press next for 1 times
        Then I should see correct checklist Critical Equipment Maintenance Checklist pre-selected
        When I press next for 1 times
        And I sign on checklist with valid 9015 pin
        And I press next for 2 times
        And I select 1 role from list
        And I sign on role
        And I press next for 1 times
        And I submit permit for Master Approval
        And I click on back to home
        And I click on pending approval filter
        Then I should see Master Approval button
        When I click on permit for master approval
        And I enter pin <pin>
        Then I should see navigation dropdown

        Examples:
            | level_one_permit               | level_two_permit                                   | pin  |
            | Critical Equipment Maintenance | Maintenance on Emergency Shutdown for Cargo System | 8248 |

    Scenario Outline: CE and Master can ask for update on all permit for FSU
        Given I launch sol-x portal without unlinking wearable
        When I navigate to create new permit
        And I enter pin 9015
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I fill section 1 of maintenance permit with duration more than 2 hours
        And I navigate to section 2
        Then I should see correct approval details for maintenance duration more than 2 hours
        When I press next for 4 times
        And I sign DRA section 3d with 9015 as valid pin
        When I press next for 1 times
        Then I should see correct checklist Critical Equipment Maintenance Checklist pre-selected
        When I press next for 1 times
        And I sign on checklist with valid 9015 pin
        And I press next for 2 times
        And I select 1 role from list
        And I sign on role
        And I press next for 1 times
        And I submit permit for Master Approval
        And I click on back to home
        And I click on pending approval filter
        Then I should see Master Approval button
        When I click on permit for master approval
        And I enter pin <pin>
        And I navigate to section 6
        Then I should see Updates Needed button enabled


        Examples:
            | level_one_permit               | level_two_permit                          | pin  |
            | Critical Equipment Maintenance | Maintenance on Fixed Gas Detection System | 1111 |
