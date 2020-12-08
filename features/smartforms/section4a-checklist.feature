@section4AChecklist
Feature: Section4AChecklist
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify user should see description of work pre-filled with what is filled in section 1

  Scenario: Verify checklist questions
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    Then I should see Enclosed Spaces Entry Checklist checklist questions
    And I should see info boxes
    And I should see warning boxes
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Hot Work Outside Designated Area checklist
    And I press next for 1 times
    Then I should see Hot Work Outside Designated Area checklist questions
    And I should see info boxes
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Underwater Operation checklist
    And I press next for 1 times
    Then I should see Underwater Operation checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Working Aloft/Overside checklist
    And I press next for 1 times
    Then I should see Working Aloft Overside checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Work on Pressure Pipelines checklist
    And I press next for 1 times
    Then I should see Work on Pressure Pipelines checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Use of ODME in Manual Mode checklist
    And I press next for 1 times
    Then I should see Use of ODME in Manual Mode checklist questions
    And I should see warning boxes
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Personnel Transfer by Transfer Basket checklist
    And I press next for 1 times
    Then I should see Personnel Transfer by Transfer Basket checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Helicopter Operation Checklist checklist
    And I press next for 1 times
    Then I should see Helicopter Operation checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Rotational Portable Power Tools (PPT) checklist
    And I press next for 1 times
    Then I should see Rotational Portable Power Tools (PPT) checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Work on Electrical Equipment and Circuits checklist
    And I press next for 1 times
    Then I should see Work on Electrical Equipment and Circuits checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Critical Equipment Maintenance Checklist checklist
    And I press next for 1 times
    Then I should see Critical Equipment Maintenance checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Work on Deck During Heavy Weather checklist
    And I press next for 1 times
    Then I should see Work on Deck During Heavy Weather checklist questions
    And I should see heavy boxes
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Use of Camera Checklist checklist
    And I press next for 1 times
    Then I should see Use of Camera checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Hot Work Within Designated Area checklist
    And I press next for 1 times
    Then I should see Hot Work Within Designated Area checklist questions
    And I should see warning boxes
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Work on Hazardous Substances checklist
    And I press next for 1 times
    Then I should see Work on Hazardous Substances checklist questions
    And I press previous for 1 times
    And I uncheck the pre-selected checklist
    And I select the matching Cold Work Operation Checklist checklist
    And I press next for 1 times
    Then I should see Cold Work Operation checklist questions

  Scenario Outline: Verify checklist creator signature can be signed on checklist for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 4a
    Then I should see correct checklist <checklist> pre-selected
    When I press next for 1 times
    And I sign on checklist with <pin> pin
    And I sign on canvas
    And I set time
    Then I should see signed details
    And I tear down created form

    Examples:
      | Rank  | pin  | level_one_permit                                             | level_two_permit                                                                | checklist                                 |
      | A/M   | 9015 | Cold Work                                                    | Cold Work - Connecting and Disconnecting Pipelines                              | Cold Work Operation Checklist             |
      | C/O   | 8383 | Cold Work                                                    | Cold Work - Maintenance on Closed Electrical Equipment and Circuits             | Cold Work Operation Checklist             |
      | A C/O | 2761 | Hot Work                                                     | Hot Work Level-2 outside E/R (Ballast Passage)                                  | Hot Work Outside Designated Area          |
      | 2/O   | 6268 | Hot Work                                                     | Hot Work Level-2 outside E/R (Loaded Passage)                                   | Hot Work Outside Designated Area          |
      | A 2/O | 7865 | Hot Work                                                     | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area          |
      | 3/O   | 0159 | Enclosed Spaces Entry                                        | Enclosed Spaces Entry                                                           | Enclosed Space Entry Checklist            |
      | A 3/O | 2674 | Underwater Operations                                        | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation                      |
      | C/E   | 8248 | Underwater Operations                                        | Simultaneous underwater operation during daytime with other operation           | Underwater Operation                      |
      # | A C/E | 9264 | Underwater Operations                                         | Underwater Operation at night                                                   | Underwater Operation                                          |
      | 2/E   | 2523 | Working Aloft/Overside                                       | Working Aloft / Overside                                                        | Working Aloft/Overside                    |
      | A 2/E | 3030 | Work on Pressure Pipeline/Vessels                            | Work on pressure pipelines/pressure vessels                                     | Work on Pressure Pipelines                |
      | 3/E   | 4685 | Use of ODME in Manual Mode                                   | Use of ODME in Manual Mode                                                      | Use of ODME in Manual Mode                |
      | A 3/E | 6727 | Personnel Transfer By Transfer Basket                        | Personnel Transfer by Transfer Basket                                           | Personnel Transfer by Transfer Basket     |
      | 4/E   | 1311 | Helicopter Operations                                        | Helicopter Operation                                                            | Helicopter Operation Checklist            |
      | A 4/E | 0703 | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                              | Work on Electrical Equipment and Circuits |
      | ETO   | 0856 | Rotational Portable Power Tools                              | Use of Portable Power Tools                                                     | Rotational Portable Power Tools (PPT)     |

  Scenario Outline: Verify non checklist creator signature cannot be signed on checklist for non maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    When I press next for 1 times
    And I sign on checklist with <pin> pin
    Then I should see not authorize error message
    And I tear down created form

    Examples:
      | Rank   | pin  | level_one_permit      | level_two_permit                                                                | checklist                        |
      | Master | 1111 | Hot Work              | Hot Work Level-2 in Designated Area                                             | Hot Work Within Designated Area  |
      | D/C    | 2317 | Hot Work              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | Hot Work Outside Designated Area |
      # | SAA    | 6445 | Enclosed Spaces Entry | Enclosed Spaces Entry                                                           | Enclosed Space Entry Checklist  |
      | BOS    | 1018 | Underwater Operations | Underwater Operation during daytime without any simultaneous operations         | Underwater Operation             |
  # | 5/E    | 6322 | Working Aloft/Overside     | Working Aloft / Overside                                                | Working Aloft/Overside          |
  # | E/C    | 9985 | Work on Pressure Pipeline/Vessels                             | Work on pressure pipelines/pressure vessels                                     | Work on Pressure Pipelines                                    |
  # | ELC    | 9298 | Use of ODME in Manual Mode | Use of ODME in Manual Mode                                              | Use of ODME in Manual Mode      |
  # | ETR    | 1715 | Personnel Transfer By Transfer Basket                          | Personnel Transfer by Transfer Basket                                           | Personnel Transfer by Transfer Basket                         |
  # | T/E    | 1611 | Helicopter Operations                                         | Helicopter Operation                                                            | Helicopter Operation Checklist                                |
  # | PMN    | 4236 | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                              | Work on Electrical Equipment and Circuits – Low/High Voltage |
  # | FTR    | 9115 | Rotational Portable Power Tools                                | Use of Hydro blaster/working with High-pressure tools                           | Rotational Portable Power Tools (PPT)                         |
  # | CCK    | 9082 | Use of non-intrinsically safe Camera                          | Use of Non-Intrinsically Safe Camera                                            | Use of Camera Checklist                                       |
  # | 2CK    | 1455 | Working on Deck During Heavy Weather                          | Working on Deck During Heavy Weather                                            | Work on Deck During Heavy Weather                             |
  # | RDCRW  | 9946 | Cold Work                                                     | Cold Work - Blanking/Deblanking of Pipelines and Other Openings         | Cold Work Operation Checklist                                 |
  # | FSTO   | 1041 | Cold Work                                                     | Cold Work - Connecting and Disconnecting Pipelines                              | Cold Work Operation Checklist                                 |

  Scenario Outline: Verify checklist creator signature can be signed on checklist for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 4a
    Then I should see correct checklist <checklist> pre-selected
    When I press next for 1 times
    And I sign on checklist with <pin> pin
    And I sign on canvas
    And I set time
    Then I should see signed details
    And I tear down created form

    Examples:
      | Rank | pin  | level_one_permit               | level_two_permit                          | checklist                                |
      | ETO  | 0856 | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify non checklist creator signature cannot signed on checklist for maintenance permits
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 4a
    Then I should see correct checklist <checklist> pre-selected
    When I press next for 1 times
    And I sign on checklist with <pin> pin
    Then I should see not authorize error message
    And I tear down created form

    Examples:
      | Rank   | pin  | level_one_permit               | level_two_permit      | checklist                                |
      | Master | 1111 | Critical Equipment Maintenance | Maintenance on Anchor | Critical Equipment Maintenance Checklist |
  # | 4/O    | 1010 | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify checklist form is pre-populated with PTW permit number, data and time for non maintenance permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 4a
    Then I should see correct checklist <checklist> pre-selected
    And I should see permit number, date and time populated
    And I tear down created form

    Examples:
      | level_one_permit      | level_two_permit      | checklist                      |
      | Enclosed Spaces Entry | Enclosed Spaces Entry | Enclosed Space Entry Checklist |
  # | Underwater Operations                 | Underwater Operation during daytime without any simultaneous operations | Underwater Operation                   |
  # | Working Aloft/Overside                | Working Aloft / Overside                                                | Working Aloft/Overside                 |
  # | Work on Pressure Pipeline/Vessels     | Work on pressure pipelines/pressure vessels                             | Work on Pressure Pipelines             |
  # | Use of ODME in Manual Mode            | Use of ODME in Manual Mode                                              | Use of ODME in Manual Mode             |
  # | Personnel Transfer By Transfer Basket | Personnel Transfer by Transfer Basket                                   | Personnel Transfer by Transfer Basket  |
  # | Helicopter Operations                 | Helicopter Operation                                                    | Helicopter Operation Checklist         |
  # | Rotational Portable Power Tools       | Use of Portable Power Tools                                             | Rotational Portable Power Tools (PPT) |
  # | Use of non-intrinsically safe Camera  | Use of Non-Intrinsically Safe Camera                                    | Use of Camera Checklist                |
  # | Working on Deck During Heavy Weather  | Working on Deck During Heavy Weather                                    | Work on Deck During Heavy Weather      |

  Scenario Outline: Verify checklist form is pre-populated with PTW permit number, data and time for maintenance permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I set maintenance during more than 2 hours
    # And I set time
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    Then I should see permit number, date and time populated
    And I tear down created form

    Examples:
      | level_one_permit               | level_two_permit      | checklist                                |
      | Critical Equipment Maintenance | Maintenance on Anchor | Critical Equipment Maintenance Checklist |