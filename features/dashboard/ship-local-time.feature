@ship-local-time
Feature: ShipLocalTime
  As a ...
  I want to ...
  So that ...

  Scenario: Verify base time is UTC
    Given I launch sol-x portal
    Then I should see base time is UTC

  Scenario Outline: Verify only Captain and 2nd Officer can change ship time
    Given I launch sol-x portal
    When I change local time
    And I enter pin <pin>
    Then I should see ship local time updated

    Examples:
      | pin  |
      | 1111 |
      | 6268 |
      | 2761 |

  Scenario Outline: Verify all other ranks are not allow to change time other than Captain and 2 officer
    Given I launch sol-x portal
    When I change local time
    And I enter pin <pin>
    Then I should see not authorize error message

    Examples:
      | pin  |
      | 9015 |
      | 8383 |
      | 7865 |
      | 0159 |
      | 2674 |
      | 1010 |
      | 2317 |
      | 5122 |
      | 0110 |
      | 2523 |
      | 3030 |
      | 4844 |
      | 6727 |
      | 1311 |
      | 6894 |
      | 0856 |
      | 1018 |
      | 4236 |
      | 6316 |
      | 7669 |
      | 0450 |

# @manual
# Scenario: Verify ship's local time only limit at -12 to +14


################## ----WILL NOT BE HERE----- ##################

# @manual
# Scenario: Verify local time with timezone change reflect on PDF and EMAIL (DRA,Gas Reading,Checklist,Toolbox and section 7) ie. xxx LT (GTM -/+ 8)
#           Entry to reflect entry time, as time shifted, it should use the shifted time until submission

# Scenario: Verify PRED show ship local time change on active PRE

# Scenario: Verify section 1 of PRE gas reading display ship's local time with timezone change

# Scenario: Verify section 6 of standard PTW gas reading display ship's local time with timezone change