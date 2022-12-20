@ship-local-time
Feature: ShipLocalTime
  As a ...
  I want to ...
  So that ...


  Scenario: Verify base time is UTC
    Given Dashboard open dashboard page
    And Dashboard click time button
    Then ShipLocalTime verify the time at UTC
    And CommonSection sleep for "4" sec
    And PinEntry enter pin for rank "C/O"

  @test
  Scenario: Verify the minimum range offset
    Given Dashboard open dashboard page
    And CommonSection sleep for "4" sec
    And Dashboard click time button
    And CommonSection sleep for "1" sec
    Then ShipLocalTime set UTC to minimum


  Scenario Outline: Verify only Captain and 2nd Officer can change ship time
    Given I launch sol-x portal
    When I change local time
    And I enter pin for rank <rank>
    Then I should see ship local time updated

    Examples:
      | rank |
      | A/M  |
      | MAS  |
      | C/O  |
      | 2/O  |

  Scenario Outline: Verify all other ranks are not allow to change time other than Captain and 2 officer
    Given I launch sol-x portal
    When I change local time
    And I enter pin for rank <rank>
    Then I should see not authorize error message

    Examples:
      | rank  |
      | 3/O   |
      | A 3/O |
      | D/C   |
      | C/E   |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | ETO   |
      | BOS   |
      | A/B   |
      | O/S   |
      | OLR   |