@enclosed-space-ent
Feature: EnclosedSpaceEntryLog
  As a ...
  I want to ...
  So that ...

  Scenario: Check Enclosed Spaces Entry log is empty
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    When SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button

    Then I should see no new entry log message

  Scenario: Check button Send Report is disabled
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    When SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    Then I check the Send Report button is disabled

  Scenario: Check button Send Report is enabled
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    When SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button

    Then I check the Send Report button is enabled

  Scenario: Check enabled selected Entrants on New Entry page
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button

    Then I should see required entrants count equal 5

  Scenario: Check names of  selected Entrants on New Entry page
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button

    Then I check names of entrants 5 on New Entry page

  Scenario: Check Enclosed Spaces Entry first log
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 2               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "3" sec

    And I acknowledge the new entry log via service

    And EntryDisplay click "entry log" tab
    And NavigationDrawer click back arrow button
    And NavigationDrawer click back arrow button
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button

    Then I should see only entry log message

  Scenario: Check Enclosed Spaces Entry LOG values
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "3" sec

    And I acknowledge the new entry log via service

    And CommonSection sleep for "3" sec

    Then I should see entry log details display as filled api

  Scenario: Entry log should indicate "Competent Person" on PWT view
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button
    And AddEntrants click send report button

    And CommonSection sleep for "3" sec

    And I acknowledge the new entry log via service

    And CommonSection sleep for "3" sec

    Then I check all header-cells in Entry log table on PWT

  Scenario: Entry log should indicate "Competent Person" on Dashboard
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "3" sec

    And I acknowledge the new entry log via service

    And CommonSection sleep for "3" sec
    And NavigationDrawer click back arrow button
    And NavigationDrawer click back arrow button
    And Dashboard open dashboard page
    And Dashboard click view entry log button on dashboard
    And DashboardEntryLog switch to "ESE" log

    And I check all header-cells in Entry log table on Dashboard

  Scenario: Additional Toxic Gas Readings should be displayed only for the ESE PTW they are relating to
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And Get PRE id

    And I enter without toxic entry log

    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "3" sec
    And I acknowledge the new entry log via service
    Then I check toxic gas readings on previous PTW Entry log table
    And CommonSection sleep for "3" sec
    And NavigationDrawer click back arrow button
    And NavigationDrawer click back arrow button
    When PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    And SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "3" sec

    And I acknowledge the new entry log via service
    Then I check toxic gas readings on last PTW Entry log table

    And CommonSection sleep for "3" sec
    And NavigationDrawer click back arrow button
    And NavigationDrawer click back arrow button
    When Dashboard open dashboard page
    And Dashboard click view entry log button on dashboard
    And DashboardEntryLog switch to "ESE" log
    Then I check toxic gas readings on last PTW Entry log dashboard

  Scenario: User can't add additional entrant, who is already inside the ESE
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    Given SmartForms open page
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And Get PWT id
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | required | 5               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "3" sec

    And I acknowledge the new entry log via service

    And CommonSection sleep for "3" sec
    And NavigationDrawer click back arrow button
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    Then I should not see entered entrant on required entrant list

  Scenario: User have to choose yourself in "Add entrants" field for displaying in the log
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    When SmartForms open page
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Permit to work "Active"
    And ActivePTW click New Entrant button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    And I check the entrants "C/O" are presents on New Entry page

