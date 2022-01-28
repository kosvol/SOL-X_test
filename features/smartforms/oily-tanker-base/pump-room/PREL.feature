@PREL
Feature: Pump room entry log
  As a ...
  I want to ...
  So that ...

  Scenario: Verify PRE permit is terminated after terminating via dashboard popup
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    When Dashboard open dashboard page
    And CommonSection sleep for "5" sec
    And Dashboard open new dashboard tab
    And CommonSection sleep for "5" sec
    And Dashboard switch to "first" tab in browser
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 3               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And Dashboard switch to "last" tab in browser
    Then Dashboard verify gas readings acknowledge message
    And Dashboard click discard gas readings
    And PinEntry enter pin for rank "C/O"
    And Dashboard switch to "first" tab in browser
    And EntryDisplay wait for permit
      | type   | background|
      | active |  red      |

  Scenario: PRE Dashboard Gas reading pop up should have a independent close option
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    When Dashboard open dashboard page
    And Dashboard open new dashboard tab
    And Dashboard switch to "first" tab in browser
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 0               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    And CommonSection sleep for "5" sec
    And GasReadings click done button on gas reader dialog box
    And NavigationDrawer click back arrow button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "2/O"
    And GasReadings add gas readings
      | o2_gas | hc_gas | h2s_gas | co_gas |
      | 5      | 7      | 8       | 11     |
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "5" sec
    And Dashboard switch to "last" tab in browser
    Then Dashboard verify gas readings acknowledge message
    And Dashboard click close gas readings message
    And PinEntry enter pin for rank "A C/O"
    And Dashboard switch to "first" tab in browser
    Then Dashboard verify gas readings acknowledge message

  Scenario: Dashboard - Verify updated view and icon is displayed in Dashboard main page for entry log and PRE status
    Given I get active PRE permit and terminate
    And Dashboard open dashboard page
    When I check PRE elements on dashboard inactive
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks |
      | pre        | A 2/O |
    And CommonSection sleep for "5" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record

    When I check PRE elements on dashboard active
