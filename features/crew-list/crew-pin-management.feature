Feature: CrewPinManagement
  As a ...
  I want to ...
  So that ...

  Scenario: Crew to receive pin by email 2 weeks before boarding
    Given I launch sol-x portal
    When I navigate to "Crew List" screen

  Scenario: Verify crew pin is hidden before view pin
    Given I launch sol-x portal
    When I navigate to crew List
    Then I should see pin mask

  Scenario: Verify crew pin is shown after tapping on view pin

  Scenario: Verify adhoc crew detail can be added via crew id

  Scenario: Verify adhoc crew is added the next day T+1 ?

  Scenario: Verify existing crew id cannot be added to the voyage
    Given I launch sol-x portal
    When I navigate to crew List
    And I add an existing crew id
    Then I should not be able to add

  Scenario: Email notification will be sent to the assign crew

  Scenario: Verify Captain can add/edit/delete crew id, surname, first name, rank and pin assignment

  Scenario: Crew member does not exists on Compass
