@lng-cred
Feature: Compressor room entry display
  As a ...
  I want to ...
  So that ...

  Scenario: CRED should not displayed permit terminated when new CRE permit is created
    Given SmartForms open page
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
    And CreateEntryPermit save permit id from list
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click go back button
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay check background color is "green"
    And EntryDisplay check entry display without new entry
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryDisplay check background color is "red"
    And CommonSection sleep for "30" sec
    And EntryDisplay check background color is "green"

  Scenario: [CRED] Just exited entrant can create new entry again api
    Given SmartForms open page
    When EntryGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks           |
      | cre        | A 2/O,3/O,A 3/O |
    And CommonSection sleep for "3" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    When SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    When EntryDisplayLog signout entrants by rank "A 2/O"
    And CommonSection sleep for "10" sec
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks |
      | cre        | A 2/O |
    And CommonSection sleep for "10" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    Then EntryDisplay click home tab
    And EntryDisplay check entrants count "3"

  Scenario: CRED Just exited entrant can create new entry again
    Given SmartForms open page
    When EntryGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And CommonSection sleep for "5" sec
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
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
      | optional | 5               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "10" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    And CommonSection sleep for "3" sec
    And NavigationDrawer click back arrow button
    And EntryDisplayLog signout entrants by order "1"
    Then EntryDisplay click home tab
    And EntryDisplay check entrants count "5"
    And CommonSection sleep for "5" sec
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "10" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    And NavigationDrawer click back arrow button
    Then EntryDisplay click home tab
    And EntryDisplay check entrants count "7"


  Scenario: Displaying CRED without an active CRE[SOL-6222]
    Given SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And CommonSection verify button availability
      | button | availability |
      | Home   | disabled      |
    And CommonSection verify button availability
      | button    | availability |
      | Entry Log | disabled      |
    And CommonSection verify button availability
      | button | availability |
      | Permit | enabled      |

  Scenario: [CRED] Users can exit from an active CRE[SOL-6243]
    When EntryGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks           |
      | cre        | A 2/O,3/O,A 3/O |
    And CommonSection sleep for "20" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    When SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplayLog signout entrants by rank "A 2/O"

    Then I check that entrants "A 2/O" not present in list