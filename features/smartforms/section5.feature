@section5RA
Feature: Section5RA
  As a ...
  I want to ...
  So that ...

  Scenario: Verify signature component is deleted after removing Roles & Responsibilities from drop down
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 5

  Scenario: Verify user can see a list of roles

  Scenario: Verify user can sign on responsiblity and reflected as roles for the crew