@section1
Feature: NonOfficeApprovalPermits
  As a ...
  I want to ...
  So that ...

  Scenario: Verify permits details are pre-filled
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit to work
    And I enter RA pin 1212
    And I select a any permits
    Then I should see permit details are pre-filled
    And I tear down created form

  Scenario: Verify sea state dropdown input fields are correct
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit to work
    And I enter RA pin 1212
    And I select a any permits
    Then I should see a list of sea states
      | 0 : Calm (glassy)     |
      | 1 : Calm (rippled)    |
      | 2 : Smooth (wavelets) |
      | 3 : Slight            |
      | 4 : Moderate          |
      | 5 : Rough             |
      | 6 : Very Rough        |
      | 7 : High              |
      | 8 : Very High         |
      | 9 : Phenomenal        |
    And I tear down created form

  Scenario: Verify wind force dropdown input fields are correct
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit to work
    And I enter RA pin 1212
    And I select a any permits
    Then I should see a list of wind forces
      | 0 : Calm             |
      | 1 : Light Air        |
      | 2 : Light Breeze     |
      | 3 : Gentle Breeze    |
      | 4 : Moderate Breeze  |
      | 5 : Fresh Breeze     |
      | 6 : Strong Breeze    |
      | 7 : Near Gale        |
      | 8 : Gale             |
      | 9 : Strong Gale      |
      | 10 : Storm           |
      | 11 : Violent Storm   |
      | 12 : Hurricane Force |
    And I tear down created form

  Scenario: Verify there is no Previous button
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit to work
    And I enter RA pin 1212
    And I select a any permits
    Then I should not see save and previous button exists
    And I tear down created form

  Scenario Outline: Verify question input field exists
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit to work
    And I enter RA pin 1212
    And I select Critical Equipment Maintenance permit
    And I select <permit> permit for level 2
    Then I should see maintenance duration section and require text
    And I tear down created form

    Examples:
      | permit                                                                                        |
      | Maintenance on Anchor                                                                         |
      | Maintenance on Emergency Fire Pump                                                            |
      | Maintenance on Emergency Generator                                                            |
      | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment                    |
      | Maintenance on Fire Detection Alarm System                                                    |
      | Maintenance on Fixed Fire Fighting System                                                     |
      | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel                         |
      | Maintenance on Life/Rescue Boats and Davits                                                   |
      | Maintenance on Lifeboat Engine                                                                |
      | Maintenance on Critical Equipment - Magnetic Compass                                          |
      | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device                         |
      | Maintenance on Critical Equipment - Main Propulsion System - Shutdown Alarm & Tripping Device |
      | Maintenance on Oil Discharging Monitoring Equipment                                           |
      | Maintenance on Oil Mist Detector Monitoring System                                            |
      | Maintenance on Oily Water Separator                                                           |
      | Maintenance on P/P Room Gas Detection Alarm System                                            |
      | Maintenance on Radio Battery                                                                  |

  # Scenario: Verify question input field does not exists in permits
  # Scenario: Verify created permit is under Created Permit to Work
  # Scenario: Verify created permit data matched on edit screen

  # Scenario: Verify screen text

  Scenario: Verify there is no Save and Previous button
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit to work
    And I enter RA pin 1212
    And I select a any permits
    Then I should not see save and previous button exists
    And I tear down created form

