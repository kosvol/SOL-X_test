@ptw
Feature: FormSelection
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify only this rank can create PTW forms
    Given I launch sol-x portal
    When I navigate to "Forms" screen
    And I navigate to create new permit to work
    And I enter pin <pin>
    Then I should see form selection screen

    Examples:
    | rank                        | pin  |
    | Addtional Master            | 1212 |
    | Chief Officer               | 4444 |
    | Additional Chief Officer    | 5555 |
    | Second Officer              | 6666 |
    | Additional Second Officer   | 7777 |
    | Chief Engineer              | 2222 |
    | Additional Chief Engineer   | 0110 |
    | Second Engineer             | 1313 |
    | Additional Second Engineer  | 1414 |
    | Electro Technical Officer   | 1717 |

  # Scenario: Verify user can see a list of available PTW form
  #   Then I should see a list of available forms for selections
  #   | Cold Work Operations |
  #   | Hot Work Operations  |
  #   | Enclosed Space Entry |