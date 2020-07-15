@section4AChecklist
Feature: Section4AChecklist
  As a ...
  I want to ...
  So that ...
  # rigging ladder checklist
  # pre checklist

  # Scenario: Initialize the clock for automation
  #   Given I launch sol-x portal
  #   When I navigate to "SmartForms" screen
  #   And I navigate to create new permit

  Scenario Outline: Verify checklist creator signature can be signed on checklist for non maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I sign checklist with respective checklist creator <pin>
    Then I should see signed details
    And I tear down created form

    Examples:
      | Rank  | pin  | level_one_permit                          | level_two_permit                                                                | checklist                                 |
      | A/M   | 1212 | Cold Work                                 | Cold Work - Connecting and Disconnecting Pipelines                              | Cold Work Operation Checklist             |
      | C/O   | 5912 | Cold Work                                 | Cold Work - Working on Closed Electrical Equipment and Circuits                 | Cold Work Operation Checklist             |
      | A C/O | 5555 | Hotwork                                   | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area          |
      | 2/O   | 5545 | Hotwork                                   | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Hot Work Outside Designated Area          |
      | A 2/O | 7777 | Hotwork                                   | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area          |
      | 3/O   | 8888 | Enclosed Spaces Entry                     | Enclosed Space Entry                                                            | Enclosed Space Entry Checklist            |
      | A 3/O | 9999 | Underwater Operations                     | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation                      |
      | C/E   | 7507 | Underwater Operations                     | Simultaneous underwater operation during daytime with other operation           | Underwater Operation                      |
      | A C/E | 0110 | Underwater Operations                     | Underwater Operation at night                                                   | Underwater Operation                      |
      | 2/E   | 1313 | Working Aloft/Overside                    | Working Aloft / Overside                                                        | Working Aloft/Overside                    |
      | A 2/E | 1414 | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                                     | Work on Pressure Pipelines                |
      | 3/E   | 4092 | Use of ODME in Manual Mode                | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode                |
      | A 3/E | 1515 | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                           | Personnel Transfer by Transfer Basket     |
      | 4/E   | 2323 | Helicopter Operations                     | Helicopter Operation                                                            | Helicopter Operation Checklist            |
      | A 4/E | 2424 | Work on Electrical Equipment and Circuits | Working on Electrical Equipment - Low/High Voltage                              | Work on Electrical Equipment and Circuits |
      | ETO   | 1717 | Rotational Portable Power Tool            | Use of Portable Power Tools                                                     | Rotational Portable Power Tools (PPT)     |

  Scenario Outline: Verify non checklist creator signature cannot be signed on checklist for non maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I sign checklist with respective checklist creator <pin>
    Then I should see not authorize error message
    And I tear down created form

    Examples:
      | Rank   | pin  | level_one_permit                          | level_two_permit                                                                | checklist                                 |
      | Master | 1111 | Hotwork                                   | Hot Work Level-2 in Designated Area                                             | Hot Work Within Designated Area           |
      | D/C    | 1616 | Hotwork                                   | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area          |
      | SAA    | 1203 | Enclosed Spaces Entry                     | Enclosed Space Entry                                                            | Enclosed Space Entry Checklist            |
      | BOS    | 1818 | Underwater Operations                     | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation                      |
      | 5/E    | 6322 | Working Aloft/Overside                    | Working Aloft / Overside                                                        | Working Aloft/Overside                    |
      | E/C    | 9985 | Work on Pressure Pipeline/Vessels         | Work on pressure pipelines/pressure vessels                                     | Work on Pressure Pipelines                |
      | ELC    | 9298 | Use of ODME in Manual Mode                | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode                |
      | ETR    | 1715 | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                           | Personnel Transfer by Transfer Basket     |
      | T/E    | 1611 | Helicopter Operations                     | Helicopter Operation                                                            | Helicopter Operation Checklist            |
      | PMN    | 4236 | Work on Electrical Equipment and Circuits | Working on Electrical Equipment - Low/High Voltage                              | Work on Electrical Equipment and Circuits |
      | FTR    | 9115 | Rotational Portable Power Tool            | Use of Hydro blaster/working with High-pressure tools                           | Rotational Portable Power Tools (PPT)     |
      | CCK    | 9082 | Use of non-intrinsically safe Camera      | Use of Non-Intrinsically Safe Camera                                            | Use of Camera Checklist                   |
      | 2CK    | 1455 | Working on Deck During Heavy Weather      | Working on Deck During Heavy Weather                                            | Work on Deck During Heavy Weather         |
      | RDCRW  | 9946 | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard         | Cold Work Operation Checklist             |
      | FSTO   | 1041 | Cold Work                                 | Cold Work - Connecting and Disconnecting Pipelines                              | Cold Work Operation Checklist             |

  Scenario Outline: Verify checklist creator signature can be signed on checklist for maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I sign checklist with respective checklist creator <pin>
    Then I should see signed details
    And I tear down created form

    Examples:
      | Rank | pin  | level_one_permit               | level_two_permit                          | checklist                                |
      | ETO  | 1717 | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify non checklist creator signature cannot be signed on checklist for maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I sign checklist with respective checklist creator <pin>
    Then I should see not authorize error message
    And I tear down created form

    Examples:
      | Rank   | pin  | level_one_permit               | level_two_permit                   | checklist                                |
      | Master | 1111 | Critical Equipment Maintenance | Maintenance on Anchor              | Critical Equipment Maintenance Checklist |
      | 4/O    | 1010 | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify checklist content are displayed correctly for maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    And I navigate to section 4a
    Then I should see correct checklist content for <checklist> checklist
    And I tear down created form

    Examples:
      | level_one_permit               | level_two_permit      | checklist                                |
      | Critical Equipment Maintenance | Maintenance on Anchor | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify checklist form is pre-populated with PTW permit number, data and time for non maintenance permit
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    Then I should see permit number, date and time populated
    And I tear down created form

    Examples:
      | level_one_permit                     | level_two_permit                                                        | checklist                             |
      | Enclosed Spaces Entry                | Enclosed Space Entry                                                    | Enclosed Space Entry Checklist        |
      | Underwater Operations                | Underwater Operation during daytime without any simultaneous operations | Underwater Operation                  |
      | Working Aloft/Overside               | Working Aloft / Overside                                                | Working Aloft/Overside                |
      | Work on Pressure Pipeline/Vessels    | Work on pressure pipelines/pressure vessels                             | Work on Pressure Pipelines            |
      | Use of ODME in Manual Mode           | Use of ODME in Manual Mode                                              | Use of ODME in Manual Mode            |
      | Personal Transfer By Transfer Basket | Personnel Transfer by Transfer Basket                                   | Personnel Transfer by Transfer Basket |
      | Helicopter Operations                | Helicopter Operation                                                    | Helicopter Operation Checklist        |
      | Rotational Portable Power Tool       | Use of Portable Power Tools                                             | Rotational Portable Power Tools (PPT) |
      | Use of non-intrinsically safe Camera | Use of Non-Intrinsically Safe Camera                                    | Use of Camera Checklist               |
      | Working on Deck During Heavy Weather | Working on Deck During Heavy Weather                                    | Work on Deck During Heavy Weather     |

  Scenario Outline: Verify checklist form is pre-populated with PTW permit number, data and time for maintenance permit
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    Then I should see permit number, date and time populated
    And I tear down created form

    Examples:
      | level_one_permit               | level_two_permit      | checklist                                |
      | Critical Equipment Maintenance | Maintenance on Anchor | Critical Equipment Maintenance Checklist |

  Scenario: Verify checklist content labels
