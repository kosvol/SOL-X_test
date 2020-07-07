@section3DDRA
Feature: Section3DDRA
  As a ...
  I want to ...
  So that ...

  Scenario: Verify reason text field shown after selecting No on DRA carried out

  Scenario: Verify reason text field not shown after selecting Yes on DRA carried out

  Scenario Outline: Verify only RA can sign on section 3d for non maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin <pin>
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 3d
    And I sign DRA section 3d with RA pin <pin>
    Then I should see signed details
    # And I should see location stamp pre-selected

    Examples:
      | level_one_permit                          | level_two_permit                                                           | rank                       | pin  |
      | Hotwork                                   | Hot Work Level-2 in Designated Area                                        | Addtional Master           | 1212 |
      | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage)                                | Chief Officer              | 5912 |
      | Enclosed Spaces Entry                     | Enclosed Space Entry                                                       | Additional Chief Officer   | 5555 |
      | Working Aloft/Overside                    | Working Aloft / Overside                                                   | Second Officer             | 6666 |
      | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                                | Additional Second Officer  | 7777 |
      | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                      | Chief Engineer             | 9780 |
      | Helicopter Operations                     | Helicopter Operation                                                       | Additional Chief Engineer  | 0110 |
      | Rotational Portable Power Tool            | Use of Portable Power Tools                                                | Second Engineer            | 1313 |
      | Work on Electrical Equipment and Circuits | Working on Electrical Equipment - Low/High Voltage                         | Additional Second Engineer | 1414 |
      | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard    | Electro Technical Officer  | 1717 |
      | Working on Deck During Heavy Weather      | Working on Deck During Heavy Weather                                       | Additional Second Engineer | 1414 |
      | Critical Equipment Maintenance            | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify only RA can sign on section 3d for maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 5912
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

  Scenario: Verify non RA cannot sign on dra section 3d

  Scenario: Verify name of signer and signature display after signing

  Scenario: Verify name of signer and signature display after navigating into sign and cancel out again