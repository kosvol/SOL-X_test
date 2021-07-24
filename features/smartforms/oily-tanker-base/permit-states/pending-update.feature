@pending-update
Feature: PendingUpdate
  As a ...
  I want to ...
  So that ...

  Scenario: Verify section 8 is editable via pending termination state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click on Submit for Termination
    And I enter pin for rank A/M
    Then I should see section 8 editable

  Scenario: Verify AGT CGENG can add gas reading via pending approval state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with CGENG rank
    And I navigate to section 6
    Then I should not see warning label
    And I should see gas_equipment_input
    And I should see gas_sr_number_input
    And I should see gas_last_calibration_button
    And I press the NA button to enable gas testing
    Then I should see warning label
    And I should not see gas_equipment_input
    And I should not see gas_sr_number_input
    And I should not see gas_last_calibration_button

  Scenario: SOL-4773 Verify submit for master approval button is enabled
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with A/M rank
    And I navigate to section 6
    Then I should see submit button enabled

  Scenario: Verify section 6 Add Gas button should be disabled via pending termination state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click on Submit for Termination
    And I enter pin for rank A/M
    And I submit permit for termination
    And I sign on canvas with valid A/M rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I request terminating permit to be updated with MAS rank
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with C/O rank
    Then I should see Add Gas button disabled

  Scenario Outline: Verify user should see master's note on all section while viewing as AGT via Pending Withdrawal state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click on Submit for Termination
    And I enter pin for rank A/M
    And I submit permit for termination
    And I sign on canvas with valid A/M rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I request terminating permit to be updated with MAS rank
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with <rank> rank
    Then I should see request update comment box

    Examples:
      | rank  | pin  |
      | 3/E   | 4685 |
      | A 3/E | 6727 |
      | 4/E   | 1311 |
      | CGENG | 1393 |


  Scenario: Verify update note shows from Master if request update via non OA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    Then I should see Note from Master

  Scenario Outline: Verify user should not see master's note on all section while viewing as Master, non RA, non Checklist Creator and non AGT via Pending Approval state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with <rank> rank
    Then I should not see request update comment box

    Examples:
      | rank | pin  |
      | PMAN | 4421 |

  Scenario: Verify update note shows from Office if request update via OA office
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on auto
    And I click on update needed filter
    Then I should see Note from Office

  Scenario: Comment is not saved for the EIC when requesting the form for updates
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request for update without submitting
    And I press previous for 3 times
    And I click on view EIC certification button
    Then I should see request update comment box

  # Scenario: Verify comment box displayed in EIC Certificate when requesting the form for updates
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 8383
  #   And I select Enclosed Spaces Entry permit
  #   And I select Enclosed Spaces Entry permit for level 2
  #   And I fill up section 1 with default value
  #   And I navigate to section 4a
  #   And I press next for 1 times
  #   And I fill up compulsory fields
  #   And I press next for 1 times
  #   And I submit permit for Master Approval
  #   And I click on back to home
  #   And I click on pending approval filter
  #   And I open a permit pending Master Approval with MAS rank
  #   And I navigate to section 7
  #   And I request update for permit
  #   And I click on back to home
  #   And I click on update needed filter
  #   And I update permit in pending update state with A/M rank
  #   And I navigate to section 4b
  #   And I click on view EIC certification button
  #   Then I should see request update comment box

  Scenario: Comment text box is missing at the top of the individual DRA screen when requesting for updates
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request for update without submitting
    And I press previous for 9 times
    And I click on View Edit Hazard
    Then I should see request update comment box

  Scenario: Verify comment box display on all section after requesting for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 8383
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with A/M rank
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times
    Then I should see request update comment
    And I press next for 1 times

  Scenario: Verify Master should not see comment box on EIC Certification screen after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on auto
    And I click on update needed filter
    And I update permit in pending update state with MAS rank
    And I navigate to section 4b
    And I click on create EIC certification button
    Then I should not see comment box exists

  @sol-7240
  Scenario: Verify checklist user should see comment box on EIC screen after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on auto
    And I click on update needed filter
    And I update permit in pending update state with 3/E rank
    And I navigate to section 4b
    And I click on view EIC certification button
    Then I should see request update comment
  # Then I should see comment box exists

  Scenario: Verify user is able to update DRA after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on auto
    And I click on update needed filter
    And I update permit in pending update state with A/M rank
    And I navigate to section 3a
    And I click on View Edit Hazard
    Then I should see DRA content editable

  Scenario: Verify section 6 buttons display are correct via pending master approval state as a reader after requesting permit update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with 5/E rank
    And I navigate to section 6
    Then I should see previous and close buttons

  Scenario: Verify checklist creator can edit rol checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I press next for 1 times
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with A 3/E rank
    And I press next for 1 times
    And I should see rol checklist questions fields enabled

  Scenario Outline: Verify checklist creator can edit checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with 3/E rank
    And I navigate to section 4a
    Then I should see checklist selections fields enabled
    And I press next for 1 times
    And I should see checklist questions fields enabled

    Examples:
      | rank  | pin  |
      | 3/E   | 4685 |
      | 4/E   | 1311 |
      | A 4/E | 0703 |

  Scenario: Verify non checklist creator cannot edit checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with 5/E rank
    And I navigate to section 4a
    Then I should not see checklist selections fields enabled
    And I press next for 1 times
    And I should not see checklist questions fields enabled
  # And I should not see enter pin button

  Scenario Outline: Verify these rank can sign off DRA on section 3D
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank
    And I navigate to section 3d
    And I sign DRA section 3d with <rank> as valid rank
    Then I should see signed details

    Examples:
      | rank  | pin  |
      | MAS   | 1111 |
      | A/M   | 9015 |
      | C/O   | 8383 |
      | A C/O | 2761 |
      | 2/O   | 6268 |
      | A 2/O | 7865 |
      | 3/O   | 0159 |
      | A 3/O | 2674 |
      | C/E   | 8248 |
      | A C/E | 5718 |
      | 2/E   | 2523 |
      | A 2/E | 3030 |
      | 3/E   | 4685 |
      | A 3/E | 6727 |
      | 4/E   | 1311 |
      | A 4/E | 0703 |
