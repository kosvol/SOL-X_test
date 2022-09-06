@op_permit_overview_page_cot
  # Should be performed with the COT vessel
Feature: Office Portal Permit Overview (COT vessel)
  To check content for a COT vessel

  @close_browser
  Scenario Outline: (LNG/COT) Verify the EIC and 8 shows the same fields as in the Client app with EIC
    Given PermitGenerator create permit
      | permit_type               | permit_status | eic   | gas_reading   |
      | hot_work_designated       | withdrawn     | yes   | no            |
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
      | Energy Isolation Certificate |
      | Section 8                    |

  @close_browser
  Scenario: (COT) Verify PRE form shows the same fields as in the client app
    Given EntryGenerator create entry permit
      | entry_type | permit_status |
      | pre        | TERMINATED    |
    When CouchDBService wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview verify "PRE"

  # Scenario: (COT) Verify PRE shows the value "Test Automation" by title "Reason for Entry"