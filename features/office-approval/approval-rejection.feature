@approval-rejection
Feature: OfficeApprovalRejection
  As a ...
  I want to ...
  So that ...

  #Scenario: Verify an Office Approval Authority can proceed to the Web Comment page from the View Permit page (5443)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"

  #Scenario: Verify that non Checklist Creator users cannot edit any section of a form from 1 to 5 via "Approval Updates Needed" state (5739)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I create the EIC for this PTW
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>
  #  And I enter a <name>
  #  And I enter a <designation>
  #  And I click on "Request Updates"
  #  And I navigate to "Updates Needed" filter screen
  #  And I open the permit as a <non_checklist_creator>

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

  #Scenario: Verify the "Request Updates" button becomes active only after all required fields are filled in on the Web Comment Page (5548)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>
  #  And I enter a <name>
  #  And I enter a <designation>

  #Scenario: Verify an Office Approval Authority can select a designation on the Web Comment Page (5547)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I select a <designation> from the drop-down

  #Scenario: Verify an Office Approval Authority can enter a Name on the Web Comment Page (5546)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <name>

  #Scenario: Verify an Office Approval Authority can enter a comment on the Web Comment Page (5543)
  #  Given I launch SIT application
  #  And I create any new PTW under OA
  #  And I put PTW to Pending Office Approval state
  #  And I open an e-mail as Office Approval Authority
  #  And I click on "Review this Permit"
  #  And I click on "Request Updates"
  #  And I enter a <comment>

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

  #Scenario: Verify an Office Approval Authority can see the Successfully Submission page after pressing the "Request Updates" button (5444)
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