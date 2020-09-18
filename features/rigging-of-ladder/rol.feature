@rigging-of-ladder
Feature: RiggingOfLadder
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Active RoL permit should only have 'View' and 'Submit Termination' button created via 3/O and A 3/O
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

  Scenario: Verify no extra buttons during pending update state
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

  Scenario Outline: Verify duration is not selectable on active permit, pending termination, termination update needed states
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

  Scenario: shoud not SOL-5210 -  RA, Checklist Creator and other Crew ranks (except Captain=MAS) can edit the Duration field when the form is in the PENDING_MASTER'S_APPROVAL state

  Scenario: Verify DRA (FR-S05) is display

  Scenario: should not - Permit Validity block is active when review the form as RA from the Pending Approval state

  Scenario: Verify data capture across status

  Scenario: Verify ROL section labels