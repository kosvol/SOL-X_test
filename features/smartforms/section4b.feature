@section4BEIC
Feature: Section4BEIC
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify description of work is pre-populated

  Scenario: Verify data,time and EIC number is pre-populated
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1313
    And I select Hotwork permit
    And I select Hot Work Level-1 (Loaded & Ballast Passage) permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching Hot Work Outside Designated Area checklist
    And I press next for 2 times
    And I select yes to EIC certification
    Then I should see EIC permit number, date and time populated
    And I tear down created form

  # Scenario Outline: Verify only competent person can sign as competent person on first EIC signing
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 1212
  #   And I select <level_one_permit> permit
  #   And I select <level_two_permit> permit for level 2
  #   And I fill up section 1
  #   And I navigate to section 4a
  #   And I select the matching <checklist> checklist
  #   And I press next for 2 times
  #   Then I sign first EIC as competent person who is <rank> with pin <pin>
  #   And I should see <rank> rank and name
  #   And I tear down created form

  #   Examples:
  #     | rank              | pin  | level_one_permit               | level_two_permit                                                           | checklist                                |
  #     | C/O Alister Leong | 5912 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  #     | 2/E Poon Choryi   | 1313 | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
  #     | ETO Reza Ilmi     | 1717 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                      | Enclosed Spaces Entry Checklist          |

  # Scenario Outline: Verify non competent person cannot sign as competent person on first EIC signing
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 1212
  #   And I select <level_one_permit> permit
  #   And I select <level_two_permit> permit for level 2
  #   And I fill up section 1
  #   And I navigate to section 4a
  #   And I select the matching <checklist> checklist
  #   And I press next for 2 times
  #   Then I sign first EIC as competent person who is <rank> with pin <pin>
  #   And I should see not authorize error message
  #   And I tear down created form

  #   Examples:
  #     | rank                       | pin  | level_one_permit               | level_two_permit                                                           | checklist                                |
  #     | Addtional Master           | 1212 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  #     # | Additional Chief Officer   | 5555 | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
  #     | Second Officer             | 5545 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                      | Enclosed Spaces Entry Checklist          |
  #     # | Additional Second Officer  | 7777 | Hotwork                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
  #     | Chief Engineer             | 7507 | Rotational Portable Power Tool | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
  #     # | Additional Chief Engineer  | 0110 | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
  #     | Additional Second Engineer | 1414 | Underwater Operations          | Underwater Operation at night                                              | Underwater Operation                     |
  #     # | Master                     | 1111 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  #     | 3/O                        | 8888 | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
  #     # | 4/O                        | 1010 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                       | Enclosed Spaces Entry Checklist           |
  #     | A 3/E                      | 1515 | Hotwork                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
  #     # | 4/E                        | 2323 | Rotational Portable Power Tool | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
  #     | BOS                        | 1818 | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
  # # | PMN                        | 4236 | Underwater Operations          | Underwater Operation at night                                              | Underwater Operation                     |

  Scenario Outline: Verify location stamping on signature section as RA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I sign EIC section 4b with RA pin 1212
    And I should see signed details
    Then I should see location <location_stamp> stamp
    And I tear down created form

    Examples:
      | user         | zoneid                     | mac               | location_stamp   | level_one_permit      | level_two_permit      | checklist                       |
      | SIT_SOLX0012 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom | Enclosed Spaces Entry | Enclosed Spaces Entry | Enclosed Spaces Entry Checklist |

  Scenario Outline: Verify location stamping on signature section for competent person
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    And I select yes to EIC certification
    Then I sign EIC as competent person with pin 5912
    And I should see signed details
    Then I should see location <location_stamp> stamp
    And I tear down created form

    Examples:
      | user         | zoneid                     | mac               | location_stamp   | level_one_permit               | level_two_permit            | checklist                             |
      | SIT_SOLX0004 | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Pump Room Bottom | Rotational Portable Power Tool | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |

  Scenario Outline: Verify location stamping on signature section for issuing authority
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I link wearable to a issue authority <user> and link to zoneid <zoneid> and mac <mac>
    And I select yes to EIC certification
    Then I sign EIC as issuing authority with pin 7507
    And I should see signed details
    Then I should see location <location_stamp> stamp
    And I tear down created form

    Examples:
      | user         | zoneid                     | mac               | location_stamp | level_one_permit               | level_two_permit            | checklist                             |
      | SIT_SOLX0002 | SIT_0ABXE10S7JGZ0TYHR704GH | 00:00:00:00:00:A0 | IG Platform 2  | Rotational Portable Power Tool | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |

  Scenario Outline: Verify only RA can sign on responsible authority
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I sign EIC section 4b with RA pin <pin>
    Then I should see signed details
    And I should see signature
    And I tear down created form

    Examples:
      | level_one_permit | level_two_permit                    | checklist                       | rank             | pin  |
      | Hotwork          | Hot Work Level-2 in Designated Area | Hot Work Within Designated Area | Addtional Master | 1212 |
  # | Hotwork                                                       | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area                              | Chief Officer              | 5912 |
  # | Enclosed Spaces Entry                                         | Enclosed Spaces Entry                                                      | Enclosed Spaces Entry Checklist                               | Additional Chief Officer   | 5555 |
  # | Working Aloft/Overside                                        | Working Aloft / Overside                                                   | Working Aloft/Overside                                        | Second Officer             | 5545 |
  # | Critical Equipment Maintenance                                | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist                      | Additional Second Officer  | 7777 |
  # | Personal Transfer By Transfer Basket                          | Personnel Transfer by Transfer Basket                                      | Personnel Transfer by Transfer Basket                         | Chief Engineer             | 7507 |
  # | Helicopter Operations                                         | Helicopter Operation                                                       | Helicopter Operation Checklist                                | Additional Chief Engineer  | 0110 |
  # | Rotational Portable Power Tool                                | Use of Portable Power Tools                                                | Rotational Portable Power Tools (PPT)                         | Second Engineer            | 1313 |
  # | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                         | Work on Electrical Equipment and Circuits – Low/High Voltage | Additional Second Engineer | 1414 |
  # | Cold Work                                                     | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard    | Cold Work Operation Checklist                                 | Electro Technical Officer  | 1717 |

  Scenario Outline: Verify non RA cannot sign on responsible authority
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I sign EIC section 4b with non RA pin <pin>
    Then I should see not authorize error message
    And I tear down created form

    Examples:
      | rank  | pin  | level_one_permit      | level_two_permit      | checklist                       |
      # | Master | 1111 | Hotwork                                                       | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area                               |
      # | 3/O    | 8888 | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area          |
      | A 3/O | 9999 | Enclosed Spaces Entry | Enclosed Spaces Entry | Enclosed Spaces Entry Checklist |
  # | 4/O    | 1010 | Working Aloft/Overside                    | Working Aloft / Overside                                                   | Working Aloft/Overside                    |
  # | D/C    | 1616 | Critical Equipment Maintenance                                | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist                      |
  # | 3/E    | 4092 | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                      | Personnel Transfer by Transfer Basket     |
  # | A 3/E  | 1515 | Helicopter Operations                                         | Helicopter Operation                                                       | Helicopter Operation Checklist                                |
  # | 4/E    | 2323 | Rotational Portable Power Tool            | Use of Portable Power Tools                                                | Rotational Portable Power Tools (PPT)     |
  # | A 4/E  | 2424 | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                         | Work on Electrical Equipment and Circuits – Low/High Voltage |
  # | BOS    | 1818 | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings Onboard    | Cold Work Operation Checklist             |
  # | PMN    | 4236 | Working Aloft/Overside                                        | Working Aloft / Overside                                                   | Working Aloft/Overside                                        |
  # | A/B    | 2121 | Critical Equipment Maintenance                                | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist                      |
  # | O/S    | 1919 | Personal Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                      | Personnel Transfer by Transfer Basket     |
  # | OLR    | 0220 | Helicopter Operations                                         | Helicopter Operation                                                       | Helicopter Operation Checklist                                |

  # Scenario Outline: Verify only chief engineer can sign as issuing authority
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 1212
  #   And I select <level_one_permit> permit
  #   And I select <level_two_permit> permit for level 2
  #   And I fill up section 1
  #   And I navigate to section 4a
  #   And I select the matching <checklist> checklist
  #   And I press next for 2 times
  #   And I select yes to EIC certification
  #   Then I sign EIC as issuing authority with pin <pin>
  #   And I should see signed details
  #   And I should see signature
  #   And I tear down created form

  #   Examples:
  #     | rank | pin  | level_one_permit               | level_two_permit                                                           | checklist                                |
  #     | C/E  | 7507 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |

  Scenario Outline: Verify non chief engineer cannot sign as issuing authority
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I select yes to EIC certification
    And I sign EIC as non issuing authority with pin <pin>
    Then I should see not authorize error message
    And I tear down created form

    Examples:
      | rank           | pin  | level_one_permit               | level_two_permit                                                           | checklist                                |
      | Master         | 1111 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
      | 2/E            | 1313 | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
      | ETO            | 1717 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                      | Enclosed Spaces Entry Checklist          |
      | C/O            | 5912 | Hotwork                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
      | 2/E            | 1313 | Rotational Portable Power Tool | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
      | ETO            | 1717 | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
      | Second Officer | 5545 | Underwater Operations          | Underwater Operation at night                                              | Underwater Operation                     |

  # Scenario Outline: Verify only competent person can sign as competent person
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 1212
  #   And I select <level_one_permit> permit
  #   And I select <level_two_permit> permit for level 2
  #   And I fill up section 1
  #   And I navigate to section 4a
  #   And I select the matching <checklist> checklist
  #   And I press next for 2 times
  #   And I select yes to EIC certification
  #   Then I sign EIC as competent person with pin <pin>
  #   And I should see signed details
  #   And I should see signature
  #   And I tear down created form

  #   Examples:
  #     | rank | pin  | level_one_permit               | level_two_permit                                                           | checklist                                |
  #     | C/O  | 5912 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  #     | 2/E  | 1313 | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
  #     | ETO  | 1717 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                      | Enclosed Spaces Entry Checklist          |
  #     | C/O  | 5912 | Hotwork                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
  #     | 2/E  | 1313 | Rotational Portable Power Tool | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
  #     | ETO  | 1717 | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
  #     | C/O  | 5912 | Underwater Operations          | Underwater Operation at night                                              | Underwater Operation                     |

  Scenario Outline: Verify non competent person cannot sign as competent person
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 4a
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I select yes to EIC certification
    And I sign EIC as non competent person with pin <pin>
    Then I should see not authorize error message
    And I tear down created form

    Examples:
      | rank                       | pin  | level_one_permit               | level_two_permit                                                           | checklist                                |
      | Addtional Master           | 1212 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
      # | Additional Chief Officer   | 5555 | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
      | Second Officer             | 5545 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                      | Enclosed Spaces Entry Checklist          |
      # | Additional Second Officer  | 7777 | Hotwork                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
      | Chief Engineer             | 7507 | Rotational Portable Power Tool | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
      # | Additional Chief Engineer  | 0110 | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
      | Additional Second Engineer | 1414 | Underwater Operations          | Underwater Operation at night                                              | Underwater Operation                     |
      # | Master                     | 1111 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
      | 3/O                        | 8888 | Hotwork                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
      # | 4/O                        | 1010 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                       | Enclosed Spaces Entry Checklist           |
      | A 3/E                      | 1515 | Hotwork                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
      # | 4/E                        | 2323 | Rotational Portable Power Tool | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
      | BOS                        | 1818 | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
# | PMN                        | 4236 | Underwater Operations          | Underwater Operation at night                                              | Underwater Operation                     |