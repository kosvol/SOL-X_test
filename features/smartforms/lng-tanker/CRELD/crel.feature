@lng-crel
Feature: Compressor room entry log
  As a ...
  I want to ...
  So that ...

  Scenario: The log should display entries with the correct date
    Given I change ship local time to -11 GMT
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |

    And I add new entry "A 2/O" CRE
    And I acknowledge the new entry log cre via service
    And I save permit date on Dashboard LOG
    When I terminate the PRE permit via service
    Then I change ship local time to +12 GMT
    When I submit a current CRE permit via service

    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks |
      | cre        | A 2/O |
    And I acknowledge the new entry log cre via service

    And I save permit date on Dashboard LOG
    When I launch sol-x portal dashboard

    And CommonSection sleep for "10" sec

    And I go to CRE log in dashboard
    Then I check permit date on Dashboard LOG

  Scenario: Entrant counter in Dashboard is updating
    Given I get active PRE permit and terminate
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks               |
      | cre        | A 2/O,3/O,A 3/O,4/O |

    And I acknowledge the new entry log cre via service
    When I launch sol-x portal dashboard
    And CommonSection sleep for "3" sec
    And I check number 5 of entrants on dashboard
    When I signout entrants "A 2/O"
    And I check number 4 of entrants on dashboard
    And I terminate the PRE permit via service

  Scenario: Verify CRE permit is terminated after terminating via dashboard popup
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    When I launch sol-x portal dashboard
    And CommonSection sleep for "5" sec
    And I open new dashboard page
    And CommonSection sleep for "5" sec
    And I switch to first tab in browser

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


    And I switch to last tab in browser
    Then I should see alert message
    And I click terminate new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see red background color
    And I should see Permit Terminated CRE status on screen

  Scenario: CRE Dashboard Gas reading pop up should have a independent close option
    Given I get active PRE permit and terminate
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    When I launch sol-x portal dashboard
    And CommonSection sleep for "5" sec
    And I open new dashboard page
    And I switch to first tab in browser

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
    And I acknowledge the new entry log cre via service
    And I dismiss gas reader dialog box
    And I enter random entry log with role 2/O
    And I send entry report with 1 optional entrants
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "5" sec
    And I switch to last tab in browser
    Then I should see alert message
    And I click close new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see alert message

  Scenario: [ESEL] The ESEL is displayed separately from the PREL CREL and independent of it
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |

    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I take note of issued date and time
    And I click New Entrant button on Enclose Space Entry PWT
    And Get PWT id

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

    And I acknowledge the new entry log via service

    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks               |
      | cre        | A 3/O,4/O           |
    And CommonSection sleep for "5" sec

    And I acknowledge the new entry log cre via service
    And I open new dashboard page
    And CommonSection sleep for "5" sec
    And I go to ESE log in dashboard
    And I check the entrants "A 3/O,4/O" are not presents in dashboard log

  Scenario: User should be able to see "Change gas readings" pop-up every time when gas readings are changed
    Given PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |

    When I launch sol-x portal dashboard
    And I open new dashboard page
    And I switch to first tab in browser

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

    And I dismiss gas reader dialog box
    And I acknowledge the new entry log cre via service

    And NavigationDrawer click back arrow button

    And I enter random entry log

    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button

    And I dismiss gas reader dialog box
    And I switch to last tab in browser
    Then I should see alert message
