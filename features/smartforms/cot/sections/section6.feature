@section6
Feature: Section 6: Gas Testing/Equipment


  Scenario: Verify incomplete fields warning message displays
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    Then Section6 verify incomplete fields warning
    And Section6 verify incomplete signature warning


  Scenario: Verify copy text display when gas selection is yes
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 answer gas reading as "Yes"
    Then Section6 verify gas reading note


  Scenario: Verify submit button is disable before compulsory fields filled
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    Then Section6 verify submit button is "disabled"


  Scenario: Verify gas reading dead flow not exists
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And CommonSection click Back button
    And CommonSection click Back button
    And GasReadings add normal gas readings
    When GasReadings click Review & Sign button
    Then SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |


  Scenario: Verify user can delete added toxic gas
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings delete toxic reading
    Then GasReadings verify toxic reading count "0"


  Scenario: Verify gas reader placeholder text
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "C/O"
    And GasReadings verify placeholder text


  Scenario: Verify gas submit button is disabled before signing and location filled
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    And CommonSection verify button availability
      | button | availability |
      | Submit | disabled     |


  Scenario: Verify new gas reading without the initial toxic gas will show '-' on the row
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "2/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    And GasReadings click done button on gas reader dialog box
#    Then Section6 verify gas reading display
    Then GasReadings verify gas reading display
      | O2  | HC      | CO    | H2S   | Toxic  | Rank |
      | 1 % | 2 % LEL | 3 PPM | 4 PPM | 1.5 CC | 2/O  |
    And CommonSection sleep for "1" sec
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "2/O"
    And GasReadings add normal gas readings
    And GasReadings click Review & Sign button
    When SignatureLocation sign off
      | area        | zone             |
      | Bridge Deck | Port Bridge Wing |
    Then GasReadings verify gas reading display
      | O2  | HC      | CO    | H2S   | Toxic | Rank |
      | 1 % | 2 % LEL | 3 PPM | 4 PPM | -     | 2/O  |


  Scenario Outline: Verify non-OA level1 ptw display submit for master approval on button
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And CommonSection navigate to "Section 6"
    And Section6 verify submit button text is "Submit for Master's Approval"
    Examples:
      | level_one_permit                                             |
      | Enclosed Space Entry                                         |
      | Working Aloft / Overside                                     |
      | Work on Pressure Pipeline/Vessels                            |
      | Personnel Transfer by Transfer Basket                        |
      | Helicopter Operation                                         |
      | Work on Electrical Equipment and Circuits – Low/High Voltage |
      | Working on Deck During Heavy Weather                         |


  Scenario Outline: Verify non-OA level2 ptw display submit for master approval on button
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And CommonSection navigate to "Section 6"
    And Section6 verify submit button text is "Submit for Master's Approval"
    Examples:
      | level_one_permit                | level_two_permit                                                      |
      | Hot Work                        | Hot Work Level-2 in Designated Area                                   |
      | Hot Work                        | Hot Work Level-1 (Loaded & Ballast Passage)                           |
      | Rotational Portable Power Tools | Use of Portable Power Tools                                           |
      | Rotational Portable Power Tools | Use of Hydro blaster/working with High-pressure tools                 |
      | Cold Work                       | Cold Work - Blanking/Deblanking of Pipelines and Other Openings       |
      | Cold Work                       | Cold Work - Cleaning Up of Spill                                      |
      | Cold Work                       | Cold Work - Connecting and Disconnecting Pipelines                    |
      | Cold Work                       | Cold Work - Maintenance on Closed Electrical Equipment and Circuits   |
      | Cold Work                       | Cold Work - Maintenance Work on Machinery                             |
      | Cold Work                       | Cold Work - Removing and Fitting of Valves, Blanks, Spades, or Blinds |


  Scenario Outline: Verify OA ptw display submit for master review on button for maintenance duration more than 2 hours
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And Section1 answer duration of maintenance over 2 hours as "Yes"
    And CommonSection navigate to "Section 6"
    And Section6 verify submit button text is "Submit for Master's Review"
    Examples:
      | level_one_permit               | level_two_permit                                                           |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                      |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                         |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                 |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                  |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel      |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                             |
      | Critical Equipment Maintenance | Maintenance on Magnetic Compass                                            |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device      |
      | Critical Equipment Maintenance | Maintenance on Main Propulsion System - Shutdown Alarm & Tripping Device   |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                        |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                         |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                        |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                         |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                               |


  Scenario Outline: Verify OA level1 ptw display submit for master review on button
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And CommonSection navigate to "Section 6"
    And Section6 verify submit button text is "Submit for Master's Review"
    Examples:
      | level_one_permit                                                                |
      | Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces |
      | Use of ODME in Manual Mode                                                      |


  Scenario Outline: Verify OA level2 ptw display submit for master review on button
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    And CommonSection navigate to "Section 6"
    And Section6 verify submit button text is "Submit for Master's Review"
    Examples:
      | level_one_permit      | level_two_permit                                                                |
      | Underwater Operations | Underwater Operation during daytime without any simultaneous operations         |
      | Underwater Operations | Underwater Operation at night or concurrent with other operations               |
      | Underwater Operations | Underwater Operations at night for mandatory drug and contraband search         |
      | Hot Work              | Hot Work Level-2 outside E/R (Ballast Passage)                                  |
      | Hot Work              | Hot Work Level-2 outside E/R (Loaded Passage)                                   |
      | Hot Work              | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) |


  Scenario: Verify gas reading can disable and enable
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 answer gas reading as "N/A"
    And Section6 "should not" see gas text fields
    And Section6 "should" see gas testing disabled warning
    And Section6 answer gas reading as "Yes"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "C/O"
    And Section6 "should" see gas text fields
    Then Section6 "should not" see gas testing disabled warning


  Scenario: Verify Master can review and update button for oa permit
    Given PermitGenerator create oa pending status permit
      | permit_type     | permit_status    | oa_status             | eic | gas_reading | bfr_photo |
      | use_safe_camera | pending_approval | PENDING_MASTER_REVIEW | yes | yes         | 2         |
    And SmartForms navigate to state page
      | type | state            |
      | ptw  | pending-approval |
    And PendingApprovalPTW click Approval button
    And PinEntry enter pin for rank "MAS"
    And CommonSection navigate to "Section 6"
    Then Section6 verify submit button is "enabled"
    And Section6 verify submit button text is "Submit for Office Approval"
    Then Section6 "should" see submit and update button
