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
    And I click on pending approval filter
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
    When I click on back arrow
    And I put the permit to pending termination update status
    And I click on back to home
    And I click on update needed filter
    Then I edit rol permit with rank <rank> and <pin> pin
    When I press previous for 1 times
    Then I should not see permit duration selectable

    Examples:
      | rank | pin  |
      | A/B  | 6316 |
      | OLR  | 0450 |
      | BOS  | 1018 |
      | PMN  | 8984 |
      | ETR  | 2829 |
      | T/E  | 6829 |
      | ELC  | 7022 |
      | O/S  | 7669 |
      | D/C  | 2317 |

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
    When I press next for 1 times
    Then I should see ROL checklist questions

  Scenario: Verify termination page display previous and close buttons for read only user
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I set rol permit to active state with 1 duration
    And I click on back to home
    And I click on active filter
    Then I open rol permit with rank A/M and 9015 pin
    When I press next for 2 times
    And I submit permit for termination
    And I enter pin 9015
    And I sign on canvas
    And I click on back to home
    And I review termination permit with 0311 pin
    Then I should see previous and close buttons
    And I tear down created form