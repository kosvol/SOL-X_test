@smart-forms-permission
Feature: SmartFormsPermission
  As a ...
  I want to ...
  So that ...

  @test
  Scenario: Verify permits filter displaying the right counts on smartform screen
    Given I switch vessel to COT
    When I launch sol-x portal without unlinking wearable
    Then I should see permits match backend results

  Scenario Outline: Verify pending approval permit filter listing match counter in smart form
    Given I launch sol-x portal without unlinking wearable
    And I click on <filter> filter
    Then I should see <filter> permits listing match counter

    Examples:
      | filter             |
      | pending approval   |
      | update needed      |
      | active             |
      | pending withdrawal |

  Scenario Outline: Verify only RA can create permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank <rank>
    Then I should see section 0 screen

    Examples:
      | rank  |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | ETO   |

  Scenario Outline: Verify non RA cannot create permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank <rank>
    Then I should see not authorize error message

    Examples:
      | rank  | pin  |
      | MAS   | 1111 |
      # | 4/O    | 1010 |
      | D/C   | 2317 |
      # | 3/E    | 4685 |
      | A 3/E | 6727 |
      #     | 4/E    | 1311 |
      #     | A 4/E  | 0703 |
      | BOS   | 1018 |
      | PMN   | 4421 |
      | A/B   | 6316 |
  # | O/S    | 7669 |
  # | OLR    | 0450 |

  Scenario: Verify user can see a list of available PTW form
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    Then I should see a list of available forms for selections
      | Cold Work                                                    |
      | Critical Equipment Maintenance                               |
      | Enclosed Spaces Entry                                        |
      | Helicopter Operations                                        |
      | Hot Work                                                     |
      | Personnel Transfer By Transfer Basket                        |
      | Rigging of Gangway & Pilot Ladder                            |
      | Rotational Portable Power Tools                              |
      | Underwater Operations                                        |
      | Use of non-intrinsically safe Camera                         |
      | Use of ODME in Manual Mode                                   |
      | Work on Electrical Equipment and Circuits – Low/High Voltage |
      | Work on Pressure Pipeline/Vessels                            |
      | Working Aloft/Overside                                       |
      | Working on Deck During Heavy Weather                         |

  Scenario Outline: Verify user see the correct second level permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    When I select <permit> permit
    Then I should see second level permits details

    Examples:
      | permit                          |
      | Cold Work                       |
      | Critical Equipment Maintenance  |
      | Hot Work                        |
      | Rotational Portable Power Tools |
      | Underwater Operations           |

  Scenario: Verify user can navigate back to permit selection screen after navigating to level 2 permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I navigate back to permit selection screen
    Then I should see smart form landing screen