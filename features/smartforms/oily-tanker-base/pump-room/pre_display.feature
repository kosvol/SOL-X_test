@PRE-display
Feature: Pump room entry display
  As a ...
  I want to ...
  So that ...

  Scenario: Verify PRE permit hand over is working
    Given SmartForms open page
    When  EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
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
    And GasReadings click done button on gas reader dialog box
    And CommonSection sleep for "5" sec

    And I acknowledge the new entry log via service
    Then I should see entry log details display as filled
    And I click on back arrow

    When  EntryGenerator create entry permit
      | entry_type | permit_status           |
      | pre        | ACTIVE APPROVAL        |
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    And I click on permit tab
    Then I should see new PRE permit number
    And I terminate the PRE permit via service

  Scenario: Verify entrant crew list displayed the correct entrants
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
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
      | optional | 0               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And GasReadings click done button on gas reader dialog box

    And I acknowledge the new entry log pre via service
    Then I should see correct signed in entrants

  Scenario: Verify crew already entered pumproom should not be listed on optional crew list
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
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
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And GasReadings click done button on gas reader dialog box

    And I acknowledge the new entry log pre via service
    Then I should see entrant count equal 2

    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    Then I should not see entered entrant on optional entrant list

  Scenario: Verify PRE duration display on PRED
    Given SmartForms open page
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    Then I should see timer countdown

  Scenario: Verify entry log details populated as filled
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And PendingApprovalEntry click approve for activation
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Scheduled"
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click back arrow button
    And CommonSection sleep for "180" sec
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
      | optional | 0               |
    And AddEntrants click confirm button
    And AddEntrants click send report button

    And GasReadings click done button on gas reader dialog box
    And I acknowledge the new entry log via service
    Then I should see entry log details display as filled

  Scenario: Verify PRE permit creator name display on PRED
    Given SmartForms open page
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    Then I should see the PRE permit creator name on PRED

  Scenario: Verify ship local time shift on PRED
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And PendingApprovalEntry click approve for activation
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Scheduled"
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click back arrow button
    And CommonSection sleep for "180" sec
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
      | optional | 0               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And GasReadings click done button on gas reader dialog box

    And I acknowledge the new entry log via service
    And I should see PRE display timezone

  Scenario: Verify exit time update to timestamp an entrant count updated after entrant sign out
    Given I clear gas reader entries
    And I get active PRE permit and terminate
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
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
    And GasReadings click done button on gas reader dialog box

    And I acknowledge the new entry log pre via service
    And I signout the entrant
    Then I should see entrant count equal 0
    And I should see exit timestamp updated

  Scenario: Verify PRE gas entry popup don't show if no difference in gas reading
    Given SmartForms open page
    When  EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
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
    And EntryDisplay click "permit" tab
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
    And CommonSection sleep for "2" sec

    Then I should not see dashboard gas reading popup

  Scenario: Verify PRE gas entry popup display if there is difference in gas reading
    Given SmartForms open page
    When  EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
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
    And CommonSection sleep for "2" sec

    Then I should see dashboard gas reading popup

  Scenario: Verify only 2 total entrant is valid after entry log approval with optional entrant
    Given I clear gas reader entries
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
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
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And GasReadings click done button on gas reader dialog box
    And CommonSection sleep for "5" sec

    And I acknowledge the new entry log pre via service
    Then I should see entrant count equal 2

  Scenario: Verify only 1 total entrant is valid after entry log approval
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
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
      | optional | 0               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "5" sec

    And GasReadings click done button on gas reader dialog box

    And I acknowledge the new entry log pre via service

    And CommonSection sleep for "5" sec

    Then I should see entrant count equal 1

  Scenario: Verify total entrant count is valid before entry log approval
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
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
      | optional | 0               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "5" sec
    And GasReadings click done button on gas reader dialog box

    Then I should see entrant count equal 0

  Scenario Outline: Verify role which CANNOT navigate to Pump Room Entry Display (6024)
    Given SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "<role>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | role |
      | ETO  |
      | D/C  |
      | BOS  |
      | A/B  |
      | O/S  |
      | OLR  |

  Scenario Outline: Verify role which CAN navigate to Pump Room Entry Display (6024)
    Given SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "<role>"
    Then PRE verify landing screen is "Pump Room Entry Display"

    Examples:
      | role  |
      | MAS   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |

  Scenario: Verify the PRED background color and buttons depends on the activity PRE.
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And PendingApprovalEntry click approve for activation
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Scheduled"
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click back arrow button
    And CommonSection sleep for "180" sec
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And CommonSection verify button availability
      | button | availability |
      | Home   | enabled      |
    And CommonSection verify button availability
      | button    | availability |
      | Entry Log | enabled      |
    And CommonSection verify button availability
      | button | availability |
      | Permit | enabled      |

    Then I set the activity end time in 1 minutes

    And CommonSection sleep for "90" sec
    And EntryDisplay wait for permit
      | type   | background|
      | active |  red      |
    And CommonSection verify button availability
      | button | availability |
      | Home   | enabled      |
    And CommonSection verify button availability
      | button    | availability |
      | Entry Log | disabled      |
    And CommonSection verify button availability
      | button | availability |
      | Permit | disabled      |
    And (for pred) I should see warning box for deactivated status

  Scenario: PRE should not displayed permit terminated when new PRE permit is created
    Given I get active PRE permit and terminate
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay check background color is "green"
    When EntryGenerator create entry permit
      | entry_type | permit_status           |
      | pre        | APPROVED_FOR_ACTIVATION |
    And EntryDisplay wait for permit
      | type     | background |
      | inactive | red        |

  Scenario: Verify PRE permit is terminated after terminating via dashboard popup
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks               |
      | pre        | A 2/O,3/O,A 3/O,4/O |

    And I get active PRE permit and terminate

    And CommonSection sleep for "10" sec
    And EntryDisplay wait for permit
      | type     | background |
      | inactive | red        |
    And EntryDisplay check background color is "red"

  Scenario: [PRED] Verify PRED displays green screen automatically after PRE becomes active
    Given SmartForms open page
    When SmartForms click create "PRE"
    Then PinEntry enter pin for rank "C/O"
    And PRE fill up permit
      | duration | delay to activate |
      | 4        | 2                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    And PendingApprovalEntry click approve for activation
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "2" sec
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Pump Room "Scheduled"
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click back arrow button
    And CommonSection sleep for "180" sec
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And CommonSection verify button availability
      | button | availability |
      | Home   | enabled      |
    And CommonSection verify button availability
      | button    | availability |
      | Entry Log | enabled      |
    And CommonSection verify button availability
      | button | availability |
      | Permit | enabled      |
    And (for pred) I should see warning box for activated status

  Scenario: PRED Entry log - Verify user stays in Entry log tab when after submitting gas readings
    Given I get active PRE permit and terminate
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
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
      | optional | 2               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    And CommonSection sleep for "2" sec
    And GasReadings click done button on gas reader dialog box

    And I acknowledge the new entry log pre via service

    And CommonSection sleep for "3" sec
    And I should see Entry Log tab

  Scenario Outline: Verify Non AGT and Gas Tester cannot submit entry log in PRED
    Given I get active PRE permit and terminate
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "<rank>"

    Then I should see not authorize error message

    Examples:
      | rank  |
      | SAA   |
      | RDCRW |
      | ETR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | RDCRW |
      | SPM   |


  Scenario Outline: Verify AGT can submit entry log in PRED
    Given I get active PRE permit and terminate
    When EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open page
    And I navigate to PRE Display until see active permit
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "<rank>"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    Examples:
      | rank  |
      | MAS   |
      | C/O   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify gas testers can submit entry log in PRED
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay click enter new entry log button
    Then PinEntry enter pin for rank "<rank>"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And AddEntrants add new entrants
      | type     | entrants_number |
      | optional | 1               |
    And AddEntrants click confirm button
    And AddEntrants click send report button
    Examples:
      | rank  |
      | 4/O   |
      | D/C   |
      | A 4/O |
      | 5/O   |
      | BOS   |
      | A/B   |
      | O/S   |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | CGENG |
      | 4/E   |
      | A 4/E |
      | T/E   |
      | 5/E   |
      | PMN   |
      | FTR   |
      | OLR   |