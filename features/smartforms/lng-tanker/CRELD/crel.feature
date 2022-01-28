@lng-crel
Feature: Compressor room entry log
  As a ...
  I want to ...
  So that ...

  Scenario: The log should display entries with the correct date
    #Todo: Api calls used in  step
    Given I change ship local time to -11 GMT
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks               |
      | cre        | A 2/O               |
    And I acknowledge the new entry log cre via service
    When Dashboard open dashboard page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Dashboard click view entry log button on dashboard
    And DashboardEntryLog switch to "CRE" log
    And Dashboard "save" permit date on entry log
      #Todo: Api calls used in  step
    When I terminate the PRE permit via service
    #Todo: Api calls used in  step
    Then I change ship local time to +12 GMT

    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    When Dashboard open dashboard page
    And Dashboard open new dashboard tab
    And CommonSection sleep for "5" sec
    And Dashboard switch to "first" tab in browser
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "A C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks |
      | cre        | A 2/O |
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    And Dashboard click view entry log button on dashboard
    And DashboardEntryLog switch to "CRE" log
    And Dashboard "save" permit date on entry log
    When Dashboard open dashboard page
    And CommonSection sleep for "10" sec
    And Dashboard click view entry log button on dashboard
    And DashboardEntryLog switch to "CRE" log
    And Dashboard "check" permit date on entry log

  Scenario: Entrant counter in Dashboard is updating
    Given I get active PRE permit and terminate
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks               |
      | cre        | A 2/O,3/O,A 3/O,4/O |
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    When Dashboard open dashboard page
    And CommonSection sleep for "3" sec
    And Dashboard check active entrants number "5"
    When EntryDisplayLog signout entrants by rank "A 2/O"
    And Dashboard check active entrants number "4"

  Scenario: Verify CRE permit is terminated after terminating via dashboard popup
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    When Dashboard open dashboard page
    And Dashboard open new dashboard tab
    And CommonSection sleep for "5" sec
    And Dashboard switch to "first" tab in browser
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "A C/O"
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
    And Dashboard switch to "last" tab in browser
    Then Dashboard verify gas readings acknowledge message
    And Dashboard click discard gas readings
    Then PinEntry enter pin for rank "C/O"
    And Dashboard switch to "first" tab in browser
    And EntryDisplay wait for permit
      | type   | background|
      | active |  red    |


  Scenario: CRE Dashboard Gas reading pop up should have a independent close option
    Given I get active PRE permit and terminate
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    When Dashboard open dashboard page
    And CommonSection sleep for "5" sec
    And Dashboard open new dashboard tab
    And Dashboard switch to "first" tab in browser
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "A C/O"
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
    And GasReadings click done button on gas reader dialog box
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "2/O"
    And GasReadings add normal gas readings
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
    Then PinEntry enter pin for rank "C/O"
    And Dashboard switch to "first" tab in browser
    Then Dashboard verify gas readings acknowledge message

  Scenario: [ESEL] The ESEL is displayed separately from the PREL CREL and independent of it
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
    When Dashboard open dashboard page
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
    And CommonSection sleep for "5" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks               |
      | cre        | A 3/O,4/O           |
    And CommonSection sleep for "5" sec
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    And Dashboard open new dashboard tab
    And CommonSection sleep for "5" sec
    And Dashboard click view entry log button on dashboard

    And I check the entrants "A 3/O,4/O" are not presents in dashboard log

  Scenario: User should be able to see "Change gas readings" pop-up every time when gas readings are changed
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    When Dashboard open dashboard page
    And Dashboard open new dashboard tab
    And Dashboard switch to "first" tab in browser
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "A C/O"
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
    And GasReadings click done button on gas reader dialog box
    And DB get gas entry log id
    And AcknowledgeEntry acknowledge existing gas entry record
    And NavigationDrawer click back arrow button
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add random gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 5               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And GasReadings click done button on gas reader dialog box
    And Dashboard switch to "last" tab in browser
    Then Dashboard verify gas readings acknowledge message
