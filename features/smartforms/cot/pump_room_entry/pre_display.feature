@pre_display
Feature: Pump room entry display

  Scenario: Verify PRE permit hand over is working
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active


  Scenario: Verify entrant crew list displayed the correct entrants
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And EntryService create entry record
      | MAS |
      | C/E |
      | 3/O |
    And EntryService acknowledge new gas reading
    And SmartForms open entry display page
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active
    And EntryDisplay click "entry log" tab
    And EntryDisplay click "home" tab
    Then EntryDisplay check entrants count "4"


  Scenario: Verify crew already entered pump room should not be listed on optional crew list
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
      | O/S |
    And EntryService acknowledge new gas reading
    And SmartForms open entry display page
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active
    And EntryDisplay click "home" tab
    And EntryDisplay click enter new entry log button
    And PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    Then AddEntrants verify rank exclude in other entrants menu
      | A/B |
      | O/S |

  Scenario: Verify active PRE display home page
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And PermitDetail wait for latest permit active
    And EntryDisplay click "home" tab
    Then EntryDisplay verify validity time
    And EntryDisplay verify creator "C/O"


  Scenario: PRE Verify Time Out in entry log when an entrant sign out
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
    And EntryService acknowledge new gas reading
    And PermitDetail wait for latest permit active
    And EntryDisplay click "home" tab
    And EntryDisplay sign out first entrant
    And EntryDisplay click "entry log" tab
    And EntryLog verify first entrant out time


  Scenario: Verify new gas reading notification doesn't show up when the gas reading is the same
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And EntryService create default gas reading entry record
      | MAS |
    And EntryService acknowledge new gas reading
    And EntryService create default gas reading entry record
      | MAS |
    Then EntryService verify no new gas reading


  Scenario: Verify total entrant count is 0 before new gas reading change is accepted
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active
    And EntryDisplay click "home" tab
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    And AddEntrants add new entrants
      | MAS |
      | 2/O |
    And AddEntrants click send report button
    When EntryDisplay click "home" tab
    Then EntryDisplay check entrants count "0"


  Scenario: Verify PRE display show green screen automatically after PRE becomes active
    Given PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And PermitDetail wait for latest permit active
    And EntryDisplay click "home" tab
    Then EntryDisplay wait for background update
      | type   | background |
      | active | green      |


  Scenario: PRE should not displayed permit terminated when new PRE permit is created
    Given PermitStatusService terminate active "PRE" entry permit
    When SmartForms open entry display page
    Then EntryDisplay wait for background update
      | type     | background |
      | inactive | red        |
