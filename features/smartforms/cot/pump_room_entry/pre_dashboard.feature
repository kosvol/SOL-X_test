@pre_dashboard
Feature: Pump room entry dashboard

  Scenario: Verify PRE Dashboard can accept new gas reading change
    Given Dashboard open dashboard page
    And PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
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


  Scenario: Verify PRE permit is terminated after dashboard terminate current permit
    Given Dashboard open dashboard page
    And PermitStatusService terminate active "PRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
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


  Scenario: Verify PRE Dashboard can close new gas reading change
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
