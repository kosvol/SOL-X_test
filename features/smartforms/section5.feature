@section5
Feature: Section5
  As a ...
  I want to ...
  So that ...

  Scenario: Verify signature component is deleted after removing Roles & Responsibilities from drop down
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    Then I should see 1 role listed
    And I should see Authorized Entrant 1 role
    When I delete 1 role from list
    Then I should see 0 role listed
    And I should not see Authorized Entrant 1 role

  Scenario: Verify signature component is deleted after removing Roles & Responsibilities via cross
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 2 role from list
    Then I should see 2 role listed
    And I should see Authorized Entrant 1 role
    And I should see Authorized Entrant 2 role
    When I delete the role from cross
    Then I should see 1 role listed
    And I should not see Authorized Entrant 1 role
    And I should see Authorized Entrant 2 role

  Scenario: Verify user can see a list of roles
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    Then I should see a list of roles

  Scenario: Verify user can sign on responsiblity and reflected as roles for the crew
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I sign on role
    Then I should see signed role details