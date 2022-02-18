@op_permit_overview_page
Feature: Office Portal Permit Overview

  Scenario Outline: Verify the PTW Sections shows the same fields as in the Client app (non-maintenance, non-condition)
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | hot_work_designated | withdrawn     | yes  | no          | 0         | 0         |
    When CouchDBAPI wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    And PermitOverview follow the permit link
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
      And OfficeLogin open page
      And OfficeLogin enter email "qa-test-group@sol-x.co"
      And OfficeLogin enter password "Solxtester12345!"
      And OfficeLogin click the Sign in button
      Then PermitArchive page should be displayed
      And PermitOverview follow the permit link
      Then PermitOverview should see the "<section>" shows the same fields as in the Client app

      Examples:
        | section    | eic | gas_reading |
        | Section 4B | yes | yes         |
        | Section 6  | no  | yes         |
        | Section 8  | yes | yes         |
        | Section 4B | no  | no          |
        | Section 6  | no  | no          |
        | Section 8  | no  | no          |
 @close_browser
  Scenario Outline: Verify the different PTW checklist questions are displayed the same as in the Client app
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic   | gas_reading   | bfr_photo | aft_photo |
      | <permit_type>       | withdrawn     | no    | no            | 0         | 0         |
    When CouchDBAPI wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    And PermitOverview follow the permit link
    Then PermitOverview should see the "<checklist>" checklist shows the same fields as in the Client app

    Examples:
    | permit_type                  | checklist                                 |
    | cold_work_cleaning_spill     | Cold Work Operation                       |
    | maintenance_on_anchor        | Critical Equipment Maintenance            |
    | enclosed_spaces_entry        | Enclosed Spaces Entry                     |
    | helicopter_operation         | Helicopter Operation                      |
    | hot_work_outside_designated  | Hot Work Outside Designated Area          |
    | hot_work_designated          | Hot Work Within Designated Area           |
    | personnel_transfer           | Personnel Transfer by Transfer Basket     |
    | portable_tools               | Rotational Portable Power Tools (PPT)     |
    | underwater_sim               | Underwater Operation                      |
    | use_safe_camera              | Use of Camera                             |
    | use_of_odme                  | Use of ODME in Manual Mode                |
    | work_on_deck                 | Work on Deck During Heavy Weather         |
    | work_on_electrical_equipment | Work on Electrical Equipment and Circuits |
    | cold_work_in_hazardous       | Work on Hazardous Substances              |
    | work_on_pipelines            | Work on Pressure Pipelines                |
    | working_aloft                | Working Aloft Overside                    |