@ship-local-time
Feature: ShipLocalTime
  As a ...
  I want to ...
  So that ...
  Background:
    Given ShipLocalTime set UTC to value by API 0


  #pass
  Scenario: Verify the ship local time is equal to time now
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime verify the time at UTC
    @test
  Scenario: Verify the ship local time with offset is correct
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "02"
    Then ShipLocalTime set UTC min to value "30"
    And ShipLocalTime set UTC sign to value "-"
    Then ShipLocalTime verify the time with offset is correct

  #pass
  Scenario: Verify the user is able to set minimum range offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "12"
    And ShipLocalTime set UTC sign to value "-"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message
  #pass
  Scenario: Verify the user is able to set maximum range offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "14"
    And ShipLocalTime set UTC sign to value "+"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message
  #pass
  Scenario: Verify the user is able to set local time to 45 minutes offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC min to value "45"
    And ShipLocalTime set UTC sign to value "-"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message
  #pass
  Scenario: Verify the user is able to set local time to 30 minutes offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC min to value "30"
    And ShipLocalTime set UTC sign to value "+"
    Then ShipLocalTime click Confirm button
    When PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message
  #pass
  Scenario: Verify the user is able to set local time to 00 offset
    Given ShipLocalTime set UTC to value by API 390
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "00"
    And ShipLocalTime set UTC min to value "00"
    Then ShipLocalTime click Confirm button
    When PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message
  #pass
  Scenario Outline: Verify a time zone changer is able to update ship time.
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "01"
    And ShipLocalTime set UTC min to value "30"
    And ShipLocalTime set UTC sign to value "-"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "<rank>"
    Then Dashboard verify the local time popup message
    Examples:
     | rank  |
     | MAS   |
     | A/M   |
     | C/O   |
     | A C/O |
     | 2/O   |
     | A 2/O |
     | 3/O   |
     | A 3/O |
#pass
  Scenario: Verify a not time zone changer is not able to update ship time.
    And Dashboard open dashboard page
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "02"
    And ShipLocalTime set UTC min to value "45"
    And ShipLocalTime set UTC sign to value "+"
    Then ShipLocalTime click Confirm button
    And PinEntry verify the error message is correct for the wrong rank
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |



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