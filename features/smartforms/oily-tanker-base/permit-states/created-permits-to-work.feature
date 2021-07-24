@created-permits-to-work
Feature: CreatedPermitToWork
  As a ...
  I want to ...
  So that ...

  # @sol-6981
  # Scenario: Verify EIC certificate Save button work as expected

  # @sol-6981
  # Scenario: Verify EIC certificate Close button work as expected

  # @sol-6981
  # Scenario: Verify RA can Save EIC certificate

  # @sol-6981
  # Scenario Outline: Checklist creator only should not be able to save and sign eic certificate

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
      # | 3/E  |
      # | FTR  |
      | PMN  |
      | 4/E  |
      | MAS  |

  @sol-6981
  Scenario Outline: Verify EIC certification signature component for issuing authority
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin via service for rank C/O
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
    And I click on sign button for issuing authority
    And I enter pin via service for rank <rank>
    And I sign on canvas
    And I set time
    Then I should see signed details
    And I should see competent person sign button disabled
    And I should see Save EIC and Close button enabled

    Examples:
      | rank  |
      # | C/E   |
      | A C/E |

  @sol-6981 @test
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
      | rank |
      # # | C/O   |
      # # | A C/O |
      # | 2/E   |
      # | A 2/E |
      | ETO  |

  Scenario: Verify correct total list of created permit
    Given I launch sol-x portal without unlinking wearable
    When I navigate to "Created" screen for forms
    Then I should see the total permits in CREATED state match backend results

  Scenario: Verify section 6 buttons display are correct
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Use of ODME in Manual Mode permit
    And I select Use of ODME in Manual Mode permit for level 2
    And I click on back arrow
    When I navigate to "Created" screen for forms
    And I want to edit the newly created permit
    And I enter pin 7551
    And I navigate to section 6
    Then I should see previous and not close buttons

  Scenario: Verify created permit data matched on edit screen for Permit Details
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Use of ODME in Manual Mode permit
    And I select Use of ODME in Manual Mode permit for level 2
    And I click on back arrow
    When I navigate to "Created" screen for forms
    And I want to edit the newly created permit
    And I enter pin for rank A/M
    Then I should see correct permit details

  Scenario: Verify created permit is under Created Permit to Work
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I click on back arrow
    When I navigate to "Created" screen for forms
    Then I should see the newly created permit details listed on Created Permits to Work

  Scenario: Verify deleted permit under Created Permit to Work refresh listing after deletion
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I click on back arrow
    When I navigate to "Created" screen for forms
    And I delete the permit created
    Then I should see deleted permit deleted

  Scenario Outline: Verify AGT can add gas reading on section 6 for permit on Created state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 6
    And I sleep for 1 seconds
    And I press the Yes button to enable gas testing
    And I click on back arrow
    And I sleep for 3 seconds
    When I navigate to "Created" screen for forms
    And I edit ptw with rank <rank>
    And I navigate to section 6
    And I sleep for 1 seconds
    Then I should see gas reading section enabled

    Examples:
      | rank  | level_one_permit      | level_two_permit      |
      | MAS   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A/M   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | C/O   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A C/O | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | 2/O   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A 2/O | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | 3/O   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A 3/O | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | C/E   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A C/E | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | 2/E   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A 2/E | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | 3/E   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A 3/E | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | 4/E   | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | A 4/E | Enclosed Spaces Entry | Enclosed Spaces Entry |
      | CGENG | Enclosed Spaces Entry | Enclosed Spaces Entry |

  Scenario Outline: Verify checklist creator can only edit checklist and eic in PTW Created State
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I click on back arrow
    When I navigate to "Created" screen for forms
    And I edit ptw with rank <rank>
    And I navigate to section 4a
    Then I should see checklist selections fields enabled
    When I press next for 1 times
    Then I should see checklist questions fields enabled
    When I press next for 1 times
    And I should see eic selection fields enabled

    Examples:
      | rank  |
      | 3/O   |
      | A 3/O |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | ETO   |