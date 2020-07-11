@smart-forms-permission
Feature: SmartFormsPermission
  As a ...
  I want to ...
  So that ...

  Scenario: Verify permits filter displaying the right counts
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    Then I should see permits match backend results

  Scenario Outline: Verify only RA can create permit
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin <pin>
    Then I should see smart form landing screen
    And I tear down created form

    Examples:
      | rank                       | pin  |
      | Addtional Master           | 1212 |
      | Chief Officer              | 5912 |
      | Additional Chief Officer   | 5555 |
      | Second Officer             | 6666 |
      | Additional Second Officer  | 7777 |
      | Chief Engineer             | 9780 |
      | Additional Chief Engineer  | 0110 |
      | Second Engineer            | 1313 |
      | Additional Second Engineer | 1414 |
      | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify non RA cannot create permit
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin <pin>
    Then I should see not authorize error message

    Examples:
      | rank   | pin  |
      | Master | 1111 |
      | 3/O    | 8888 |
      | A 3/O  | 9999 |
      | 4/O    | 1010 |
      | D/C    | 1616 |
      | 3/E    | 4092 |
      | A 3/E  | 1515 |
      | 4/E    | 2323 |
      | A 4/E  | 2424 |
      | BOS    | 1818 |
      | PMN    | 5698 |
      | A/B    | 2121 |
      | O/S    | 1919 |
      | OLR    | 0220 |

  Scenario: Verify user can see a list of available PTW form
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    Then I should see a list of available forms for selections
      | Cold Work                                 |
      | Critical Equipment Maintenance            |
      | Enclosed Spaces Entry                     |
      | Helicopter Operations                     |
      | Hotwork                                   |
      | Personal Transfer By Transfer Basket      |
      | Rigging of Pilot/Combination Ladder       |
      | Rotational Portable Power Tool            |
      | Underwater Operations                     |
      | Use of non-intrinsically safe Camera      |
      | Use of ODME in Manual Mode                |
      | Work on Electrical Equipment and Circuits |
      | Work on Pressure Pipeline/Vessels         |
      | Working Aloft/Overside                    |
      | Working on Deck During Heavy Weather      |
    And I tear down created form

  Scenario Outline: Verify user see the correct second level permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    When I select <permit> permit
    Then I should see second level permits details
    And I tear down created form

    Examples:
      | permit                         |
      | Cold Work                      |
      | Critical Equipment Maintenance |
      | Hotwork                        |
      | Rotational Portable Power Tool |
      | Underwater Operations          |

  Scenario: Verify user can navigate back to permit selection screen after navigating to level 2 permit
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I navigate to level 2 permits
    And I navigate back to permit selection screen
    Then I should see smart form landing screen
    And I tear down created form

# Scenario: Verify after click cancel on pin pad it will navigate back to permit selection screen

# Scenario: Verify user cannot creation using non-existent PIN



