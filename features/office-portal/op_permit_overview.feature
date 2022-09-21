@op_permit_overview_page
  # Probably require a separate Jenkins job
  # Should be performed with the FSU vessel
Feature: Office Portal Permit Overview

  @close_browser
  Scenario Outline: Verify the PTW Sections shows the same fields as in the Client app (non-maintenance, non-condition)
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic | gas_reading |
      | hot_work_designated | withdrawn     | yes | no          |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify section
    | section   | permit_type         | eic | gas |
    | <section> | hot_work_designated | yes | no  |
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

  @close_browser
  Scenario: Verify Section 1 for Maintenance type shows the same fields as in the Client app
    Given PermitGenerator create permit
      | permit_type | permit_status | eic | gas_reading |
      | main_anchor | withdrawn     | no  | no          |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify section
      | section   | permit_type | eic | gas |
      | Section 1 | main_anchor | no  | no  |

  @close_browser
  Scenario Outline: Verify the PTW Sections 4B, 6 and 8 shows the same fields as in the Client app with conditions (non-maintenance, with conditions)
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic   | gas_reading   |
      | hot_work_designated | withdrawn     | <eic> | <gas_reading> |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify section
      | section   | permit_type         | eic   | gas           |
      | <section> | hot_work_designated | <eic> | <gas_reading> |
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
      | permit_type         | permit_status | eic   | gas_reading   |
      | <permit_type>       | withdrawn     | no    | no            |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify the checklist "<checklist>"
    Examples:
    | permit_type                  | checklist                                 |
    | cold_work_cleaning_spill     | Cold Work Operation                       |
    | main_anchor                  | Critical Equipment Maintenance            |
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
    | ele_equip_circuit            | Work on Electrical Equipment and Circuits |
    | cold_work_in_hazardous       | Work on Hazardous Substances              |
    | pressure_pipe_vessel         | Work on Pressure Pipelines                |
    | working_aloft                | Working Aloft Overside                    |

  @close_browser
  Scenario Outline: Verify Section 8 shows the same fields as in the client app with different checklists
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic   | gas_reading   |
      | <permit_type>       | withdrawn     | no    | no            |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify section
      | section   | permit_type   | eic | gas |
      | Section 8 | <permit_type> | no  | no  |
    Examples:
      | permit_type          |
      | main_anchor          |
      | ele_equip_circuit    |
      | pressure_pipe_vessel |

  @close_browser
    @ska
  Scenario Outline: Verify ROL form shows the same fields as in the client app
    Given PermitGenerator create permit
      | permit_type           | permit_status  |
      | rigging_of_ladder     | withdrawn      |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify RoL "<section>"
      | section   |
      | section 1 |
      | section 2 |
      | section 3 |

  @close_browser
  Scenario: Verify CRE form shows the same fields as in the client app
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | cre        | TERMINATED    |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify "CRE"

  # Scenario: An Entrant's rank, name, second name should be displayed in the ESE logs table [Office portal]