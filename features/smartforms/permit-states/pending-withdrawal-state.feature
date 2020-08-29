@pending-withdrawal
Feature: PendingWithdrawal
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify Status Update display as completed when user submit as continue
    Given I submit permit <permit_payload> via service with 9015 user and set to active state with EIC not require
    And I launch sol-x portal without unlinking wearable
    And I terminate the permit via service with Completed status
    And I click on pending withdrawal filter
    Then I should <status> as task status

    Examples:
      | permit_types          | permit_payload             | status   |
      # | Cold Work - Cleaning Up of Spill | submit_cold_work_clean_spill | Completed |
      | Enclosed Spaces Entry | submit_enclose_space_entry | Continue |
# | Hot Work                           | submit_Hot Work               | Suspended |
