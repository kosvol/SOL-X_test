Feature: Pump Room Entry
  As a ...
  I want to ...
  So that ...

  Background: Given I navigate to sol-x portal

  Scenario: Verify user roles for PRE creation

  Examples:
  | rank  |
  | C/O   |
  | A C/O |
  | 2/O   |
  | A 2/O |
  | 3/O   |
  | A 3/O |
  
  Scenario: Verify user able to select date from calendar

  Scenario: Verify user able to select time from wheel picker

  Scenario: Verify user able to see gas reading fields and toxic gas fields

  Scenario: Verify user able to add digital signature to as gas reading approval

  Scenario: Verify user able to see reporting interval when YES is selected

  Scenario: Verify submit for approval button is disable when mandatory fields not fill

  Scenario: Verify user able to submit PRE for Chief Officer approval

  Scenario: Verify Save and Close button is disable if Updated Needed is require

  Scenario: Verify Updates Needed count is update on dashboard if PRE requires update

  Scenario: Verify Updated Needed count reflected on dashboard
      When I finish filling up PRE from
      And I submit for approval
      When I set the created PRE permit to Update Needed
      Then I should see total "Update Needed" count reflected on dashboard

  Scenario: Verify only Chief Officer able to approve PRE and should becomes active and count reflected on active permit

  Scenario: Verify PRE expires after 8 hours for on sea
      When active PRE permit expire after 8 hours
      Then I should see 0 active PRE permit

  Scenario: Verify PRE expires after 4 hours for on sea
    When active PRE permit expire after 4 hours
      Then I should see 0 active PRE permit

  Scenario: Verify breach alert show when detected human in pump room with no active PRE permit