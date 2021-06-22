@fsu-created-permits-to-work
Feature: CreatedPermitToWork
    As a ...
    I want to ...
    So that ...

    Background:
        Given I switch vessel to FSU

    @sol-6981
    Scenario Outline: Verify Save button disable and Close button enable for these ranks in EIC Certificate
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin via service for rank C/O
        And I select Use of ODME in Manual Mode permit
        And I select Use of ODME in Manual Mode permit for level 2
        And I navigate to section 4b
        And I select yes to EIC
        And I click on back arrow
        When I navigate to "Created" screen for forms
        And I want to edit the newly created permit
        And I enter pin via service for rank <rank>
        And I navigate to section 4b
        And I click on create EIC certification button
        And I should see competent person sign button disabled
        And I should see issuing authority sign button disabled
        And I should see Save EIC button disabled
        And I should see Close button enabled

        Examples:
            | rank |
            | 3/E  |
            | FTR  |
            | PMN  |
            | 4/E  |

    @sol-6981
    Scenario Outline: Verify EIC certification signature component for issuing authority for MAS
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin via service for rank C/O
        And I select Use of ODME in Manual Mode permit
        And I select Use of ODME in Manual Mode permit for level 2
        And I navigate to section 4b
        And I select yes to EIC
        And I click on back arrow
        When I navigate to "Created" screen for forms
        And I want to edit the newly created permit
        And I enter pin via service for rank <rank>
        And I navigate to section 4b
        And I click on create EIC certification button
        And I click on sign button for issuing authority
        And I enter pin via service for rank <rank>
        And I sign on canvas
        And I set time
        Then I should see signed details
        And I should see competent person sign button disabled
        And I should see Save EIC and Close button enabled

        Examples:
            | rank |
            | MAS  |

    @sol-6981
    Scenario Outline: Verify EIC certification signature component for issuing authority for other ranks
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin via service for rank C/O
        And I select Use of ODME in Manual Mode permit
        And I select Use of ODME in Manual Mode permit for level 2
        And I navigate to section 4b
        And I select yes to EIC
        And I click on back arrow
        When I navigate to "Created" screen for forms
        And I want to edit the newly created permit
        And I enter pin via service for rank <rank>
        And I navigate to section 4b
        Then I should see EIC section with fields enabled
        When I select yes to EIC
        And I click on create EIC certification button
        And I click on sign button for issuing authority
        And I enter pin via service for rank <rank>
        And I sign on canvas
        And I set time
        Then I should see signed details
        And I should see competent person sign button disabled
        And I should see Save EIC and Close button enabled

        Examples:
            | rank  |
            | A/M   |
            | C/E   |
            | A C/E |

    @sol-6981
    Scenario Outline: Verify EIC certification signature component for competent person
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin via service for rank C/E
        And I select Use of ODME in Manual Mode permit
        And I select Use of ODME in Manual Mode permit for level 2
        And I click on back arrow
        When I navigate to "Created" screen for forms
        And I want to edit the newly created permit
        And I enter pin via service for rank <rank>
        And I navigate to section 4b
        Then I should see EIC section with fields enabled
        When I select yes to EIC
        And I click on create EIC certification button
        And I click on sign button for competent person
        And I enter pin via service for rank <rank>
        And I sign on canvas
        And I set time
        Then I should see signed details
        And I should see issuing authority sign button disabled
        And I should see Save EIC and Close button enabled

        Examples:
            | rank  |
            | C/O   |
            | A C/O |
            | 2/E   |
            | A 2/E |