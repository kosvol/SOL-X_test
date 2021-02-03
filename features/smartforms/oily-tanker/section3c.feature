@section3CDRA
Feature: Section3CDRA
  As a ...
  I want to ...
  So that ...

  Scenario: Verify ra user is automatically selected
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3c
    Then I should see dra member prefilled

  Scenario: Verify user can select additional dra team member
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3c
    And I add additional dra member
    Then I should see list of dra member

  Scenario: Verify user can remove specific DRA team member via cross
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3c
    And I add additional dra member
    And I remove one of the member via clicking on cross
    Then I should see dra member removed

  Scenario: Verify user can remove specific DRA team member via deselecting from menu
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3c
    And I add additional dra member
    And I remove one of the member from list
    Then I should see dra member removed

  Scenario: Verify user can see a list of crew sorted descending order by rank
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3c
    And I should see a list of crew

  Scenario: Verify user selection stays selected after toggling through sections
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3c
    And I add additional dra member
    And I press previous for 1 times
    And I press next for 1 times
    Then I should see list of dra member
    And I press next for 1 times
    And I press previous for 1 times
    Then I should see list of dra member
