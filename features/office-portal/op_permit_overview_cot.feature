@op_permit_overview_page_cot
  # Should be performed with the COT vessel
Feature: Office Portal Permit Overview (COT vessel)
  To check content for a COT vessel

  @close_browser
  Scenario Outline: (LNG/COT) Verify the EIC and 8 shows the same fields as in the Client app with EIC
    Given PermitGenerator create permit
      | permit_type               | permit_status | eic   | gas_reading   |
      | hot_work_designated       | withdrawn     | yes   | no            |
    When CouchDBAPI wait for form status get changed to "CLOSED" on "cloud"
    And OfficeLogin open page
    And OfficeLogin enter email "qa-test-group@sol-x.co"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button
    Then PermitArchive page should be displayed
    When PermitOverview follow the permit link
    Then PermitOverview should see the "<section>" shows the same fields as in the Client app

    Examples:
      | section                      |
      | Energy Isolation Certificate |
      | Section 8                    |

  # Scenario: (COT) Verify PRE form shows the same fields as in the client app

  # Scenario: (COT) Verify PRE shows the value "Test Automation" by title "Reason for Entry"