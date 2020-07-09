@created-permits-to-work
Feature: CreatedPermitToWork
  As a ...
  I want to ...
  So that ...

  Scenario: Verify created permit is under Created Permit to Work
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to "Created Permits to Work" screen
    Then I should see the newly created permit details listed on Created Permits to Work
    And I tear down created form

  Scenario: Verify created permit data matched on edit screen for Permit Details
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select Use of ODME in Manual Mode permit
    And I select Use of ODME in Manual Mode permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I want to edit the newly created permit
    And I enter RA pin 1212
    Then I should see correct permit details
    And I tear down created form

  Scenario: Verify past created permit should display permit id
    Given I launch sol-x portal
    When I navigate to "Created Permits to Work" screen
    And I edit past created permit
    And I enter RA pin 1212
    Then I should see permit id populated