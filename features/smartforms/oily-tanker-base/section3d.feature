@section3DDRA
Feature: Section3DDRA
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify wearable can be picked up consistently
    Given I clear wearable history and active users
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign on canvas only with valid A/M rank
    Then I should see location of work button enabled
    When I resign with valid A/M rank
    Then I should see location of work button enabled

    Examples:
      | user          | zoneid        | mac               | location_stamp |
      | AUTO_SOLX0019 | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    |

  Scenario Outline: Verify location of work can be manual selected after pre-select via wearable
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign on canvas only with valid A/M rank
    Then I should see location of work button enabled

    Examples:
      | user          | zoneid        | mac               | location_stamp |
      | AUTO_SOLX0019 | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    |

  Scenario: Verify done button is disabled when location of work not filled
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I sign on canvas only with valid C/O rank
    Then I should see done button disabled

  Scenario Outline: Verify location stamping on signature section 3d as RA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign DRA section 3d with C/O as valid rank
    Then I should see signed details
    And I should see location <location_stamp> stamp

    Examples:
      | user          | zoneid        | mac               | location_stamp |
      | AUTO_SOLX0019 | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    |

  Scenario Outline: Verify only DRA signoff can sign on section 3d for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank <created_rank>
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3d
    And I sign DRA section 3d with <rank> as valid rank
    Then I should see signed details

    Examples:
      | level_one_permit                                             | level_two_permit                            | rank  | created_rank |
      | Hot Work                                                     | Hot Work Level-2 in Designated Area         | MAS   | C/O          |
      | Hot Work                                                     | Hot Work Level-2 in Designated Area         | C/O   | C/O          |
      | Hot Work                                                     | Hot Work Level-1 (Loaded & Ballast Passage) | C/O   | C/O          |
      | Enclosed Spaces Entry                                        | NA                                          | A C/O | A C/O        |
      | Working Aloft/Overside                                       | NA                                          | 2/O   | 2/O          |
      | Work on Pressure Pipeline/Vessels                            | NA                                          | A 2/O | A 2/O        |
      | Personnel Transfer By Transfer Basket                        | NA                                          | C/E   | C/E          |
      | Helicopter Operations                                        | NA                                          | A C/E | A C/E        |
      | Rotational Portable Power Tools                              | Use of Portable Power Tools                 | 2/E   | 2/E          |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | NA                                          | A 2/E | A 2/E        |
      | Working on Deck During Heavy Weather                         | NA                                          | 3/O   | 3/O          |
      | Working on Deck During Heavy Weather                         | NA                                          | A 3/O | A 3/O        |
      | Working on Deck During Heavy Weather                         | NA                                          | 3/E   | C/O          |
      | Working on Deck During Heavy Weather                         | NA                                          | A 3/E | C/O          |
      | Working on Deck During Heavy Weather                         | NA                                          | 4/E   | C/O          |
      | Working on Deck During Heavy Weather                         | NA                                          | A 4/E | C/O          |

  Scenario Outline: Verify only RA can sign on section 3d for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3d
    And I sign DRA section 3d with C/O as valid rank
    Then I should see signed details
    # And I should see location stamp pre-selected

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |

  Scenario Outline: Verify non RA cannot sign on section 3d for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank <rank>
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3d
    And I sign DRA section 3d with <non_ra_rank> as invalid rank
    Then I should see not authorize error message

    Examples:
      | level_one_permit                      | level_two_permit                    | rank  | non_ra_rank |
      | Hot Work                              | Hot Work Level-2 in Designated Area | C/O   | 4/O         |
      | Work on Pressure Pipeline/Vessels     | NA                                  | A 2/O | D/C         |
      | Personnel Transfer By Transfer Basket | NA                                  | C/E   | A 4/O       |
      | Helicopter Operations                 | NA                                  | A C/E | ETO         |
  # | Cold Work                             | Cold Work - Blank/Deblanking of Pipelines and Other Openings | ETO   | BOS         |
  # | Rotational Portable Power Tools                              | Use of Portable Power Tools                                     | 2523 | 4/E         |
  # | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage              | 3030 | A 4/E       |

  Scenario Outline: Verify non RA cannot sign on section 3d for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3d
    And I sign DRA section 3d with A 4/O as invalid rank
    Then I should see not authorize error message

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |

  Scenario Outline: Verify these rank cannot sign off DRA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I sign DRA section 3d with <rank> as invalid rank
    Then I should see not authorize error message

    Examples:
      | rank | pin  |
      | ETO  | 0856 |
      | ELC  | 2719 |
      | PMAN | 4421 |

  Scenario Outline: Verify these rank can sign off DRA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I sign DRA section 3d with <rank> as valid rank
    Then I should see signed details

    Examples:
      | rank  | pin  |
      # | MAS   | 1111 |
      # | C/O   | 9015 |
      # | C/O   | 8383 |
      | A C/O | 2761 |
      # | 2/O   | 6268 |
      | A 2/O | 7865 |
      # | 3/O   | 0159 |
      | A 3/O | 2674 |
      # | C/E   | 8248 |
      | A C/E | 5718 |
      # | 2/E   | 2523 |
      | A 2/E | 3030 |
      # | 3/E   | 4685 |
      | A 3/E | 6727 |
      # | 4/E   | 1311 |
      | A 4/E | 0703 |