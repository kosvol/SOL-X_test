@non-office-approval-permits
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

# Scenario: Verify there is no Save and Previous button
# Scenario: Verify question input field exists
# Scenario: Verify question input field does not exists in permits
# Scenario: Verify created permit is under Created Permit to Work
# Scenario: Verify created permit data matched on edit screen

