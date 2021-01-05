@pending-update
Feature: PendingUpdate
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify all sections fields are enabled when editing from pending approval state for RA
  # Scenario: Verify AGT can add gas reading

  Scenario: Verify section 6 Add Gas button should be disabled via pending termination state
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click on Submit for Termination
    And I enter pin 9015
    And I submit permit for termination
    And I sign on canvas with 9015 pin
    And I click on back to home
    And I click on pending withdrawal filter
    And I request terminating permit to be updated
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with C/O rank and 8383 pin
    Then I should see Add Gas button disabled

  Scenario: Verify update note shows from Master if request update via non OA
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    Then I should see Note from Master

  Scenario: Verify update note shows from Office if request update via OA office
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I click on update needed filter
    Then I should see Note from Office

  Scenario: Comment is not saved for the EIC when requesting the form for updates
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request for update without submitting
    And I press previous for 3 times
    And I click on view EIC certification button
    Then I should see request update comment box

  Scenario: Comment text box is missing at the top of the individual DRA screen when requesting for updates
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request for update without submitting
    And I press previous for 9 times
    And I click on View Edit Hazard
    Then I should see request update comment box

  Scenario: Verify Master should not see comment box on EIC Certification screen after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I click on update needed filter
    And I update permit with A/M rank and 1111 pin
    And I navigate to section 4b
    And I click on view EIC certification button
    Then I should not see comment box exists

  Scenario: Verify user is able to update permit after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I click on update needed filter
    And I update permit with A/M rank and 9015 pin
    And I navigate to section 3a
    And I click on View Edit Hazard
    Then I should see DRA content editable

  Scenario: Verify section 6 buttons display are correct via pending master approval state as a reader after requesting permit update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with 5/E rank and 7551 pin
    And I navigate to section 6
    Then I should see previous and close buttons

  Scenario: Verify checklist creator can edit rol checklist during active state via pending approval
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
    And I press next for 1 times
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with A 3/E rank and 6727 pin
    And I press next for 1 times
    And I should see rol checklist questions fields enabled

  Scenario Outline: Verify checklist creator can edit checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with 3/E rank and 4685 pin
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
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with 3/E rank and 7551 pin
    And I navigate to section 4a
    Then I should not see checklist selections fields enabled
    And I press next for 1 times
    And I should not see checklist questions fields enabled
# And I should not see enter pin button
