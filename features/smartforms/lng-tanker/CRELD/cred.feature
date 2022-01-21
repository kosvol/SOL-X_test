@lng-cred
Feature: Compressor room entry display
  As a ...
  I want to ...
  So that ...

  Scenario: CRED should not displayed permit terminated when new CRE permit is created
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
    And CreateEntryPermit click Submit for Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CreateEntryPermit verify page with text "Successfully Submitted"
    And CreateEntryPermit save permit id
    And CreateEntryPermit click Back to Home button
    And NavigationDrawer navigate to Compressor Motor Room "Pending Approval"
    When CreateEntryPermit click Officer Approval button
    Then PinEntry enter pin for rank "C/O"
    When SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CreateEntryPermit verify page with text "Permit Successfully Scheduled for Activation"
    And NavigationDrawer navigate to "CRE" display
    Then PinEntry enter pin for rank "C/O"

    And I should see Permit Activated PRE status on screen
    And I should see green background color
    When I submit a current CRE permit via service
    And I sleep for 30 seconds
    And I should see green background color
    And I terminate the PRE permit via service

  Scenario: [CRED] Just exited entrant can create new entry again api
    Given SmartForms open page
    When EntryGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And I add new entry "A 2/O,3/O,A 3/O" CRE
    And I sleep for 20 seconds
    And I acknowledge the new entry log cre via service
    When SmartForms open page
    And I navigate to CRE Display
    And I enter pin via service for rank C/O
    And I should see Permit Activated PRE status on screen
    When I signout entrants "A 2/O"
    And I sleep for 15 seconds
    And I add new entry "A 2/O" CRE
    And I sleep for 20 seconds
    And I acknowledge the new entry log cre via service
    Then I should see entrant count equal 3
    And I terminate the PRE permit via service

  Scenario: CRED Just exited entrant can create new entry again
    Given SmartForms open page
    When EntryGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And I open the current CRE with status Active. Rank: A C/O
    And Get CRE id
    And I click on back arrow
    And I sleep for 5 seconds
    And I navigate to CRE Display
    And I enter pin via service for rank C/O
    And I should see Permit Activated PRE status on screen
    And I enter new entry log
    And I fill entry report with 5 optional entrants
    And I send Report
    And I sleep for 20 seconds
    And I acknowledge the new entry log via service
    And I sleep for 3 seconds
    And I click on back arrow
    And I signout the entrant
    Then I should see entrant count equal 5
    And I sleep for 5 seconds
    And I enter new entry log
    And I fill entry report with 1 optional entrants
    And I send Report
    And I sleep for 20 seconds
    And I acknowledge the new entry log via service
    And I click on back arrow
    Then I should see entrant count equal 7
    And I terminate the PRE permit via service

  Scenario: Verify user can't add new entry without an initial gas readings
    Given SmartForms open page
    When SmartForms click create "CRE"
    Then PinEntry enter pin for rank "C/O"
    And CRE fill up permit
      | duration | delay to activate |
      | 4        | 3                 |

    And Get CRE id
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I activate the current CRE form
    And I activate CRE form via service
    And I navigate to CRE Display
    And I enter pin via service for rank C/O
    And I should see Permit Activated PRE status on screen
    And I click on permit tab
    Then I check initial gas readings is not exist
    When I click on back arrow
    And I enter new entry log
    And I fill entry report with 1 optional entrants
    And I just send Report
    And I check report not send
    And I terminate the PRE permit via service

  Scenario: Displaying CRED without an active CRE[SOL-6222]
    Given SmartForms open page
    And I navigate to CRE Display
    And I enter pin via service for rank C/O
    And I should see red background color
    Then I should see Permit Terminated PRE status on screen
    And (for pred) I should see the enabled "Home" button
    And (for pred) I should see the disabled "Entry Log" button
    And (for pred) I should see the disabled "Permit" button

  Scenario: [CRED] Users can exit from an active CRE[SOL-6243]
    When EntryGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And I add new entry "A 2/O,3/O,A 3/O" CRE
    And I sleep for 20 seconds
    And I acknowledge the new entry log cre via service
    When SmartForms open page
    And I navigate to CRE Display
    And I enter pin via service for rank C/O
    And I should see Permit Activated PRE status on screen
    When I signout "A 2/O" entrants by rank
    Then I check that entrants "A 2/O" not present in list