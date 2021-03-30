@section3DDRA
Feature: Section3DDRA
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify signature component do not show blank screen after clicking cancel on pinpad

  Scenario Outline: Verify location stamping on signature section 3d as RA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign DRA section 3d with 9015 as valid pin
    Then I should see signed details
    And I should see location <location_stamp> stamp

    Examples:
      | user          | zoneid                      | mac               | location_stamp |
      | AUTO_SOLX0012 | AUTO_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Aft Station    |

  Scenario Outline: Verify only RA can sign on section 3d for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin <ra_pin>
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3d
    And I sign DRA section 3d with <pin> as valid pin
    Then I should see signed details

    Examples:
      | level_one_permit                                             | level_two_permit                                   | rank                       | ra_pin | pin  |
      | Hot Work                                                     | Hot Work Level-2 in Designated Area                | Master                     | 9015   | 1111 |
      | Hot Work                                                     | Hot Work Level-2 in Designated Area                | Addtional Master           | 9015   | 9015 |
      | Hot Work                                                     | Hot Work Level-1 (Loaded & Ballast Passage)        | Chief Officer              | 8383   | 8383 |
      | Enclosed Spaces Entry                                        | Enclosed Spaces Entry                              | Additional Chief Officer   | 2761   | 2761 |
      | Working Aloft/Overside                                       | Working Aloft / Overside                           | Second Officer             | 6268   | 6268 |
      | Work on Pressure Pipeline/Vessels                            | Work on pressure pipelines/pressure vessels        | Additional Second Officer  | 7865   | 7865 |
      | Personnel Transfer By Transfer Basket                        | Personnel Transfer by Transfer Basket              | Chief Engineer             | 8248   | 8248 |
      | Helicopter Operations                                        | Helicopter Operation                               | Additional Chief Engineer  | 5718   | 5718 |
      | Rotational Portable Power Tools                              | Use of Portable Power Tools                        | Second Engineer            | 2523   | 2523 |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage | Additional Second Engineer | 3030   | 3030 |
      # | Cold Work                                                    | Cold Work - Blanking/Deblanking of Pipelines and Other Openings | Electro Technical Officer  | 0856   | 0856 |
      | Working on Deck During Heavy Weather                         | Working on Deck During Heavy Weather               | 3/O                        | 0159   | 0159 |
      | Working on Deck During Heavy Weather                         | Working on Deck During Heavy Weather               | A 3/O                      | 2674   | 2674 |
      | Working on Deck During Heavy Weather                         | Working on Deck During Heavy Weather               | 4/E                        | 0159   | 1311 |
      | Working on Deck During Heavy Weather                         | Working on Deck During Heavy Weather               | A 4/E                      | 2674   | 0703 |

  Scenario Outline: Verify only RA can sign on section 3d for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3d
    And I sign DRA section 3d with 8383 as valid pin
    Then I should see signed details
    # And I should see location stamp pre-selected

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |

  Scenario Outline: Verify non RA cannot sign on section 3d for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin <pin>
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3d
    And I sign DRA section 3d with <non_ra_pin> as invalid pin
    Then I should see not authorize error message

    Examples:
      | level_one_permit                      | level_two_permit                                                | ra_rank                   | pin  | non_ra_rank | non_ra_pin |
      | Hot Work                              | Hot Work Level-2 in Designated Area                             | Addtional Master          | 9015 | 4/O         | 2637       |
      | Work on Pressure Pipeline/Vessels     | Work on pressure pipelines/pressure vessels                     | Additional Second Officer | 7865 | D/C         | 2317       |
      | Personnel Transfer By Transfer Basket | Personnel Transfer by Transfer Basket                           | Chief Engineer            | 8248 | A 4/O       | 5574       |
      | Helicopter Operations                 | Helicopter Operation                                            | Additional Chief Engineer | 5718 | ETO         | 0856       |
      | Cold Work                             | Cold Work - Blanking/Deblanking of Pipelines and Other Openings | Electro Technical Officer | 0856 | BOS         | 1018       |
  # | Rotational Portable Power Tools                              | Use of Portable Power Tools                                     | Second Engineer            | 2523 | 4/E         | 1311       |
  # | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage              | Additional Second Engineer | 3030 | A 4/E       | 0703       |

  Scenario Outline: Verify non RA cannot sign on section 3d for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3d
    And I sign DRA section 3d with 5574 as invalid pin
    Then I should see not authorize error message

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |

  Scenario Outline: Verify these rank cannot sign off DRA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I sign DRA section 3d with <pin> as invalid pin
    Then I should see not authorize error message

    Examples:
      | rank | pin  |
      | ETO  | 0856 |
      | ELC  | 2719 |
      | PMAN | 4421 |

  Scenario Outline: Verify these rank can sign off DRA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to section 3d
    And I sign DRA section 3d with <pin> as valid pin
    Then I should see signed details

    Examples:
      | rank  | pin  |
      | MAS   | 1111 |
      | A/M   | 9015 |
      | C/O   | 8383 |
      | A C/O | 2761 |
      | 2/O   | 6268 |
      | A 2/O | 7865 |
      | 3/O   | 0159 |
      | A 3/O | 2674 |
      | C/E   | 8248 |
      | A C/E | 5718 |
      | 2/E   | 2523 |
      | A 2/E | 3030 |
      | 3/E   | 4685 |
      | A 3/E | 6727 |
      | 4/E   | 1311 |
      | A 4/E | 0703 |