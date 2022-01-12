@op_permit_overview_page
Feature: Office Portal Permit Overview
@ska
  Scenario Outline: Verify the PTW Sections shows the same fields as in the Client app (non-maintenance, non-condition)
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | hot_work_designated | withdrawn     | yes  | no          | 0         | 0         |
    When CouchDBAPI wait for form status get changed to "CLOSED" on "cloud"
    And PermitOverview follow the permit link
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitOverview should see the final copy
    And PermitOverview should see the "<section>" shows the same fields as in the Client app

    Examples:
      | section                      |
      | Section 1                    |
      | Section 2                    |
      | Section 3A                   |
      | Section 3B                   |
      | Section 3C                   |
      | Section 3D                   |
      | Section 4A                   |
      | Energy Isolation Certificate |
      | Section 5                    |
      | Section 7                    |
      | Section 7B                   |
      | Section 9                    |

    Scenario Outline: Verify the PTW Sections shows the same fields as in the Client app (non-maintenance, with conditions)
      Given PermitGenerator create permit
        | permit_type         | permit_status | eic   | gas_reading   | bfr_photo | aft_photo |
        | hot_work_designated | withdrawn     | <eic> | <gas_reading> | 0         | 0         |
      When CouchDBAPI wait for form status get changed to "CLOSED" on "cloud"
      And PermitOverview follow the permit link
      And OfficeLogin enter email "qa-test-group@sol-x.co"
      And OfficeLogin enter password "Solxtester12345!"
      And OfficeLogin click the Sign in button
      Then PermitOverview should see the final copy
      And PermitOverview should see the "<section>" shows the same fields as in the Client app

      Examples:
        | section    | eic | gas_reading |
        | Section 4B | yes | yes         |
        | Section 6  | yes | yes         |
        | Section 8  | yes | yes         |
        | Section 4B | no  | no          |
        | Section 6  | no  | no          |
        | Section 8  | no  | no          |