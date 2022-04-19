@cre_dashboard
Feature: Compressor room entry dashboard

  Scenario: Verify CRE Dashboard can accept new gas reading change
    Given Dashboard open dashboard page
    And PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
      | O/S |
    And Dashboard accept new gas readings
    And PinEntry enter pin for rank "C/O"
    And Dashboard verify entry status "Active"
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
    Then EntryDisplay check entrants count "3"


  Scenario: Verify CRE permit is terminated after dashboard terminate current permit
    Given Dashboard open dashboard page
    And PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
      | O/S |
    And Dashboard click terminate current permit
    And PinEntry enter pin for rank "C/O"
    And Dashboard verify entry status "Inactive"
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | red        |


  Scenario: Verify CRE Dashboard can close new gas reading change
    Given Dashboard open dashboard page
    And PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
      | O/S |
    And Dashboard verify gas readings change alert
    And Dashboard click close gas readings message
    Then PinEntry enter pin for rank "C/O"


  Scenario: The enclosed spaced entry can log new entrant and dashboard can acknowledge
    Given Dashboard open dashboard page
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | active        | yes | yes         | 2         |
    And EntryService create entry record
      | A/B |
      | O/S |
    When Dashboard acknowledge gas reading change
    Then PinEntry enter pin for rank "C/O"

  Scenario: User should be able to see "Change gas readings" pop-up every time when gas readings are changed
    Given Dashboard open dashboard page
    And PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryService create entry record
      | A/B |
      | O/S |
    And Dashboard accept new gas readings
    And PinEntry enter pin for rank "C/O"
    And Dashboard verify entry status "Active"
    And EntryService create entry record
      | A/B |
      | O/S |
    And Dashboard accept new gas readings
    And PinEntry enter pin for rank "C/O"
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
