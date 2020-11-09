@created-permits-to-work
Feature: CreatedPermitToWork
  As a ...
  I want to ...
  So that ...

  # Scenario: Initialize the clock for automation
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit

  # Scenario: Verify correct total list of created permit
  #   Given I launch sol-x portal without unlinking wearable
  #   When I navigate to "Created Permits to Work" screen
  #   Then I should see the total permits in CREATED state match backend results

  # Scenario: Verify past created permit should display permit id
  #   Given I launch sol-x portal without unlinking wearable
  #   When I navigate to "Created Permits to Work" screen
  #   And I edit past created permit
  #   And I enter pin 9015
  #   Then I should see permit id populated

  # # Scenario: Verify Gas Tester 2 can edit section 6 gas reading for PRE

  Scenario: Verify section 6 buttons display are correct
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Use of ODME in Manual Mode permit
    And I select Use of ODME in Manual Mode permit for level 2
    And I click on back arrow
    And I navigate to "Created Permits to Work" screen
    And I want to edit the newly created permit
    And I enter pin 0311
    And I navigate to section 6
    Then I should see previous and close buttons
    And I tear down created form

  Scenario: Verify created permit data matched on edit screen for Permit Details
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Use of ODME in Manual Mode permit
    And I select Use of ODME in Manual Mode permit for level 2
    And I click on back arrow
    And I navigate to "Created Permits to Work" screen
    And I want to edit the newly created permit
    And I enter pin 9015
    Then I should see correct permit details
    And I tear down created form

  Scenario: Verify created permit is under Created Permit to Work
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I click on back arrow
    And I navigate to "Created Permits to Work" screen
    Then I should see the newly created permit details listed on Created Permits to Work
    And I tear down created form

  Scenario: Verify deleted permit under Created Permit to Work refresh listing after deletion
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I click on back arrow
    And I navigate to "Created Permits to Work" screen
    And I delete the permit created
    Then I should see deleted permit deleted
    And I tear down created form

  Scenario Outline: Verify only competent person from EIC can sign on section 4b
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Hot Work permit
    And I select Hot Work Level-2 in Designated Area permit for level 2
    And I click on back arrow
    And I navigate to "Created Permits to Work" screen
    And I edit ptw with rank <rank> and <pin> pin
    Then I should see EIC section with fields enabled

    Examples:
      | rank                      | pin  |
      | C/O                       | 8383 |
      | Second Engineer           | 2523 |
      | Electro Technical Officer | 0856 |

  Scenario Outline: Verify AGT can add gas reading on section 6 for permit on Created state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I click on back arrow
    And I navigate to "Created Permits to Work" screen
    And I edit ptw with rank <rank> and <pin> pin
    Then I should see gas reader section with fields enabled

    Examples:
      | rank                       | pin  | level_one_permit                                              | level_two_permit                                              |
      | Master                     | 1111 | Hot Work                                                      | Hot Work Level-1 (Loaded & Ballast Passage)                   |
      | A/M                        | 9015 | Cold Work                                                     | Cold Work - Cleaning Up of Spill                              |
      | C/O                        | 8383 | Underwater Operations                                         | Underwater Operation at night                                 |
      | A C/O                      | 2761 | Rotational Portable Power Tools                               | Use of Portable Power Tools                                   |
      | 2/O                        | 6268 | Work on Electrical Equipment and Circuits – Low/High Voltage | Work on Electrical Equipment and Circuits – Low/High Voltage |
      | A 2/O                      | 7865 | Hot Work                                                      | Hot Work Level-2 in Designated Area                           |
      | 3/O                        | 0159 | Hot Work                                                      | Hot Work Level-1 (Loaded & Ballast Passage)                   |
      | A 3/O                      | 2674 | Cold Work                                                     | Cold Work - Cleaning Up of Spill                              |
      | Chief Engineer             | 8248 | Underwater Operations                                         | Underwater Operation at night                                 |
      | Additional Chief Engineer  | 1122 | Enclosed Spaces Entry                                         | Enclosed Spaces Entry                                         |
      | Second Engineer            | 2523 | Work on Electrical Equipment and Circuits – Low/High Voltage | Work on Electrical Equipment and Circuits – Low/High Voltage |
      | Additional Second Engineer | 3030 | Hot Work                                                      | Hot Work Level-2 in Designated Area                           |
      | 3/E                        | 4685 | Underwater Operations                                         | Underwater Operation at night                                 |
      | A 3/E                      | 6727 | Rotational Portable Power Tools                               | Use of Portable Power Tools                                   |
      | 4/E                        | 1311 | Rotational Portable Power Tools                               | Use of Portable Power Tools                                   |

  Scenario Outline: Verify checklist creator can only edit checklist and eic in PTW Created State
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I click on back arrow
    And I navigate to "Created Permits to Work" screen
    And I edit ptw with rank <rank> and <pin> pin
    And I navigate to section 4a
    Then I should see checklist selections fields enabled
    When I press next for 1 times
    Then I should see checklist questions fields enabled
    When I press next for 1 times
    And I should see eic selection fields enabled
    And I tear down created form

    Examples:
      | rank                       | pin  |
      | 3/O                        | 0159 |
      | A 3/O                      | 2674 |
      | 3/E                        | 4685 |
      | A 3/E                      | 6727 |
      | 4/E                        | 1311 |
      | A 4/E                      | 0703 |
      | Addtional Master           | 9015 |
      | Chief Officer              | 8383 |
      | Additional Chief Officer   | 2761 |
      | Second Officer             | 6268 |
      | Additional Second Officer  | 7865 |
      | Chief Engineer             | 8248 |
      | Additional Chief Engineer  | 2761 |
      | Second Engineer            | 2523 |
      | Additional Second Engineer | 3030 |
      | Electro Technical Officer  | 0856 |