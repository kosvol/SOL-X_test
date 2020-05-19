@dra-section-a
Feature: DRASectionA
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify xxx form of DRA section A contents
    Given I launch sol-x portal
    When I navigate to section a of DRA on xxx form
    Then I should see <hazard> page 1 details
    When I edit method and hazards
    Then I should see <hazard> details

    Examples:
    | xxx |

    Scenario: Verify section 4a checklist contents

    Scenario: Verify risk matrix change to high, medium, high

    Scenario: Verify progress bar with all checklist selection on section 4a

    Scenario: Verify pending approval

    Scenario: Verify terminated

    Scenario: Verify update needed