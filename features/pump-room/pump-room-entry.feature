Feature: Pump Room Entry
  As a ...
  I want to ...
  So that ...

  Background: Given I navigate to sol-x portal

  Scenario: Verify user roles for PRE creation
  
  Scenario: Verify user able to select date from calendar for Date of Last Calibration

  Scenario: Verify user able to add gas records

  Scenario: Verify user able to see reporting interval when YES is selected

  Scenario: Verify Enter Pin & Sign button is disable when mandatory fields not filled

  Mandatory fields
  Location at sea

  Scenario: Verify default start time is rounded down from current timestamp

  Scenario: Verify end time is dynamic base on selected start time

  Examples:
  | hours |
  | 4     |
  | 6     |
  | 8     |

  Scenario: Verify submit for approval button is disable when mandatory fields not fill

  Scenario: Verify user able to submit PRE for Chief Officer approval

  Scenario: Verify Save and Close button is disable if Updated Needed is require

  Scenario: Verify Updates Needed count is update on dashboard if PRE requires update

  Scenario: Verify only Chief Officer able to approve PRE and should becomes active and count reflected on active permit

  Scenario: Verify dashboard is showing count for active PRE
  
  Scenario: Verify dashboard is showing count for PRE under pending for approval

  Scenario: Verify user able to terminal PRE permit
  
  Scenario: Verify PRE PDF generated ?
  
  @unit-test-level
  Scenario: Verify PRE expires duration
      When active PRE permit expire after 8 hours
      Then I should see 0 active PRE permit

  Scenario: Verify breach alert show when detected human in pump room with no active PRE permit

# new ---->
  Scenario: Verify only one PRE permit can be created for one timing in the day
  
  Scenario: Verify PRE permit auto start

  Scenario: Verify PRE permit auto end