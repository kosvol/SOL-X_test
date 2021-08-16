@fsu-section-4b
Feature: LNGSmartFormsPermission
    As a ...
    I want to ...
    So that ...

    Scenario: EIC certification section 4b competent person label change to CO 2E
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin for rank 2/E
        And I select Enclosed Spaces Entry permit
        And I select NA permit for level 2
        And I navigate to section 4b
        And I select yes to EIC
        And I click on create EIC certification button
        Then I should see competent person label change

    Scenario Outline: EIC certification section 4b issuing authority to add Master
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin for rank C/E
        And I select Enclosed Spaces Entry permit
        And I select NA permit for level 2
        And I navigate to section 4b
        And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
        And I select yes to EIC
        And I click on create EIC certification button
        Then I should see issuing authority label change
        When I sign EIC as issuing authority with rank MAS
        And I set time
        And I should see signed details
        Then I should see location <location_stamp> stamp

        Examples:
            | user         | zoneid             | mac               | location_stamp   |
            | SIT_SOLX0001 | Z-STBD-BRIDGE-WING | 00:00:00:00:00:19 | Stbd Bridge Wing |

    Scenario Outline: Verify location stamping on signature section for competent person
        Given I launch sol-x portal
        And I navigate to create new permit
        And I enter pin for rank <rank_create>
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I navigate to section 4b
        And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
        And I select yes to EIC
        And I click on create EIC certification button
        Then I sign EIC as competent person with rank <rank>
        And I set time
        And I should see signed details
        Then I should see location <location_stamp> stamp

        Examples:
            | user        | rank  | rank_create | zoneid        | mac               | location_stamp | level_one_permit                | level_two_permit            | checklist                             |
            | SITFSU_0011 | C/O   | C/E         | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |
            | SITFSU_0004 | 2/E   | C/O         | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |
            | SITFSU_0021 | A 2/E | 2/E         | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |

    Scenario Outline: Verify location stamping on signature section for issuing authority
        Given I launch sol-x portal
        And I navigate to create new permit
        And I enter pin for rank <rank_create>
        And I select <level_one_permit> permit
        And I select <level_two_permit> permit for level 2
        And I navigate to section 4b
        And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
        And I select yes to EIC
        And I click on create EIC certification button
        Then I sign EIC as issuing authority with rank <rank>
        And I set time
        And I should see signed details
        Then I should see location <location_stamp> stamp

        Examples:
            | user        | rank  | rank_create | zoneid       | mac               | location_stamp | level_one_permit                | level_two_permit            |
            | TESTUSER04  | C/E   | C/E         | Z-FORECASTLE | 00:00:00:00:00:01 | IG Platform 2  | Rotational Portable Power Tools | Use of Portable Power Tools |
            | SITFSU_0003 | A C/E | C/O         | Z-FORECASTLE | 00:00:00:00:00:01 | IG Platform 2  | Rotational Portable Power Tools | Use of Portable Power Tools |
