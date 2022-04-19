@pending-update
Feature: PendingUpdate
  As a ...
  I want to ...
  So that ...

  Scenario: Verify section 8 is editable via pending termination state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with C/O rank
    Then I should see section 8 editable

  Scenario Outline: Verify AGT can add gas reading via pending approval state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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

    Examples:
      | rank  |
      | MAS   |
      | A 4/E |
      | CGENG |

  Scenario: SOL-4773 Verify submit for master approval button is enabled
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I update permit in pending update state with C/O rank
    And I navigate to section 6
    Then I should see submit button enabled
  # Then I should not see submit for approval button
  # And I should see x button enabled

  Scenario: Verify section 6 Add Gas button should be disabled via pending termination state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with C/O rank
    And I submit permit for termination
    And I sign with valid C/O rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I request terminating permit to be updated with MAS rank
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with A/M rank
    And I press previous for 3 times
    Then I should see Add Gas button disabled

  Scenario Outline: Verify user should see master's note on all section while viewing as AGT via Pending Withdrawal state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with C/O rank
    And I submit permit for termination
    And I sign with valid C/O rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I request terminating permit to be updated with MAS rank
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit in pending update state with <rank> rank
    Then I should see request update comment is Test Automation

    Examples:
      | rank  |
      | A 4/E |

  Scenario: Verify update note shows from Master if request update via non OA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
      | rank |
      | PMAN |

  Scenario: Verify update note shows from Office if request update via OA office
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
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

  @SOL-7468
  Scenario: Verify action required note respect sender
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
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
    And I update permit in pending update state with C/O rank
    And I navigate to section 6
    And I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 6
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    Then I should see Note from Master

  Scenario: Comment is not saved for the EIC when requesting the form for updates
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
  #   And I enter pin for rank C/O
  #   And I select Enclosed Spaces Entry permit
  #   And I select NA permit for level 2
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
  #   And I update permit in pending update state with C/O rank
  #   And I navigate to section 4b
  #   And I click on view EIC certification button
  #   Then I should see request update comment box

  Scenario: Comment text box is missing at the top of the individual DRA screen when requesting for updates
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I update permit in pending update state with C/O rank
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation
    And I press next for 1 times
    Then I should see request update comment is Test Automation

  Scenario: Verify Master should not see comment box on EIC Certification screen after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
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
    And I enter pin for rank C/O
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill only location of work and duration more than 2 hours
    And I press next for 7 times
    And I sign checklist and section 5 and EIC cert add
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
    And I click on create EIC certification button
    Then I should see request update comment is Test Automation Updated


  Scenario: Verify user is able to update DRA after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
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
    And I update permit in pending update state with C/O rank
    And I navigate to section 3a
    And I click on View Edit Hazard
    Then I should see DRA content editable

  Scenario: Verify section 6 buttons display are correct via pending master approval state as a reader after requesting permit update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I enter pin for rank C/O
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
    And I update permit in pending update state with A 3/E rank
    And I press next for 1 times
    And I should see rol checklist questions fields enabled

  Scenario Outline: Verify checklist creator can edit checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I navigate to section 4a
    Then I should see checklist selections fields enabled
    And I press next for 1 times
    And I should see checklist questions fields enabled

    Examples:
      | rank  |
      | 3/E   |
      | 4/E   |
      | A 4/E |

  Scenario: Verify non checklist creator cannot edit checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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

  Scenario Outline: Verify location stamping on signature section for issuing authority
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I navigate to section 4b
    And I link wearable to a issuing authority <user> and link to zoneid <zoneid> and mac <mac>
    And I select yes to EIC
    And I click on create EIC certification button
    Then I sign EIC as issuing authority with rank <rank>
    And I set time
    And I should see signed details
    Then I should see location <location_stamp> stamp

    Examples:
      | user          | rank  | zoneid       | mac               | location_stamp | level_one_permit                | level_two_permit            |
      # | AUTO_SOLX0002 | C/E   | Z-FORECASTLE | 00:00:00:00:00:01 | IG Platform 2  | Rotational Portable Power Tools | Use of Portable Power Tools |
      | AUTO_SOLX0002 | A C/E | Z-FORECASTLE | 00:00:00:00:00:01 | IG Platform 2  | Rotational Portable Power Tools | Use of Portable Power Tools |

  Scenario Outline: Verify location stamping on signature section for competent person
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
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
    And I navigate to section 4b
    And I link wearable to a competent person <user> and link to zoneid <zoneid> and mac <mac>
    And I select yes to EIC
    And I click on create EIC certification button
    Then I sign EIC as competent person with rank <rank>
    And I set time
    And I should see signed details
    Then I should see location <location_stamp> stamp

    Examples:
      | user          | rank  | zoneid        | mac               | location_stamp | level_one_permit                | level_two_permit            |
      # | AUTO_SOLX0011 | C/O   | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools |
      | AUTO_SOLX0004 | A 2/E | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools |
# | AUTO_SOLX0021 | ETO   | Z-AFT-STATION | 00:00:00:00:00:10 | Aft Station    | Rotational Portable Power Tools | Use of Portable Power Tools |
