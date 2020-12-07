@pending-update
Feature: PendingUpdate
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify all sections fields are enabled when editing from pending approval state for RA

  # Scenario: Verify only section 9 fields are enabled when editing from pending termination state for all users

  # Scenario: Verify section 6 buttons display are correct via pending termination state

  # Scenario: Verify AGT can add gas reading

  # @skip
  # Scenario: Verify section 8 Competent Person sign button is disable for read only user via pending termination state
  #   # Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
  #   When I launch sol-x portal without unlinking wearable
  #   And I click on active filter
  #   And I click on Submit for Termination
  #   And I enter pin 9015
  #   And I submit permit for termination
  #   And I enter pin 9015
  #   And I sign on canvas
  #   And I click on back to home
  #   And I click on pending withdrawal filter
  #   And I update permit with Master rank and 1111 pin
  #   And I request update for permit
  #   And I click on back to home
  #   And I click on update needed filter
  #   And I update permit with PMAN rank and 4656 pin
  #   And I navigate to section 4b
  # # And I navigate to "Withdrawn" screen
  # # Then I should see termination date display
  # # And I should be able to view close permit

  Scenario: Verify section 6 buttons display are correct via pending master approval state as a reader
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
    And I update permit with 5/E rank and 0311 pin
    And I navigate to section 6
    Then I should see previous and close buttons
    And I tear down created form

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
    And I tear down created form

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
    When I sign on checklist with <pin> pin
    And I sign on canvas
    And I tear down created form

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
    And I update permit with 3/E rank and 0311 pin
    And I navigate to section 4a
    Then I should not see checklist selections fields enabled
    And I press next for 1 times
    And I should not see checklist questions fields enabled
    And I should not see enter pin button
    And I tear down created form
