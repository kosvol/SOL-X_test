@PREL
Feature: Pump room entry log
  As a ...
  I want to ...
  So that ...

  Scenario: Verify PRE permit is terminated after terminating via dashboard popup
    Given  I submit a scheduled PRE permit
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    When I launch sol-x portal dashboard
    And CommonSection sleep for "5" sec
    And I open new dashboard page
    And CommonSection sleep for "5" sec
    And I switch to first tab in browser

    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    And I enter new entry log
    And I send entry report with 3 optional entrants
    And I switch to last tab in browser
    Then I should see alert message
    And I click terminate new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see red background color
    And I should see Permit Terminated PRE status on screen

  Scenario: PRE Dashboard Gas reading pop up should have a independent close option
    Given PermitGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    When I launch sol-x portal dashboard
    And I open new dashboard page
    And I switch to first tab in browser

    Then SmartForms open hamburger menu
    When NavigationDrawer navigate to settings
    And Setting select mode for "PRE"
    And PinEntry enter pin for rank "C/O"
    And EntryDisplay wait for permit
      | type   | background|
      | active |  green    |

    And I enter new entry log
    And I send entry report with 0 optional entrants
    And I acknowledge the new entry log pre via service
    And CommonSection sleep for "5" sec
    And I dismiss gas reader dialog box
    And I click on back arrow
    And I enter random entry log with role 2/O
    And I send entry report with 1 optional entrants
    And CommonSection sleep for "5" sec
    And I switch to last tab in browser
    Then I should see alert message
    And I click close new gas readings on dashboard page
    And I enter pin for rank A C/O
    And I switch to first tab in browser
    Then I should see alert message

  Scenario: Dashboard - Verify updated view and icon is displayed in Dashboard main page for entry log and PRE status
    Given I get active PRE permit and terminate
    And I launch sol-x portal
    When I check PRE elements on dashboard inactive
    When PermitGenerator create entry permit
      | entry_type | permit_status |
      | pre        | ACTIVE        |
    And I add new entry "A 2/O" PRE
    And CommonSection sleep for "5" sec
    And I acknowledge the new entry log pre via service
    And CommonSection sleep for "5" sec
    When I check PRE elements on dashboard active
