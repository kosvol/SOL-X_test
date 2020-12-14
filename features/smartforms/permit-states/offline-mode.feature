@offline-mode
Feature: Offline Mode
  As a ...
  I want to ...
  So that ...

  Scenario: Verify DRA sub screen loaded fine during offline mode while on created state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin 9015
    And I turn off wifi
    And I navigate to section 3a
    And I click on View Edit Hazard
    Then I should see fields disabled

  Scenario: Verify Wifi popup display when during no wifi on EIC certification screen
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    And I navigate to section 4b
    And I select yes to EIC certification
    Then I should see wifi popup display for EIC

  Scenario: Verify Wifi popup display when during no wifi on section 6 screen
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    And I navigate to section 6
    Then I should see wifi popup display for section 6

  Scenario: Verify offline popup display when offline on smartform screen
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    Then I should see wifi popup display for smartform

