@rigging-of-ladder
Feature: RiggingOfLadder
  As a ...
  I want to ...
  So that ...

  # Scenario Outline: RA can submit Rigging of ladder permit
  #   Examples:
  #     | rank  | pin  |
  #     | A/M   | 9015 |
  #     | C/O   | 8383 |
  #     | A C/O | 2761 |
  #     | 2/O   | 6268 |
  #     | A 2/O | 7865 |
  #     | C/E   | 8248 |
  #     | A C/E | 5718 |
  #     | 2/E   | 2523 |
  #     | A 2/E | 3030 |
  #     | ETO   | 0856 |
  #     | 3/O   | 0159 |
  #     | A 3/O | 2674 |

  Scenario: Verify ROL permit validity is accurate as per permit activation duration

  Scenario: SOL-4773 Verify submit for master approval button is enabled
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 1 times
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    Then I should not see extra buttons
    When I press next for 1 times
    Then I should see submit button enabled
    And I should not see extra previous and save button

  Scenario: Verify no duplicate previous and close button when viewing permit with checklist creator only crew via pending update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A C/O
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 1 times
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I edit rol permit with rank 3/E
    And I press next for 1 times
    Then I should not see extra previous and save button

  Scenario Outline: SOL-4477 Active RoL permit should only have 'View' and 'Submit Termination' button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank <rank>
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with 1 duration
    And I click on back to home
    And I click on active filter
    Then I should see view and termination buttons

    Examples:
      | rank | pin  |
      | 3/O  | 0159 |
  # | A 3/O | 2674 |

  Scenario Outline: Verify no duplicate 'Previous' and 'Close' buttons during pending withdrawal state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank <rank>
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with 1 duration
    When I put the permit to termination state
    And I click on pending withdrawal filter
    And I withdraw permit with MAS rank
    Then I should not see extra previous and close button

    Examples:
      | rank |
      | C/E  |
  # | A 3/O |
  # | C/O   |
  # | 2/E   |
  # | A 2/E |

  Scenario Outline: SOL-5189 Verify duration is not selectable on active permit, pending termination, termination update needed states
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A 2/O
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with 1 duration
    And I click on back to home
    And I click on active filter
    Then I open rol permit with rank <rank>
    Then I should not see permit duration selectable
    When I put the permit to termination state
    And I click on pending withdrawal filter
    And I withdraw permit with <rank> rank
    And I press previous for 1 times
    Then I should not see permit duration selectable
    When I click on back arrow
    And I put the permit to pending termination update status
    And I click on back to home
    And I click on update needed filter
    Then I edit rol permit with rank <rank>
    When I press previous for 1 times
    Then I should not see permit duration selectable

    Examples:
      | rank | pin  |
      | A/B  | 6316 |
      | OLR  | 0450 |
      | BOS  | 1018 |
      | PMN  | 4637 |
      | ETR  | 6877 |
      | T/E  | 6109 |
      | ELC  | 2719 |
      | O/S  | 7669 |
      | D/C  | 2317 |

  Scenario Outline: SOL-5210 Verify RA, Checklist Creator and other Crew ranks cannot edit the Duration field when the form is in the PENDING_MASTER'S_APPROVAL state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A C/E
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank
    When I press next for 1 times
    Then I should not see permit duration selectable

    Examples:
      | rank  |
      | A/M   |
      | A/B   |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |

  Scenario: Verify ROL section labels
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A 3/O
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    Then I should see ROL checklist questions
    And I should see rol info box

  Scenario: Verify termination page display previous and close buttons for read only user
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank ETO
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select NA permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with 1 duration
    And I click on back to home
    And I click on active filter
    Then I open rol permit with rank A/M
    And I submit permit for termination
    And I sign with valid A/M rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I withdraw permit with 5/E rank
    Then I should see previous and close buttons