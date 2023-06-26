@loa_fsu_dashboard
Feature: LOA Dashboard for FSU Vessel

  #TODO: add missing tests, move existing tests from other feature

  Scenario Outline: Verify Master is able to View pin (SOL-3376)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement click View PINs button
    And PinEntry enter pin for rank "<rank>"
    Then CrewManagement verify the count down timer
    And CrewManagement verify the PIN is "shown"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/E   |
      | A C/E |

  Scenario: Verify user with non-Master is not able to View pin (SOL-3376)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement click View PINs button
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
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
      | ETO   |
      | ELC   |
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |

  Scenario Outline: Verify a time zone changer is able to update ship time (SOL-8316).
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
      | C/E   |
      | A C/E |

  Scenario: Verify a not time zone changer is not able to update ship time (SOL-8316).
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
