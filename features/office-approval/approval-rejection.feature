@approval-rejection
Feature: OfficeApprovalRejection
  As a ...
  I want to ...
  So that ...

  Scenario: Verify an Office Approval Authority can proceed to the Web Comment page from the View Permit page (5443)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I click on "Request Updates"
    Then I should see the Web Rejection page with all attributes

  #Scenario Outline: Verify that non Checklist Creator users cannot edit any section of a form from 1 to 5 via "Approval Updates Needed" state (5739)
  #  Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
  #  And I get PTW permit info
  #  And I navigate to OA link
  #  And I request the permit for update via oa link manually
  #  And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on sit
  #  And I click on update needed filter
  #  And I update permit in pending update state with <pin> pin
  #  And I navigate to section 4a
  #  Then I should see checklist selections fields enabled
  #  And I press next for 1 times
  #  And I should see checklist questions fields enabled

  #  Examples:
  #    | rank  | pin  |
  #    | 3/E   | 4685 |
  #    | 4/E   | 1311 |
  #    | A 4/E | 0703 |

  #Scenario: Verify Checklist Creator can update Several sections of a form via "Approval Updates Needed" state (5738)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I create the EIC for this PTW
  #  And I fill in PTW completely
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>
  #  And I enter a <name>
  #  And I enter a <designation>
  #  And I click on "Request Updates"
  #  And I navigate to "Updates Needed" filter screen
  #  And I open the permit as <checklist_creator>

  #Scenario: Verify section 1-5 (including DRA and EIC) of a form are editable after opening it as RA via "Approval Updates Needed" state (5737)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>
  #  And I enter a <name>
  #  And I enter a <designation>
  #  And I click on "Request Updates"
  #  And I navigate to "Updates Needed" filter screen
  #  And I open the permit as <ra>

  #Scenario: Verify user should not see Approving Authority's note on all section while viewing as non Checklist Creator via "Approval Updates Needed" state (5736)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I create EIC for this PTW
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>
  #  And I enter a <name>
  #  And I enter a <designation>
  #  And I click on "Request Updates"
  #  And I navigate to "Updates Needed" filter screen
  #  And I open the permit as <non_checklist_creator>

  Scenario: Verify the "Request Updates" button becomes active only after all required fields are filled in on the Web Comment Page (5548, 5543, 5546, 5547)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I click on "Request Updates"
    And I remove name
    And I enter comment
    Then I should see the Request Updates button is disabled
    And I should see the comment entered
    And I enter name
    Then I should see the Request Updates button is disabled
    And I should see the name entered
    And I remove comment
    Then I should see the Request Updates button is disabled
    And I select the approver designation
    Then I should see the Request Updates button is disabled
    And I should see the designation entered
    And I remove name
    Then I should see the Request Updates button is disabled
    And I enter comment
    Then I should see the Request Updates button is disabled
    And I enter name
    Then I should see the Request Updates button is enabled

  Scenario: Verify an Office Approval Authority Name is pre-filled on the Web Comment Page (5546)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on "Request Updates"
    Then I should see the officer name is pre-filled

  #Scenario: Verify user should see Approving Authority's note on all section while viewing as Checklist Creator via "Approval Updates Needed" state (5446)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I create EIC for this PTW
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>
  #  And I enter a <name>
  #  And I enter a <designation>
  #  And I click on "Request Updates"
  #  And I navigate to "Updates Needed" filter screen
  #  And I open the permit as <checklist_creator>

  #Scenario: Verify that the form goes to the APPROVAL_UPDATES_NEEDED state after sending it for updates from the Office (5445)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>
  #  And I enter a <name>
  #  And I enter a <designation>
  #  And I click on "Request Updates"

  Scenario: Verify an Office Approval Authority can see the Successfully Submission page after pressing the "Request Updates" button (5444)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I click on "Request Updates"
    And I enter comment
    And I select the approver designation
    And I click on "Request Updates"
    Then I should see the Successfully Submission page after rejection
