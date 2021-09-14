@fsu-section-0
Feature: LNGSmartFormsPermission
    As a ...
    I want to ...
    So that ...

    Scenario Outline: CE and Master can ask for update on all permit for FSU with duration more than 2 hours
        Given I launch sol-x portal without unlinking wearable
        When I navigate to create new permit
        And I enter pin for rank C/O
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I fill section 1 of maintenance permit with duration more than 2 hours
        And I navigate to section 2
        Then I should see correct approval details for maintenance duration more than 2 hours
        When I press next for 4 times
        And I sign DRA section 3d with C/O as valid rank
        When I press next for 1 times
        Then I should see correct checklist Critical Equipment Maintenance Checklist pre-selected
        When I press next for 1 times
        And I sign checklist with C/O as valid rank
        And I press next for 2 times
        And I select 1 role from list
        And I sign on role
        And I press next for 1 times
        And I submit permit for Master Review
        And I click on back to home
        And I click on pending approval filter
        And I set oa permit to office approval state manually
        And I navigate to OA link
        And I approve oa permit via oa link manually
        And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
        And I click on pending approval filter
        Then I should see Master Approval button
        When I click on permit for master approval
        And I enter pin for rank <rank>
        And I navigate to section 7
        Then I should see Activate Permit to Work button enabled

        Examples:
            | level_one_permit               | level_two_permit                          | rank |
            | Critical Equipment Maintenance | Maintenance on Fixed Gas Detection System | C/E  |

    Scenario: Verify ROL can be approved by CE
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin for rank C/E
        And I select Rigging of Gangway & Pilot Ladder permit
        And I select NA permit for level 2
        When I press next for 1 times
        And I submit permit for Master Approval
        And I click on back to home
        And I click on pending approval filter
        And I open a permit pending Master Approval with C/E rank
        And I press next for 1 times
        And I select rol permit active duration 1 hour
        And I should see ROL submit button enabled

    Scenario: Verify CE can request for update for ROL
        Given I launch sol-x portal without unlinking wearable
        When I navigate to create new permit
        And I enter pin for rank C/E
        And I select Rigging of Gangway & Pilot Ladder permit
        And I select NA permit for level 2
        And I press next for 1 times
        And I submit permit for Master Approval
        And I click on back to home
        And I click on pending approval filter
        And I open a permit pending Master Approval with C/E rank
        And I press next for 1 times
        And I select rol permit active duration 1 hour
        Then I should see rol updates needed button enabled

    Scenario: Two LNG forms to be dispalyed in maintenance permit
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin for rank C/O
        When I select Critical Equipment Maintenance permit
        Then I should see two additional permits

    Scenario Outline: CE and Master can approve on all permit for FSU
        Given I launch sol-x portal without unlinking wearable
        When I navigate to create new permit
        And I enter pin for rank C/O
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I fill section 1 of maintenance permit with duration less than 2 hours
        And I navigate to section 2
        Then I should see correct approval details for maintenance duration less than 2 hours
        When I press next for 4 times
        And I sign DRA section 3d with C/O as valid rank
        When I press next for 1 times
        Then I should see correct checklist Critical Equipment Maintenance Checklist pre-selected
        When I press next for 1 times
        And I sign checklist with C/O as valid rank
        And I press next for 2 times
        And I select 1 role from list
        And I sign on role
        And I press next for 1 times
        And I submit permit for Master Approval
        And I click on back to home
        And I click on pending approval filter
        Then I should see Master Approval button
        When I click on permit for master approval
        And I enter pin for rank <rank>
        And I navigate to section 7
        Then I should see approve and request update buttons

        Examples:
            | level_one_permit               | level_two_permit                                   | pin  | rank |
            | Critical Equipment Maintenance | Maintenance on Emergency Shutdown for Cargo System | 8248 | C/E  |

    Scenario Outline: CE and Master can ask for update on all permit for FSU with duration less than 2 hours
        Given I launch sol-x portal without unlinking wearable
        When I navigate to create new permit
        And I enter pin for rank C/O
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I fill section 1 of maintenance permit with duration less than 2 hours
        And I navigate to section 2
        Then I should see correct approval details for maintenance duration less than 2 hours
        When I press next for 4 times
        And I sign DRA section 3d with C/O as valid rank
        When I press next for 1 times
        Then I should see correct checklist Critical Equipment Maintenance Checklist pre-selected
        When I press next for 1 times
        And I sign checklist with C/O as valid rank
        And I press next for 2 times
        And I select 1 role from list
        And I sign on role
        And I press next for 1 times
        And I submit permit for Master Approval
        And I click on back to home
        And I click on pending approval filter
        Then I should see Master Approval button
        When I click on permit for master approval
        And I enter pin for rank <rank>
        And I navigate to section 7
        Then I should see approve and request update buttons

        Examples:
            | level_one_permit               | level_two_permit                          | pin  | rank |
            | Critical Equipment Maintenance | Maintenance on Fixed Gas Detection System | 8248 | C/E  |

    Scenario Outline: CE and MAS can ask for update on all permit for FSU with duration more than 2 hours Updates needed button
        Given I launch sol-x portal without unlinking wearable
        When I navigate to create new permit
        And I enter pin for rank C/O
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I fill section 1 of maintenance permit with duration more than 2 hours
        And I navigate to section 2
        Then I should see correct approval details for maintenance duration more than 2 hours
        When I press next for 4 times
        And I sign DRA section 3d with C/O as valid rank
        When I press next for 1 times
        Then I should see correct checklist Critical Equipment Maintenance Checklist pre-selected
        When I press next for 1 times
        And I sign checklist with C/O as valid rank
        And I press next for 2 times
        And I select 1 role from list
        And I sign on role
        And I press next for 1 times
        And I submit permit for Master Review
        And I click on back to home
        And I click on pending approval filter
        When I click on permit for master approval
        And I enter pin for rank <rank>
        And I navigate to section 6
        Then I should see Updates Needed button enabled

        Examples:
            | level_one_permit               | level_two_permit                            | rank |
            | Critical Equipment Maintenance | Maintenance on Fixed Gas Detection System   | C/E  |
            | Critical Equipment Maintenance | Maintenance on Fixed Gas Detection System   | MAS  |

