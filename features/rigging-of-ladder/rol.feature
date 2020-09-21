@rigging-of-ladder
Feature: RiggingOfLadder
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify data capture across status

  Scenario Outline: SOL-4477 Active RoL permit should only have 'View' and 'Submit Termination' button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin <pin>
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I set rol permit to active state with 1 duration
    And I click on back to home
    And I click on active filter
    Then I should see view and termination buttons

    Examples:
      | rank  | pin  |
      | 3/O   | 0159 |
      | A 3/O | 2674 |

  Scenario: SOL-5099 Verify no extra buttons during pending update state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    Then I should not see extra buttons

  Scenario: Verify no duplicate 'Previous' and 'Close' buttons during pending withdrawal state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I set rol permit to active state with 1 duration
    When I put the permit to termination state
    And I review termination permit with 1111 pin
    Then I should not see extra previous and close button

  Scenario Outline: SOL-5189 Verify duration is not selectable on active permit, pending termination, termination update needed states
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I set rol permit to active state with 1 duration
    And I click on back to home
    And I click on active filter
    Then I open rol permit with rank <rank> and <pin> pin
    When I press next for 1 times
    Then I should not see permit duration selectable
    When I put the permit to termination state
    And I review termination permit with <pin> pin
    And I press previous for 1 times
    Then I should not see permit duration selectable
    When I put the permit to pending termination update status
    And I click on back to home
    And I click on update needed filter
    Then I edit rol permit with rank <rank> and <pin> pin
    When I press previous for 1 times
    Then I should not see permit duration selectable

    Examples:
      | rank  | pin  |
      | A/B   | 6316 |
      | OLR   | 0450 |
      | BOS   | 1018 |
      | PMN   | 8984 |
      | ETR   | 2829 |
      | T/E   | 6829 |
      | A T/E | 1873 |
      | ELC   | 7022 |
      | O/S   | 7669 |
      | D/C   | 2317 |

  Scenario Outline: SOL-5210 Verify RA, Checklist Creator and other Crew ranks cannot edit the Duration field when the form is in the PENDING_MASTER'S_APPROVAL state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank and <pin> pin
    When I press next for 1 times
    Then I should not see permit duration selectable

    Examples:
      | rank  | pin  |
      | A/M   | 9015 |
      | A/B   | 6316 |
      | 3/E   | 4685 |
      | A 3/E | 6727 |
      | 4/E   | 1311 |
      | A 4/E | 0703 |

  Scenario: Verify ROL section labels
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    Then I should see all ROL checklist questions
      | Has information obtained from pilot station or agent for rigging arrangement?                              |
      | Working outboard guidelines in COSWP Chapter 15 read, understood and complied?                             |
      | Has consideration made for reduction of speed or making lee by alteration due to severe weather condition? |
      | Has the ladder arrangement verified by responsible officer and rigged as per IMO requirement?              |
      | Has tool box meeting carried out with task performers and explained the rigging arrangement?               |
      | Are all crew involved in the operation familiar with gangway safe operating limit?                         |
      | Has communication with the responsible officer been established ?                                          |
      | Are the ropes for gantlines and lifelines in good condition and long enough?                               |
      | PPE used as per PPE matrix and in good condition?                                                          |
      | Lifebuoy and line ready?                                                                                   |
      | Has safety harness and line securing arrangement to a strong point available?                              |
      | Life vest worn by personnel working overside? (Life vest to be fitted with self igniting light)            |
      | Is sufficient illumination available to complete the task in hours of darkness?                            |
      | Is heaving line available to transfer personnel baggage?                                                   |
      | Is the access point free of obstruction and safety walkway provided?                                       |
      | Is the ladder made fast with shipside during rigging combination ladder?                                   |