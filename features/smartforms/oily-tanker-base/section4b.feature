@section4BEIC
Feature: Section4BEIC
  As a ...
  I want to ...
  So that ...

  Scenario: Verify description of work is pre-populated
    Given I change ship local time to +8 GMT
    When I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 4b
    And I select yes to EIC
    And I click on create EIC certification button
    Then I should see description of work pre-populated

  Scenario: Verify data,time and EIC number is pre-populated
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select Hot Work permit
    And I select Hot Work Level-1 (Loaded & Ballast Passage) permit for level 2
    And I navigate to section 4a
    And I uncheck the pre-selected checklist
    And I select the matching Hot Work Outside Designated Area checklist
    And I press next for 2 times
    And I select yes to EIC
    And I click on create EIC certification button
    And I set time
    Then I should see EIC permit number, date and time populated

  Scenario Outline: Verify location stamping on signature section as RA
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 4b
    # And I press next for 2 times
    And I link wearable to a RA <user> and link to zoneid <zoneid> and mac <mac>
    And I select yes to EIC
    And I sign EIC section 4b with RA pin 9015
    And I set time
    And I should see signed details
    Then I should see location <location_stamp> stamp

    Examples:
      | user          | zoneid                      | mac               | location_stamp | level_one_permit      | level_two_permit      | checklist                      |
      | AUTO_SOLX0012 | AUTO_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Aft Station    | Enclosed Spaces Entry | Enclosed Spaces Entry | Enclosed Space Entry Checklist |

  Scenario Outline: Verify location stamping on signature section for competent person
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 4b
    # And I uncheck the pre-selected checklist
    # And I select the matching <checklist> checklist
    # And I press next for 2 times
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    And I select yes to EIC
    And I click on create EIC certification button
    Then I sign EIC as competent person with pin <pin>
    And I set time
    And I should see signed details
    Then I should see location <location_stamp> stamp

    Examples:
      | user          | pin  | zoneid                      | mac               | location_stamp | level_one_permit                | level_two_permit            | checklist                             |
      | AUTO_SOLX0004 | 8383 | AUTO_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |
      | AUTO_SOLX0013 | 2523 | AUTO_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |
      | AUTO_SOLX0017 | 0856 | AUTO_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |

  Scenario Outline: Verify location stamping on signature section for issuing authority
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank C/E
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 4b
    # And I uncheck the pre-selected checklist
    # And I select the matching <checklist> checklist
    # And I press next for 2 times
    And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
    And I select yes to EIC
    And I click on create EIC certification button
    Then I sign EIC as issuing authority with pin 8248
    And I set time
    And I should see signed details
    Then I should see location <location_stamp> stamp

    Examples:
      | user          | zoneid                      | mac               | location_stamp | level_one_permit                | level_two_permit            | checklist                             |
      | AUTO_SOLX0002 | AUTO_0ABXE10S7JGZ0TYHR704GH | 00:00:00:00:00:A0 | IG Platform 2  | Rotational Portable Power Tools | Use of Portable Power Tools | Rotational Portable Power Tools (PPT) |

  Scenario Outline: Verify non RA cannot sign on responsible authority
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to section 4a
    And I uncheck the pre-selected checklist
    And I select the matching <checklist> checklist
    And I press next for 2 times
    And I select yes to EIC
    And I sign EIC section 4b with non RA pin <pin>
    Then I should see not authorize error message

    Examples:
      | rank   | pin  | level_one_permit | level_two_permit                    | checklist                       |
      | Master | 1111 | Hot Work         | Hot Work Level-2 in Designated Area | Hot Work Within Designated Area |
  # | 4/O    | 1010 | Working Aloft/Overside                    | Working Aloft / Overside                                                   | Working Aloft/Overside                    |
  # | D/C    | 2317 | Critical Equipment Maintenance                                | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist                      |
  # | 3/E    | 4685 | Personnel Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                      | Personnel Transfer by Transfer Basket     |
  # | A 3/E  | 6727 | Helicopter Operations                                         | Helicopter Operation                                                       | Helicopter Operation Checklist                                |
  # | 4/E    | 1311 | Rotational Portable Power Tools            | Use of Portable Power Tools                                                | Rotational Portable Power Tools (PPT)     |
  # | A 4/E  | 0703 | Work on Electrical Equipment and Circuits – Low/High Voltage | Working on Electrical Equipment - Low/High Voltage                         | Work on Electrical Equipment and Circuits – Low/High Voltage |
  # | BOS    | 1018 | Cold Work                                 | Cold Work - Blanking/Deblanking of Pipelines and Other Openings    | Cold Work Operation Checklist             |
  # | PMN    | 4236 | Working Aloft/Overside                                        | Working Aloft / Overside                                                   | Working Aloft/Overside                                        |
  # | A/B    | 6316 | Critical Equipment Maintenance                                | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist                      |
  # | O/S    | 7669 | Personnel Transfer By Transfer Basket      | Personnel Transfer by Transfer Basket                                      | Personnel Transfer by Transfer Basket     |
  # | OLR    | 0450 | Helicopter Operations                                         | Helicopter Operation                                                       | Helicopter Operation Checklist                                |

  Scenario: Verify non chief engineer cannot sign as issuing authority
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I navigate to section 4b
    # And I uncheck the pre-selected checklist
    # And I select the matching <checklist> checklist
    # And I press next for 2 times
    And I select yes to EIC
    And I click on create EIC certification button
    Then I should see issuing authority sign button disabled
  # And I sign EIC as non issuing authority with pin <pin>
  # Then I should see not authorize error message

  # Examples:
  # | rank   | pin  | level_one_permit               | level_two_permit                                                           | checklist                                |
  # | Master | 1111 | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  # | 2/E            | 2523 | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
  # | ETO            | 0856 | Enclosed Spaces Entry           | Enclosed Spaces Entry                                                      | Enclosed Space Entry Checklist           |
  # | C/O            | 8383 | Hot Work                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
  # | 2/E            | 2523 | Rotational Portable Power Tools | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
  # | ETO            | 0856 | Cold Work                       | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
  # | Second Officer | 6268 | Underwater Operations           | Underwater Operations at night for mandatory drug and contraband search    | Underwater Operation                     |

  Scenario: Verify non competent person cannot sign as competent person
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank 3/O
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I navigate to section 4b
    And I select yes to EIC
    And I click on create EIC certification button
    Then I should see competent person sign button disabled
    Then I should see issuing authority sign button enabled

  #   Examples:
  #     | rank                       | pin  | level_one_permit                | level_two_permit                                                           | checklist                                |
  #     | Addtional Master           | 9015 | Critical Equipment Maintenance  | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  #     # | Additional Chief Officer   | 2761 | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
  #     | Second Officer             | 6268 | Enclosed Spaces Entry           | Enclosed Spaces Entry                                                      | Enclosed Space Entry Checklist           |
  #     # | Additional Second Officer  | 7865 | Hot Work                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
  #     | Chief Engineer             | 8248 | Rotational Portable Power Tools | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
  #     # | Additional Chief Engineer  | 5718 | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
  #     | Additional Second Engineer | 3030 | Underwater Operations           | Underwater Operations at night for mandatory drug and contraband search    | Underwater Operation                     |
  #     | Master                     | 1111 | Critical Equipment Maintenance  | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment | Critical Equipment Maintenance Checklist |
  #     | 3/O                        | 0159 | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage)                                | Hot Work Outside Designated Area         |
  #     # | 4/O                        | 1010 | Enclosed Spaces Entry          | Enclosed Spaces Entry                                                       | Enclosed Space Entry Checklist           |
  #     | A 3/E                      | 6727 | Hot Work                        | Hot Work Level-2 in Designated Area                                        | Hot Work Within Designated Area          |
  #     # | 4/E                        | 1311 | Rotational Portable Power Tools | Use of Hydro blaster/working with High-pressure tools                      | Rotational Portable Power Tools (PPT)    |
  #     | BOS                        | 1018 | Cold Work                       | Cold Work - Connecting and Disconnecting Pipelines                         | Cold Work Operation Checklist            |
  # # | PMN                        | 4236 | Underwater Operations          | Underwater Operations at night for mandatory drug and contraband search                                              | Underwater Operation                     |

  Scenario: Verify sub questions
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 2523
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 4b
    And I select yes to EIC
    And I click on create EIC certification button
    Then I should see these sub questions
      | Lock Out                                                                                 |
      | Tag Out                                                                                  |
      | Sanction to Test (High Voltage) (Checklist)                                              |
      | Switch Disconnector                                                                      |
      | Main/DB Switch Breaker                                                                   |
      | Circuit fuses                                                                            |
      | Blank Flanges/Capping                                                                    |
      | Blinding/Spading                                                                         |
      | Removal spool piece/valves                                                               |
      | Removal of Hazards                                                                       |
      | Double Block and Bleed                                                                   |
      | Disconnection of piping                                                                  |
      | Warning Tag displayed on Equipments / Power Supply / Control Unit / Valves               |
      | Relevant Departments personnel informed as applicable                                    |
      | Equipments/Valves locked and tagged                                                      |
      | Suitable tools with insulation available (Electrical Isolation)                          |
      | Voltage level checked after electrical isolation and found "zero" (Electrical Isolation) |