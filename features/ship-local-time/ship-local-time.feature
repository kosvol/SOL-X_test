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
      | 6666 |

  Scenario Outline: Verify all other ranks are not allow to change time other than Captain and 2 officer
    Given I launch sol-x portal
    When I change local time
    And I enter pin <pin>
    Then I should see invalid pin message

    Examples:
      | pin  |
      | 1212 |
# | 4444 |
# | 5555 |
# | 7777 |
# | 8888 |
# | 9999 |
# | 1010 |
# | 1616 |
# | 2222 |
# | 0110 |
# | 1313 |
# | 1414 |
# | 3333 |
# | 1515 |
# | 2323 |
# | 2424 |
# | 1717 |
# | 1818 |
# | 2020 |
# | 2121 |
# | 1919 |
# | 0220 |

# @manual
# Scenario: Verify ship's local time only limit at -12 to +14


################## ----WILL NOT BE HERE----- ##################

# @manual
# Scenario: Verify time change reflects on Wearable and Dashboard

# @manual
# Scenario: Verify local time with timezone change reflect on PDF and EMAIL (DRA,Gas Reading,Checklist,Toolbox and section 7) ie. xxx LT (GTM -/+ 8)
#           Entry to reflect entry time, as time shifted, it should use the shifted time until submission

# Scenario: Verify PRED show ship local time change on active PRE

# Scenario: Verify section 1 of PRE gas reading display ship's local time with timezone change

# Scenario: Verify section 6 of standard PTW gas reading display ship's local time with timezone change