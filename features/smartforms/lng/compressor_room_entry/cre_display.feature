@cre_display
Feature: Compressor room entry display

  Scenario: CRE should not display permit terminated when new CRE permit is created
    Given PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
    And PermitDetail wait for latest permit active
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active


  Scenario:  Left entrant can be added by log entrant again
    Given PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
      | O/S |
    And EntryService acknowledge new gas reading
    And PermitDetail wait for latest permit active
    And EntryDisplay click "home" tab
    And EntryDisplay sign out first entrant
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area      | zone       |
      | Main Deck | Forecastle |
    And AddEntrants click send report button
    When EntryDisplay click "home" tab
    Then EntryService acknowledge new gas reading


  Scenario: CRE display when there is no active entry permit
    Given PermitStatusService terminate active "CRE" entry permit
    When SmartForms open entry display page
    Then EntryDisplay wait for background update
      | type     | background |
      | inactive | red        |

  Scenario: CRE Verify Time Out in entry log when an entrant sign out
    Given PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
    And EntryService acknowledge new gas reading
    And PermitDetail wait for latest permit active
    And EntryDisplay click "home" tab
    And EntryDisplay sign out first entrant
    And EntryDisplay click "entry log" tab
    And EntryLog verify first entrant out time

  Scenario: CRE display entrant counter is updated after new entrant
    Given PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryService create entry record
      | MAS |
    And EntryService acknowledge new gas reading
    And PermitDetail wait for latest permit active
    When EntryDisplay click "home" tab
    Then EntryDisplay check entrants count "2"
