@offline-mode
Feature: Offline Mode
  As a ...
  I want to ...
  So that ...

  Scenario: Verify Wifi popup display when during no wifi on section 8 screen
    Given I submit permit submit_work_on_pressure_line via service with 9015 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I terminate permit with A/M rank and 9015 pin
    And I turn off wifi
    Then I should see wifi inconsistent popup display for section 8
    And I turn on wifi

  @debug
  Scenario: Verify wifi restore dialog in section 4b EIC certification
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    And I navigate to section 4b
    And I select yes to EIC
    And I click on create EIC certification button
    Then I should see wifi inconsistent popup display for EIC
    # And I turn on wifi
    Then I should see wifi restore popup display for EIC
    And I turn off wifi

  @debug1
  Scenario: Verify wifi restore dialog in section 6
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    And I navigate to section 6
    Then I should see wifi inconsistent popup display for section 6
    # And I turn on wifi
    Then I should see wifi restore popup display for section 6
    And I turn off wifi

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
    And I turn off wifi

  Scenario: Verify Wifi popup display when during no wifi on EIC certification screen
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    And I navigate to section 4b
    And I select yes to EIC
    And I click on create EIC certification button
    Then I should see wifi inconsistent popup display for EIC
    And I turn off wifi

  Scenario: Verify Wifi popup display when during no wifi on section 6 screen
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    And I navigate to section 6
    Then I should see wifi inconsistent popup display for section 6
    And I turn off wifi

  Scenario: Verify offline popup display when offline on smartform screen
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I turn off wifi
    Then I should see wifi inconsistent popup display for smartform
    And I turn off wifi
