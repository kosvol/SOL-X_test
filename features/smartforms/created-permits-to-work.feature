@created-permits-to-work
Feature: CreatedPermitToWork
  As a ...
  I want to ...
  So that ...

  Scenario: Initialize the clock for automation
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit

  # Scenario: Verify correct total list of created permit
  #   Given I launch sol-x portal without unlinking wearable
  #   When I navigate to "Created Permits to Work" screen
  #   Then I should see the total permits in CREATED state match backend results

  # Scenario: Verify past created permit should display permit id
  #   Given I launch sol-x portal without unlinking wearable
  #   When I navigate to "Created Permits to Work" screen
  #   And I edit past created permit
  #   And I enter pin 1212
  #   Then I should see permit id populated

  Scenario: Verify created permit data matched on edit screen for Permit Details
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Use of ODME in Manual Mode permit
    And I select Use of ODME in Manual Mode permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I want to edit the newly created permit
    And I enter pin 1212
    Then I should see correct permit details
    And I tear down created form

  Scenario: Verify created permit is under Created Permit to Work
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to "Created Permits to Work" screen
    Then I should see the newly created permit details listed on Created Permits to Work
    And I tear down created form

  Scenario: Verify deleted permit under Created Permit to Work refresh listing after deletion
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I delete the permit created
    Then I should see deleted permit deleted
    And I tear down created form

  Scenario Outline: Verify PTW reader can only read PTW for permit in created state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I should see form is at reading mode for <rank> rank and <pin> pin
    Then I should see all section fields disabled

    Examples:
      | rank   | pin  |
      | Master | 1111 |
      | 3/O    | 8888 |
      | A 3/O  | 9999 |
      | 3/E    | 4092 |
      | A 3/E  | 1515 |
      | 4/O    | 1010 |
      | A 4/O  | 1537 |
  # | BOS   | 1818 |
  # | PMN   | 4236 |
  # | A/B   | 2121 |
  # | O/S   | 1919 |

  Scenario Outline: Verify RA can edit all the fields in PTW Created State
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I edit ptw with rank <rank> and <pin> pin
    Then I should see all section fields enabled

    Examples:
      | rank                       | pin  |
      | Addtional Master           | 1212 |
      | Chief Officer              | 5912 |
      | Additional Chief Officer   | 5555 |
      | Second Officer             | 5545 |
      | Additional Second Officer  | 7777 |
      | Chief Engineer             | 7507 |
      | Additional Chief Engineer  | 0110 |
      | Second Engineer            | 1313 |
      | Additional Second Engineer | 1414 |
      | Electro Technical Officer  | 1717 |

  # Scenario: Verify Gas Tester 2 can edit section 6 gas reading for PRE

  Scenario Outline: Verify only competent person from EIC can sign on section 4b
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I edit ptw with rank <rank> and <pin> pin
    Then I should see EIC section with fields enabled

    Examples:
      | rank                      | pin  |
      | C/O                       | 5912 |
      | Second Engineer           | 1313 |
      | Electro Technical Officer | 1717 |

  Scenario Outline: Verify AGT can edit gas reader on section 6 for permit on Created state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I edit ptw with rank <rank> and <pin> pin
    Then I should see gas reader section with fields enabled

    Examples:
      | rank                       | pin  | level_one_permit                          | level_two_permit                            |
      | Master                     | 1111 | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage) |
      | A/M                        | 1212 | Cold Work                                 | Cold Work - Cleaning Up of Spills           |
      | C/O                        | 5912 | Underwater Operations                     | Underwater Operation at night               |
      | A C/O                      | 5555 | Rotational Portable Power Tool            | Use of Portable Power Tools                 |
      | 2/O                        | 5545 | Work on Electrical Equipment and Circuits | Work on Electrical Equipment and Circuits   |
      | A 2/O                      | 7777 | Hotwork                                   | Hot Work Level-2 in Designated Area         |
      | 3/O                        | 8888 | Hotwork                                   | Hot Work Level-1 (Loaded & Ballast Passage) |
      | A 3/O                      | 9999 | Cold Work                                 | Cold Work - Cleaning Up of Spills           |
      | Chief Engineer             | 7507 | Underwater Operations                     | Underwater Operation at night               |
      | Additional Chief Engineer  | 0110 | Enclosed Spaces Entry                     | Enclosed Spaces Entry                       |
      | Second Engineer            | 1313 | Work on Electrical Equipment and Circuits | Work on Electrical Equipment and Circuits   |
      | Additional Second Engineer | 1414 | Hotwork                                   | Hot Work Level-2 in Designated Area         |
      | 3/E                        | 4092 | Underwater Operations                     | Underwater Operation at night               |
      | A 3/E                      | 1515 | Rotational Portable Power Tool            | Use of Portable Power Tools                 |

  Scenario Outline: Verify checklist creator can only edit checklist,eic and gas reader in PTW Created State
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 1212
    And I select Hotwork permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I navigate to "Created Permits to Work" screen
    And I edit ptw with rank <rank> and <pin> pin
    Then I should see checklist section with fields enabled
    And I should see eic selection fields enabled
    And I should see gas reading section with fields enabled
    When I sign on section with <pin> pin
    Then I should see signed details
    And I tear down created form

    Examples:
      | rank  | pin  |
      | 3/O   | 8888 |
      | A 3/O | 9999 |
      | 3/E   | 4092 |
      | A 3/E | 1515 |
      | 4/E   | 2323 |
      | A 4/E | 2424 |

