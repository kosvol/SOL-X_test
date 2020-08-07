@section3DDRA
Feature: Section3DDRA
  As a ...
  I want to ...
  So that ...

  # Scenario: Initialize the clock for automation
  #   Given I launch sol-x portal without unlinking wearable
  #
  #   And I navigate to create new permit

  Scenario Outline: Verify location stamping on signature section 3d as RA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I fill up section 1
    And I navigate to section 3d
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign DRA section 3d with RA pin 1212
    Then I should see signed details
    And I should see location <location_stamp> stamp

    Examples:
      | user         | zoneid                     | mac               | location_stamp   |
      | SIT_SOLX0012 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom |

  Scenario Outline: Verify only RA can sign on section 3d for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin <pin>
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 3d
    And I sign DRA section 3d with RA pin <pin>
    Then I should see signed details

    Examples:
      | level_one_permit               | level_two_permit                                                           | rank                      | pin  |
      | Hotwork                        | Hot Work Level-2 in Designated Area                                        | Addtional Master          | 1212 |
      | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Chief Officer             | 5912 |
      | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                      | Additional Chief Officer  | 5555 |
      # # | Working Aloft/Overside                    | Working Aloft / Overside                                                   | Second Officer             | 5545 |
      # # | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                                | Additional Second Officer  | 7777 |
      # # | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                      | Chief Engineer             | 7507 |
      # # | Helicopter Operations                     | Helicopter Operation                                                       | Additional Chief Engineer  | 0110 |
      | Rotational Portable Power Tool | Use of Portable Power Tools                                                | Second Engineer           | 1313 |
      # # | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                         | Additional Second Engineer | 1414 |
      | Cold Work                      | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard    | Electro Technical Officer | 1717 |
      # # | Working on Deck During Heavy Weather      | Working on Deck During Heavy Weather                                       | Additional Second Engineer | 1414 |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Electro Technical Officer | 1717 |

  Scenario Outline: Verify only RA can sign on section 3d for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 5912
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration less than 2 hours
    And I navigate to section 3d
    And I sign DRA section 3d with RA pin 5912
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
    And I fill up section 1
    And I navigate to section 3d
    And I sign DRA section 3d with non RA pin <non_ra_pin>
    Then I should see not authorize error message
    # And I should see location stamp pre-selected

    Examples:
      | level_one_permit                                              | level_two_permit                                   | ra_rank                    | pin  | non_ra_pin |
      | Hotwork                                                       | Hot Work Level-2 in Designated Area                | Addtional Master           | 1212 | 1111       |
      | Hotwork                                                       | Hot Work Level-1 (Loaded & Ballast Passage)        | Chief Officer              | 5912 | 8888       |
      | Enclosed Spaces Entry                                         | Enclosed Spaces Entry                              | Additional Chief Officer   | 5555 | 9999       |
      | Working Aloft/Overside                                        | Working Aloft / Overside                           | Second Officer             | 5545 | 1010       |
      | Work on Pressure Pipeline/Vessels                             | Work on pressure pipelines/pressure vessels        | Additional Second Officer  | 7777 | 1616       |
      | Personal Transfer By Transfer Basket                          | Personnel Transfer by Transfer Basket              | Chief Engineer             | 7507 | 4092       |
      | Helicopter Operations                                         | Helicopter Operation                               | Additional Chief Engineer  | 0110 | 1515       |
      # | Rotational Portable Power Tool            | Use of Portable Power Tools                                                | Second Engineer            | 1313 | 2323       |
      | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage | Additional Second Engineer | 1414 | 2424       |
      # | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard    | Electro Technical Officer  | 1717 | 1818       |
      | Working on Deck During Heavy Weather                          | Working on Deck During Heavy Weather               | Additional Second Engineer | 1414 | 4236       |
  # | Critical Equipment Maintenance            | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Electro Technical Officer  | 1717 | 2121       |
  # | Critical Equipment Maintenance            | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Electro Technical Officer  | 1717 | 1919       |

  Scenario Outline: Verify non RA cannot sign on section 3d for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 5912
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration less than 2 hours
    And I navigate to section 3d
    And I sign DRA section 3d with non RA pin 0220
    Then I should see not authorize error message
    # And I should see location stamp pre-selected

    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |