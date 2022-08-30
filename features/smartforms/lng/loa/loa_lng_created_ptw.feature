@loa_lng_created_ptw
Feature: LOA LNG Permit to Work for created

  @clear_form_lng
  Scenario: clear form data
    Given DB service clear couch table
      | db_type | table                  |
      | edge    | forms                  |
      | cloud   | forms                  |
      | cloud   | office_approval_events |
      | edge    | gas_reader_entry       |
      | cloud   | gas_reader_entry       |
    And DB service clear postgres data


  Scenario Outline: Verify default ptw creator can create permit
    Given SmartForms open page
    And SmartForms click create permit to work
    When PinEntry enter pin for rank "<rank>"
    Then FormPrelude should see select permit type header
    Examples:
      | rank  |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify only default ptw creator can create permit
    Given SmartForms open page
    And SmartForms click create permit to work
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | 5/O   |
      | 5/E   |
      | T/E   |
      | E/C   |
      | ETR   |
      | O/S   |
      | SAA   |
      | D/C   |
      | BOS   |
      | PMN   |
      | A/B   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | RDCRW |
      | SPM   |


  Scenario Outline: Verify default ptw editor can edit permit
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "1" sec
    And CreatedPTW click first permit id
    And PinEntry enter pin for rank "<rank>"
    Then Section1 verify next button is "Save & Next"
    Examples:
      | rank  |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify non default ptw editor can not edit permit
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "1" sec
    And CreatedPTW click first permit id
    And PinEntry enter pin for rank "<rank>"
    Then Section1 verify next button is "Next"
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify default dra signee can sign dra
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone              |
      | Trunk Deck | No. 1 Cargo Tank |
    Then Section3D should see location stamp "No. 1 Cargo Tank"
    And Section3D verify signature rank "<rank>"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify non default dra signee can not sign dra
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify default checklist creator can sign checklist
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone              |
      | Trunk Deck | No. 1 Cargo Tank |
    Then Checklist should see location stamp "No. 1 Cargo Tank"
    And Checklist verify signature rank "<rank>"
    Examples:
      | rank  |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify non default checklist creator can not sign checklist
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    And CommonSection click sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify default eic responsible authority can sign on responsible authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Cold Work"
    And FormPrelude select level2 "Cold Work - Blanking/Deblanking of Pipelines and Other Openings"
    And CommonSection navigate to "Section 4B"
    And Section4B click sign button
    And PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off
      | area      | zone              |
      | Trunk Deck | No. 1 Cargo Tank |
    When Section4B should see location stamp "No. 1 Cargo Tank"
    Then Section4B verify signature rank "<rank>"
    Examples:
      | rank  |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify non default eic responsible authority cannot sign on responsible authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    And CommonSection navigate to "Section 4B"
    And Section4B click sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify eic competent person can sign on EIC competent person
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click competent person sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone              |
      | Trunk Deck | No. 1 Cargo Tank |
    Then EIC verify signed detail
      | rank   | location_stamp        |
      | <rank> | No. 1 Cargo Tank |
    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/E   |
      | A 2/E |
      | ETO   |


  Scenario Outline: Verify non eic competent person can not sign on EIC competent person
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click competent person sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | C/E   |
      | A C/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify eic issuing authorizer can sign on issuing authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click issuing person sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone              |
      | Trunk Deck | No. 1 Cargo Tank |
    Then EIC verify signed detail
      | rank   | location_stamp       |
      | <rank> | No. 1 Cargo Tank     |
    Examples:
      | rank  |
      | C/E   |
      | A C/E |


  Scenario Outline: Verify non eic issuing authorizer can not sign on issuing authority
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Underwater Operations"
    And FormPrelude select level2 "Underwater Operations at night for mandatory drug and contraband search"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click issuing person sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify default responsibility acceptor on responsibility acceptance
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area        | zone             |
      | Bow Area    | Bosun Store      |
    Then Section5 verify signature
      | role                 | rank   |
      | Authorized Entrant 1 | <rank> |
    Examples:
      | rank    |
      | MAS     |
      | A/M     |
      | C/O     |
      | A C/O   |
      | 2/O     |
      | A 2/O   |
      | 3/O     |
      | A 3/O   |
      | 4/O     |
      | A 4/O   |
      | 5/O     |
      | D/C     |
#      | A D/C   |
#      | D/CDT   |
#      | A D/CDT |
      | BOS     |
#      | A BOS   |
      | A/B     |
      | O/S     |
      | SAA     |
#      | A SAA   |
      | C/E     |
      | A C/E   |
      | 2/E     |
      | A 2/E   |
      | 3/E     |
      | A 3/E   |
      | CGENG   |
      | 4/E     |
      | A 4/E   |
      | 5/E     |
      | T/E     |
#      | A T/E   |
      | E/C     |
#      | A E/C   |
#      | E/CDT   |
#      | A E/CDT |
      | ETO     |
#      | A ETO   |
      | ELC     |
      | ETR     |
#      | PMAN    |
      | PMN     |
      | FTR     |
      | OLR     |
      | WPR     |
      | CCK     |
      | 2CK     |
      | STWD    |
      | FSTO    |
      | RDCRW   |
      | SPM     |


  Scenario Outline: Verify default rank sponsor can sign on non-crew member
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Sign as non-crew member
    And Section5 enter non-crew info
      | name                 | company                 |
      | test_crew_automation | test_company_automation |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area        | zone             |
      | Bow Area    | Bosun Store      |
    Then Section5 verify supervised signature
      | rank   | role                 | name                 | company                 |
      | <rank> | Authorized Entrant 1 | test_crew_automation | test_company_automation |
    Examples:
      | rank  |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify non default rank sponsor can not sign on non-crew member
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Sign as non-crew member
    And Section5 enter non-crew info
      | name                 | company                 |
      | test_crew_automation | test_company_automation |
    And Section5 click Enter PIN & Sign button
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify default responsible authority can submit for approval
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | created       | no  | no          |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "2" sec
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click submit button
    When PinEntry enter pin for rank "<rank>"
    Then SignatureLocation click location dropdown
    Examples:
      | rank  |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify non default responsible authority can not submit for approval
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | created       | no  | no          |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "2" sec
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click submit button
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


  Scenario Outline: Verify default initial gas tester can add gas test record
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "<rank>"
    Then GasReadings add normal gas readings
    Examples:
      | rank  |
      | MAS   |
      | A/M   |
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
      | ETO   |
      | CGENG |


  Scenario Outline: Verify non default initial gas tester can not add gas test record
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    And PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | O/S   |
      | A/B   |
      | RDCRW |
      | 5/E   |
      | E/C   |
      | ELC   |
      | ETR   |
      | T/E   |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |


# TODO: will do it later
#  Scenario Outline: Verify rigging of ladder responsible authority can submit for rigging permit approval
#  Scenario Outline: Verify non rigging of ladder responsible authority can not submit for rigging permit approval