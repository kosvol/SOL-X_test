@cre_permit_creation
Feature: Compressor room entry permit creation

  Scenario: Verify new active CRE permit will replace existing active CRE permit
    Given PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms open entry display page
    And EntryDisplay wait for background update
      | type   | background |
      | active | green      |
    And EntryDisplay click "permit" tab
    And PermitDetail wait for latest permit active


  Scenario: Verify user can see all the CRE questions
    Given SmartForms open page
    And SmartForms click create entry permit
    When PinEntry enter pin for rank "C/O"
    Then CompressorRoomEntry verify form titles and questions for "CRE"
    And CompressorRoomEntry verify form titles of sections for "CRE"
    And CompressorRoomEntry verify form answers for questions for "CRE"


  Scenario: Verify gas table titles are saved correct on created CRE form
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    And CommonEntry click Add Gas Reader
    And PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    When GasReadings click done button on gas reader dialog box
    Then GasReadings verify gas reading display
      | O2  | HC      | CO    | H2S   | Toxic  | Rank |
      | 1 % | 2 % LEL | 3 PPM | 4 PPM | 1.5 CC | C/O  |


  Scenario: Verify only MAS can delete CRE permit in Created State
    Given SmartForms open page
    And SmartForms click create entry permit
    Then PinEntry enter pin for rank "C/O"
    And SmartForms navigate to state page
      | type | state   |
      | cre  | created |
    And CreatedEntry save first permit id
    And CreatedEntry click delete
    And PinEntry enter pin for rank "MAS"
    And CommonSection sleep for "3" sec
    And CreatedEntry verify deleted permit not presents in list


  Scenario: Verify user cannot send CRE for approval without start time and duration
    Given SmartForms open page
    And SmartForms click create entry permit
    And PinEntry enter pin for rank "C/O"
    When CommonEntry click submit for approval
    And CommonEntry verify validation pop up


  Scenario: Verify creator CRE cannot request update needed
    Given EntryGenerator create entry permit
      | entry_type | permit_status            |
      | cre        | PENDING_OFFICER_APPROVAL |
    And SmartForms navigate to state page
      | type | state                    |
      | cre  | pending-officer-approval |
    And PendingApprovalEntry click Officer Approval
    And PinEntry enter pin for rank "C/O"
    Then CommonSection verify button availability
      | button         | availability |
      | Updates Needed | disabled     |


  Scenario: The Responsible Officer Signature should be displayed CRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status | creator_rank |
      | cre        | ACTIVE        | C/O          |
    And SmartForms navigate to state page
      | type | state  |
      | cre  | active |
    And ActiveEntry click Submit for termination
    And PinEntry enter pin for rank "C/O"
    And CommonEntry check Responsible Officer Signature
      | rank | zone        |
      | C/O  | Aft Station |

  Scenario: The Responsible Officer Signature should be displayed in terminated list CRE
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | TERMINATED    |
    And SmartForms navigate to state page
      | type | state  |
      | cre  | closed |
    And TerminatedEntry click View
    And PinEntry enter pin for rank "C/O"
    Then CommonEntry check Responsible Officer Signature
      | rank | zone        |
      | C/O  | Aft Station |


  Scenario: Gas Reader location stamp should not be missing
    Given PermitStatusService terminate active "CRE" entry permit
    And EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And SmartForms navigate to state page
      | type | state  |
      | cre  | active |
    And ActiveEntry click Submit for termination
    When PinEntry enter pin for rank "C/O"
    Then GasReadings verify location from signature
      | location    |
      | Aft Station |
