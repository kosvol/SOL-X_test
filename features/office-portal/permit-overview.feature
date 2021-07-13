@permit-overview
Feature: PermitOverview
  As a ...
  I want to ...
  So that ...

  Scenario: Verify PRE will be activated and auto terminated at the specified time [Office portal]
    Given I create PRE via service with static env
    And I get PRE permit info
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I sleep for 3 seconds
    And I select the recently terminated form
    And I click on View Permit button
    And I sleep for 5 seconds
    Then I check the element value "Test Automation" by title "Reason for Entry"

  Scenario: An Entrant's rank, name, second name should be displayed in the ESE logs table [Office portal]
    Given I create submit_enclose_space_entry via service with static env
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I click on Add Filter button
    And I select filter value with permit type "Enclosed Spaces Entry"
    And I sleep for 3 seconds
    And I check the checkbox near the first permit in the list
    And I click on View Permit button
    And I check that Entry log is present
    And I check all headers of Entry Log table without toxic gas on portal
    And I check rank and full name of Entrant without toxic "A 2/O"

  Scenario: Verify the ROL checklist questions are displayed the same as in the Client app
    Given I terminate permit submit_rigging_of_ladder via service with 9015 user on the auto vessel
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see ROL checklist questions

  Scenario Outline: Verify the different PTW checklist questions are displayed the same as in the Client app
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel with the <checklist> checklist
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see <checklist> checklist questions in Office Portal

    Examples:
      | checklist                                    |
      | Cold Work Operation                          |
      | Critical Equipment Maintenance               |
      | Enclosed Spaces Entry Checklist              |
      | Helicopter Operation                         |
      | Hot Work Outside Designated Area             |
      | Hot Work Within Designated Area              |
      | Personnel Transfer by Transfer Basket        |
      | Rotational Portable Power Tools (PPT)        |
      | Underwater Operation                         |
      | Use of Camera                                |
      | Use of ODME in Manual Mode                   |
      | Work on Deck During Heavy Weather            |
      | Work on Electrical Equipment and Circuits    |
      | Work on Hazardous Substances                 |
      | Work on Pressure Pipelines                   |
      | Working Aloft Overside                       |

  Scenario Outline: Verify the PTW Sections shows the same fields as in the Client app (non-maintenance)
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the <section> shows the same fields as in the Client app

    Examples:
      | section    |
      | Section 1  |
      | Section 2  |
      | Section 3A |
      | Section 3B |
      | Section 3C |
      | Section 3D |
      | Section 4A |
      | Section 5  |
      | Section 7  |
      | Section 7B |
      | Section 9  |

  Scenario: Verify Section 1 for Maintenance type shows the same fields as in the Client app
    Given I terminate permit submit_maintenance_on_anchor via service with 9015 user on the auto vessel
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the Section 1 shows the same fields as in the Client app

  Scenario Outline: Verify Section 6 with Gas Readings shows the same fields as in the Client app
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel with the Gas Readings <condition>
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then Then I should see the Section 6 with gas <condition> shows the same fields as in the Client app

    Examples:
      | condition |
      | gas_yes   |
      | gas_no    |

  Scenario: Verify the EIC section shows the same fields as in the Client app
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel with the EIC eic_yes
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the Energy Isolation Certificate shows the same fields as in the Client app

  Scenario Outline: Verify section 4B and 8 shows the same fields as in the Client app with or without the EIC
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel with the EIC <condition>
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see the <section> shows the same fields as in the Client app with <condition>

    Examples:
      | condition | section    |
      | eic_yes   | Section 4B |
      | eic_no    | Section 4B |
      | eic_yes   | Section 8  |
      | eic_no    | Section 8  |

  Scenario Outline: Verify Section 8 shows the sae fields as in the client app with different checklists
    Given I terminate permit submit_hotwork via service with 9015 user on the auto vessel with the <checklist> checklist
    When I wait for form status get changed to CLOSED on Cloud
    And I log in to the Office Portal
    And I select the "Auto" vessel
    And I select the recently terminated form
    And I click on View Permit button
    Then I should see Section 8 shows the same fields as in the Client app with <checklist>

    Examples:
      | checklist                                    |
      | Critical Equipment Maintenance               |
      | Work on Electrical Equipment and Circuits    |
      | Work on Pressure Pipelines                   |

    Scenario: Verify PRE form shows the same fields as in the client app
      Given I create PRE via service with static env
      And I get PRE permit info
      When I wait for form status get changed to CLOSED on Cloud
      And I log in to the Office Portal
      And I select the "Auto" vessel
      And I sleep for 3 seconds
      And I select the recently terminated form
      And I click on View Permit button
      And I sleep for 5 seconds
      Then I should see the PRE form shows the same fields as in the client app