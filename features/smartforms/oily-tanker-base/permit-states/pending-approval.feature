@pending-approval
Feature: PendingApprovalPermit
  As a ...
  I want to ...
  So that ...

  # @skip
  # Scenario: Verify view EIC certification exists if EIC certification form not filled
  #   Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
  #   And I launch sol-x portal without unlinking wearable
  #   And I click on pending approval filter
  #   And I click on permit for master approval
  #   And I enter pin for rank MAS
  #   And I navigate to section 4b
  #   Then I should see View EIC certification button

  @SOL-7290
  Scenario: Section 4B sign button to be disabled while on Pending Approval state
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank C/O
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
    And I fill a full enclosed workspace permit
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin for rank 4/E
    And I navigate to section 4b
    Then I should see sign button disabled

  Scenario: Verify submission text is correct after submitting to Office
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank C/O
    And I select Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces permit
    And I select NA permit for level 2
    And I fill a full OA permit
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin for rank MAS
    And I navigate to section 6
    Then I should see correct OA submission text

  Scenario: Verify RA should not be able to edit EIC when pending master review
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank C/O
    And I select Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces permit
    And I select NA permit for level 2
    And I fill a full OA permit
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin for rank A/M
    And I navigate to section 3a
    Then I should not be able to edit Use of non-intrinsically safe Camera DRA
    When I press next for 6 times
    Then I should not be able to edit EIC certification

  Scenario Outline: Verify RA and checklist only creator should not be able to edit DRA and EIC when pending master approval
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank <creator_rank>
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
    And I fill a full enclosed workspace permit
    And I click on pending approval filter
    And I click on permit for master approval
    And I enter pin for rank <rank>
    And I navigate to section 3a
    Then I should not be able to edit Enclosed Spaces Entry DRA
    When I press next for 6 times
    Then I should not be able to edit EIC certification

    Examples:
      | rank | creator_rank |
      | ETO  | ETO          |
      | 3/E  | C/O          |
      | PMAN | A C/O        |
      | MAS  | 2/E          |

  Scenario: Verify user is brough back to listing screen after cancelling from pinpad
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I click on permit for master approval
    And I dismiss enter pin screen
    Then I should be navigated back to pending approval screen

  Scenario: Verify SOL-5474 - Fix Blank Screen when user accesses OA permits from Pending Approval state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank 2/E
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    And I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    Then I should be able to open permit as master without seeing blank screen

  Scenario: Verify submitted time displayed
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin for rank C/O
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration less than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    Then I should see the newly pending approval permit details listed on Pending Approval filter

  Scenario: Verify user should see Master Approval button
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    Then I should see Master Approval button

  Scenario: Verify user should see Master Review button
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    Then I should see Master Review button

  Scenario: Verify user should see Office Approval button
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    Then I should see Office Approval button

  Scenario: Master can ask for update on all permit with duration more than 2 hours
    Given I launch sol-x portal without unlinking wearable
    When I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 2
    Then I should see correct approval details for maintenance duration more than 2 hours
    When I press next for 4 times
    And I sign DRA section 3d with A/M as valid rank
    When I press next for 1 times
    Then I should see correct checklist Critical Equipment Maintenance Checklist pre-selected
    When I press next for 1 times
    And I sign checklist with A/M as valid rank
    And I press next for 2 times
    And I select 1 role from list
    And I sign on role
    And I press next for 1 times
    And I submit permit for Master Review
    And I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on auto
    And I click on pending approval filter
    Then I should see Master Approval button
    When I click on permit for master approval
    And I enter pin for rank MAS
    And I navigate to section 7
    Then I should see Activate Permit to Work button enabled

  Scenario Outline: Verify these rank can sign off DRA on section 3D
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank
    And I navigate to section 3d
    And I sign DRA section 3d with <rank> as valid rank
    Then I should see signed details

    Examples:
      | rank | pin  |
      | MAS  | 1111 |
  # | A/M   | 9015 |
  # | C/O   | 8383 |
  # | A C/O | 2761 |
  # | 2/O   | 6268 |
  # | A 2/O | 7865 |
  # | 3/O   | 0159 |
  # | A 3/O | 2674 |
  # | C/E   | 8248 |
  # | A C/E | 5718 |
  # | 2/E   | 2523 |
  # | A 2/E | 3030 |
  # | 3/E   | 4685 |
  # | A 3/E | 6727 |
  # | 4/E   | 1311 |
  # | A 4/E | 0703 |
  # | CGENG | 0703 |

  Scenario Outline: Verify these rank canotn sign off DRA on section 3D when in Pending Master Approval state
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select NA permit for level 2
    And I fill only location of work
    And I press next for 7 times
    And I sign checklist and section 5
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with <rank> rank
    And I navigate to section 3d
    Then I should see sign button disabled

    Examples:
      | rank  | pin  |
      | A 4/E | 0703 |
      | CGENG | 0703 |


