@lng-cred
Feature: Compressor room entry display
  As a ...
  I want to ...
  So that ...

  Scenario: CRED should not displayed permit terminated when new CRE permit is created
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    Then SmartForms open hamburger menu
    And NavigationDrawer navigate to Compressor Motor Room "Active"
    And CreateEntryPermit save permit id from list
    Then CreateEntryPermit verify current permit presents in the list
    And NavigationDrawer click go back button
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |
    And EntryDisplay check background color is "green"
    And EntryDisplay check entry display without new entry
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | cre        | ACTIVE        |
    And EntryDisplay check background color is "red"
    And CommonSection sleep for "30" sec
    And EntryDisplay check background color is "green"

  Scenario: [CRED] Just exited entrant can create new entry again api
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks           |
      | cre        | A 2/O,3/O,A 3/O |
    And CommonSection sleep for "20" sec

    And I acknowledge the new entry log cre via service

    When SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    When I signout entrants "A 2/O"

    And CommonSection sleep for "10" sec
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks |
      | cre        | A 2/O |
    And CommonSection sleep for "10" sec
    And I acknowledge the new entry log cre via service
    Then I should see entrant count equal 3
    And I terminate the PRE permit via service

  Scenario: CRED Just exited entrant can create new entry again
    Given SmartForms open page
    When PermitGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And CommonSection sleep for "10" sec
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    And I enter new entry log
    And I fill entry report with 5 optional entrants
    And I send Report
    And CommonSection sleep for "10" sec
    And I acknowledge the new entry log via service
    And CommonSection sleep for "3" sec
    And I click on back arrow
    And I signout the entrant
    Then I should see entrant count equal 5
    And CommonSection sleep for "5" sec
    And I enter new entry log
    And I fill entry report with 1 optional entrants
    And I send Report
    And CommonSection sleep for "10" sec
    And I acknowledge the new entry log via service
    And I click on back arrow
    Then I should see entrant count equal 7
    And I terminate the PRE permit via service


  Scenario: Displaying CRED without an active CRE[SOL-6222]
    Given SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type     | background |
      | inactive | red        |
    And EntryDisplay check background color is "red"

    And (for pred) I should see the enabled "Home" button
    And (for pred) I should see the disabled "Entry Log" button
    And (for pred) I should see the disabled "Permit" button

  Scenario: [CRED] Users can exit from an active CRE[SOL-6243]
    When PermitGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | ACTIVE          |
    And AddNewEntryRecord create new entry record with additional entrants
      | entry_type | ranks           |
      | cre        | A 2/O,3/O,A 3/O |
    And CommonSection sleep for "20" sec

    And I acknowledge the new entry log cre via service

    When SmartForms open page
    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "CRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    When I signout "A 2/O" entrants by rank
    Then I check that entrants "A 2/O" not present in list