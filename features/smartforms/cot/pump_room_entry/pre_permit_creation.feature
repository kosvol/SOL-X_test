@pre_permit_creation
Feature: Pump room entry permit creation

  @SOL-5707
  Scenario: Display message on Entry Log tab if no entry records exist
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
    Then EntryDisplay verify new entry display
      | new_entry |
      | no        |

  Scenario: Verify menu items are displayed in hamburger menu
    Given SmartForms open page
    Then SmartForms open hamburger menu
    And NavigationDrawer expand all menu items
    And NavigationDrawer verify hamburger categories


  Scenario: Verify in the form there are all questions
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    Then PumpRoomEntry verify questions

  Scenario: Verify user able to fill Date of Last Calibration
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    When PinEntry enter pin for rank "C/O"
    Then GasReadings select Date of Last Calibration as current day

  Scenario: Verify user able to see reporting interval when YES is selected
    Given SmartForms open page
    When SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And PumpRoomEntry "should not" see Reporting interval
    Then PumpRoomEntry answer question
      | question                                                                  | answer |
      | Are the personnel entering the pump room aware of the reporting interval? | Yes    |
    And PumpRoomEntry "should" see Reporting interval

  Scenario: Verify user can add Gas Test Record with toxic gas
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    And PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    When GasReadings click done button on gas reader dialog box
    Then GasReadings verify gas reading display
      | O2  | HC      | CO    | H2S   | Toxic  | Rank |
      | 1 % | 2 % LEL | 3 PPM | 4 PPM | 1.5 CC | C/O  |


  Scenario: Verify PRE can be terminated manually
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | pre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And PumpRoomEntry click Terminate
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection sleep for "1" sec
    And CommonSection verify header is "Successfully Submitted"
    And SmartForms navigate to state page
      | type | state  |
      | pre  | closed |
    Then TerminatedEntry click View
    And PinEntry enter pin for rank "C/O"


  Scenario: Verify PRE can request updates and add comment
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "2/O"
    And CommonEntry click request for update
    And CommonEntry submit comment "Test Automation"
    And CommonSection sleep for "1" sec
    And CommonSection verify header is "Successfully Submitted"
    And SmartForms navigate to state page
      | type | state          |
      | pre  | updates-needed |
    And UpdatesNeededEntry click Edit Update button
    And PinEntry enter pin for rank "C/O"
    Then CommonEntry verify comment "Test Automation"


  Scenario: Verify creator PRE cannot request update needed
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | pre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | pre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    Then CommonSection verify button availability
      | button         | availability |
      | Updates Needed | disabled     |


  Scenario: Verify Created PRE is displayed in Created PRE list
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry save temp id
    And CommonSection click Close button
    When SmartForms navigate to state page
      | type | state   |
      | pre  | created |
    Then CreatedEntry verify temp permit is displayed


  Scenario: The Responsible Officer Signature should be displayed PRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status | creator_rank |
      | pre        | ACTIVE        | C/O          |
    And SmartForms navigate to state page
      | type | state  |
      | pre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And CommonEntry check Responsible Officer Signature
      | rank | zone        |
      | C/O  | Aft Station |
