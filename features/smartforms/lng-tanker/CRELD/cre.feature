@lng-cre
Feature: Compressor room entry creation
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify new scheduled CRE permit will replace existing active CRE permit
  Scenario: Verify new active CRE permit will replace existing active CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And Service activate "CRE" permit
    #And I getting a permanent number from indexedDB

    And I navigate to "Active" screen for CRE
    And I should see the current CRE in the "Active CRE" list
    When I submit a current CRE permit via service
    And CommonSection sleep for "5" sec
    And SmartForms click back arrow button
    And I navigate to "Active" screen for CRE
    And I should not see the current CRE in the "Active CRE" list
    Then I should see that existed CRE number not equal with number Active list
    And SmartForms click back arrow button
    When I navigate to "Terminated" screen for CRE
    And I should see the current CRE in the "Closed CRE" list

  Scenario: Verify user can see all the CRE questions
    Given SmartForms open page
    When SmartForms click create "CRE"
    And PinEntry enter pin for rank "C/O"
    Then CRE Verify form titles and questions
    Then CRE Verify form titles of sections
    Then CRE Verify form answers for questions

  Scenario Outline: Verify only these crew can create CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "<rank>"
    Then CRE verify landing screen is "Compressor/Motor Room Entry"

    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario Outline: Verify these crew cannot create CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"

    Examples:
      | rank  |
      | MAS   |
      | A/M   |
      | C/E   |
      | 2/E   |
      | ETO   |
      | A 2/E |
      | D/C   |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | BOS   |
      | A/B   |
      | O/S   |
      | OLR   |


  Scenario: Verify AGT can add gas reading in CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And I set time
    Then I will see popup dialog with C/O LNG C/O crew rank and name
    When I dismiss gas reader dialog box
    Then I should see gas reading display with toxic gas and C/O LNG C/O as gas signer

  Scenario Outline: Verify any rank can add gas reading in CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"

    And I add all gas readings with <rank> rank
    When I dismiss gas reader dialog box

    Examples:

      | rank |
      | PMAN |
      | ETO  |
      | ELC  |

  Scenario: Verify CRE Chief Officer can approve the same permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button

    #And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And for cre I should see the enabled "Approve for Activation" button

  Scenario Outline: Verify CRE roles cannot approve the same permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button

    #And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: <rank>
    And for cre I should see the disabled "Approve for Activation" button
    Examples:

      | rank  |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify non CRE creator can approve the same permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "A C/O"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button

    #And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: A C/O
    Then I should see CRE landing screen

  Scenario Outline: Verify these roles can terminate CRE permit
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "<rank>"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "<rank>"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "<rank>"
    And SignatureLocation sign off first zone area
    And CreateEntryPermit verify element type "page" with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    #And I getting a permanent number from indexedDB

    Then I activate the current CRE form
    And CommonSection sleep for "1" sec
    When I navigate to "Scheduled" screen for CRE
    And I should see the current CRE in the "Scheduled" list
    And SmartForms click back arrow button
    And I activate CRE form via service
    And I navigate to "Active" screen for CRE
    And I should see the current CRE in the "Active CRE" list
    And SmartForms click back arrow button
    And CommonSection sleep for "1" sec
    Then I terminate the CRE with rank <rank>
    When I navigate to "Terminated" screen for CRE
    And I should see the current CRE in the "Closed CRE" list

    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify only MAS can delete CRE permit in Created State
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"

    And SmartForms click back arrow button
    And I navigate to "Created" screen for CRE
    And I delete the permit created
    Then I should see deleted permit deleted

  Scenario: Verify user cannot send CRE for approval with start time and duration
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"

    And for cre I should see the disabled "Submit for Approval" button

  Scenario: Verify these roles can request update for CRE permit in Pending Approval State
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area
    And for cre I submit permit for A C/O Approval

   # And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: A 3/O
    Then I should see Approve for Activation button enabled
    Then I should see Updates Needed button enabled

  Scenario: Verify CRE permit turn active on schedule time
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    Then I activate the current CRE form
    And CommonSection sleep for "1" sec
    When I navigate to "Scheduled" screen for CRE
    And I should see the current CRE in the "Scheduled" list
    And SmartForms click back arrow button
    And I activate CRE form via service
    And I navigate to "Active" screen for CRE
    And I should see the current CRE in the "Active PRE" list

  Scenario: Verify creator PRE cannot request update needed
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    Then I open the current PRE with status Pending approval. Rank: C/O
    Then I should see Add Gas button enabled
    And I should see Updates Needed button disabled

  Scenario: The Responsible Officer Signature should be displayed CRE
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 10                |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And CreateEntryPermit save current start and end validity time for "CRE"
    And I check "Responsible Officer Signature" is present
    When I press the "Approve for Activation" button
    And I sign with valid C/O rank
    And I should see the page 'Permit Successfully Scheduled for Activation'
    Then I press the "Back to Home" button
    And CommonSection sleep for "1" sec
    When I navigate to "Scheduled" screen for CRE
    And I should see the current CRE in the "Scheduled" list
    When I view permit with C/O rank
    And I check "Responsible Officer Signature" is present

  Scenario: The Responsible Officer Signature should be displayed in terminated list CRE
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And CreateEntryPermit save current start and end validity time for "CRE"
    When I press the "Approve for Activation" button
    And I sign with valid C/O rank
    And I should see the page 'Permit Successfully Scheduled for Activation'
    Then I press the "Back to Home" button
    And CommonSection sleep for "1" sec
    And I activate CRE form via service
    And CommonSection sleep for "10" sec
    Then I terminate the CRE permit via service
    When I navigate to "Terminated" screen for CRE
    And I should see the current CRE in the "Terminated" list
    When I view permit with C/O rank
    And I check "Responsible Officer Signature" is present

  Scenario: Gas Reader location stamp should not be missing
    Given SmartForms open page

    When I link wearable to rank C/O to zone
    When I clear gas reader entries

    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"

    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |
    And GasReadings fill equipment fields
    And GasReadings click add gas readings
    Then PinEntry enter pin for rank "C/O"
    And GasReadings add normal gas readings
    And GasReadings add toxic gas readings
    And GasReadings click Review & Sign button
    And SignatureLocation sign off first zone area

    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And CreateEntryPermit save current start and end validity time for "CRE"
    When I press the "Approve for Activation" button
    And I sign with valid C/O rank
    And I should see the page 'Permit Successfully Scheduled for Activation'
    Then I press the "Back to Home" button
    And CommonSection sleep for "1" sec
    And I activate CRE form via service
    And CommonSection sleep for "1" sec
    When I navigate to "Active" screen for CRE
    When I view permit with C/O rank
    Then I check location in gas readings signature is present

