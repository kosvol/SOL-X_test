@ship-local-time
Feature: ShipLocalTime

  Background:
    Given ShipLocalTime set UTC to value by API 0

  Scenario: Verify the ship local time is equal to time now
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime verify the time at UTC

  Scenario: Verify the ship local time with offset is correct
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "02"
    Then ShipLocalTime set UTC min to value "30"
    And ShipLocalTime set UTC sign to value "-"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "C/O"
    And Dashboard verify the local time popup message
    Then Dashboard verify the time with offset is correct

  Scenario: Verify the user is able to set minimum range offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "12"
    And ShipLocalTime set UTC sign to value "-"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message

  Scenario: Verify the user is able to set maximum range offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC hour to value "14"
    And ShipLocalTime set UTC sign to value "+"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message

  Scenario: Verify the user is able to set local time to 45 minutes offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC min to value "45"
    And ShipLocalTime set UTC sign to value "-"
    Then ShipLocalTime click Confirm button
    And PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message

  Scenario: Verify the user is able to set local time to 30 minutes offset
    And Dashboard open dashboard page
    Then Dashboard verify the local time
    And Dashboard click time button
    Then ShipLocalTime set UTC min to value "30"
    And ShipLocalTime set UTC sign to value "+"
    Then ShipLocalTime click Confirm button
    When PinEntry enter pin for rank "C/O"
    Then Dashboard verify the local time popup message

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
