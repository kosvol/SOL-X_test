@loa_cot_created_ptw
Feature: LOA COT Permit to Work for created

  @clear_form
  Scenario: clear form data
    Given DB service clear couch table
      | db_type | table                  |
      | edge    | forms                  |
      | cloud   | forms                  |
      | cloud   | office_approval_events |
      | edge    | gas_reader_entry       |
      | cloud   | gas_reader_entry       |
    And DB service clear postgres data

  Scenario Outline: Verify default ptw creator can create permit (SOL-8337)
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

  Scenario: Verify non default ptw creator can not create permit (SOL-8337)
    Given SmartForms open page
    And SmartForms click create permit to work
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default ptw editor can edit permit (SOL-8340)
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
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

  Scenario Outline: Verify non default ptw editor can not edit permit (SOL-8340)
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/E"
    And FormPrelude select level1 "Enclosed Space Entry"
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
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
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default dra signee can sign dra (SOL-8306)
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Section3D should see location stamp "No. 1 Cargo Tank Port"
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

  Scenario: Verify non default dra signee can not sign dra (SOL-8306)
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 3D"
    And CommonSection click sign button
    Then PinEntry verify the error message is correct for the wrong rank
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default checklist creator can sign checklist (SOL-8384)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    When CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "<rank>"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then Checklist should see location stamp "No. 1 Cargo Tank Port"
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

  Scenario: Verify non default checklist creator can not sign checklist (SOL-8384)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    And CommonSection click sign button
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default eic responsible authority can sign on responsible authority (SOL-8386)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Cold Work"
    And FormPrelude select level2 "Cold Work - Blanking/Deblanking of Pipelines and Other Openings"
    And CommonSection navigate to "Section 4B"
    And Section4B click sign button
    And PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    When Section4B should see location stamp "No. 1 Cargo Tank Port"
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

  Scenario: Verify non default eic responsible authority can not sign on responsible authority (SOL-8386)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude select level2 "Hot Work Level-2 in Designated Area"
    And CommonSection navigate to "Section 4B"
    And Section4B click sign button
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify eic competent person can sign on EIC competent person (SOL-8389)
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
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then EIC verify signed detail
      | rank   | location_stamp        |
      | <rank> | No. 1 Cargo Tank Port |
    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/E   |
      | A 2/E |
      | ETO   |
      | A C/E |

  Scenario: Verify non eic competent person can not sign on EIC competent person (SOL-8389)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Use of ODME in Manual Mode"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click competent person sign button
    Then PinEntry verify the error message is correct for the wrong rank
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
      | A/B   |
      | O/S   |
      | RDCRW |
      | C/E   |
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

  Scenario Outline: Verify eic issuing authorizer can sign on issuing authority (SOL-8391)
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
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    Then EIC verify signed detail
      | rank   | location_stamp        |
      | <rank> | No. 1 Cargo Tank Port |
    Examples:
      | rank  |
      | C/E   |
      | A C/E |

  Scenario: Verify non eic issuing authorizer can not sign on issuing authority (SOL-8391)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Underwater Operations"
    And FormPrelude select level2 "Underwater Operations at night for mandatory drug and contraband search"
    And CommonSection navigate to "Section 4B"
    And Section4B select Yes for EIC
    And Section4B click create EIC
    And EIC click issuing person sign button
    Then PinEntry verify the error message is correct for the wrong rank
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

  Scenario Outline: Verify default responsibility acceptor on responsibility acceptance (SOL-8400)
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
      | Bridge Deck | Port Bridge Wing |
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
      | BOS     |
      | A/B     |
      | O/S     |
      | SAA     |
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
      | E/C     |
      | ETO     |
      | ELC     |
      | ETR     |
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

  Scenario Outline: Verify default rank sponsor can sign on non-crew member (SOL-8402)
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
      | Bridge Deck | Port Bridge Wing |
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

  Scenario: Verify non default rank sponsor can not sign on non-crew member (SOL-8402)
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
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default responsible authority can submit for approval (SOL-8344)
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | created       | no  | no          |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Submit button
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

  Scenario: Verify non default responsible authority can not submit for approval (SOL-8344)
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | created       | no  | no          |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Submit button
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default responsible authority can submit for review (SOL-8368)
    Given PermitGenerator create permit
      | permit_type   | permit_status | eic | gas_reading |
      | underwater_op | created       | no  | no          |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Submit button
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

  Scenario: Verify not default responsible authority can not submit for review (SOL-8368)
    Given PermitGenerator create permit
      | permit_type   | permit_status | eic | gas_reading |
      | underwater_op | created       | no  | no          |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 6"
    And Section6 click Submit button
    Then PinEntry verify the error message is correct for the wrong rank
      | MAS   |
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default initial gas tester can add gas test record (SOL-8408)
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

  Scenario: Verify non default initial gas tester can not add gas test record (SOL-8408)
    Given Wearable service unlink all wearables
    And SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 6"
    And Section6 click Add Gas Test Record
    Then PinEntry verify the error message is correct for the wrong rank
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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

  Scenario Outline: Verify default ptw creator can create ROL permit (SOL-5079)
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<rank>"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
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

  Scenario Outline: Verify default rigging of ladder responsible authority can submit rol permit for approval (SOL-3679)
    Given PermitGenerator create permit
      | permit_type           | permit_status |
      | rigging_of_ladder     | created       |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Save & Next
    And RoLSectionTwo click Submit
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

  Scenario: Verify non default rigging of ladder responsible authority can not submit rol permit for approval (SOL-3679)
    Given PermitGenerator create permit
      | permit_type           | permit_status |
      | rigging_of_ladder     | created       |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection click Save & Next
    And RoLSectionTwo click Submit
    Then PinEntry verify the error message is correct for the wrong rank
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
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
