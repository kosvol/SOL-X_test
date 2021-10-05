@approval-main-flow
Feature: OfficeApprovalMainFlow
  As a ...
  I want to ...
  So that ...

  Scenario: Verify a View Permit Page - UI (5289, 5290)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    Then I should see the View Permit Page with all attributes before approval

  Scenario: Verify an Office Approval Authority can proceed to the Web Confirmation page from the View Permit page (5291)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I click on "Approve This Permit”
    Then I should see the Web Confirmation page with all attributes

  Scenario: Verify the validity time cannot be less than 1 hour (3601, 6505)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I select Issued From time as 00:01
    And I select Issued To time as 01:00
    Then I should see the correct warning message for less

  Scenario: Verify the validity time cannot be more than 8 hours (3601, 6506)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I select Issued From time as 00:01
    And I select Issued To time as 08:02
    Then I should see the correct warning message for more

  Scenario: Verify the Officer's name is pre-filled in web confirmation page (3647)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on "Approve This Permit”
    Then I should see the officer name is pre-filled

  Scenario: Verify an Office Approval Authority can see the Successfully Submission page after pressing the "Approve This Permit" button
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I answer all questions on the page
    And I leave additional instructions
    And I select Issued From time as 00:00
    And I select Issued To time as 08:00
    And I select the approver designation
    And I click on "Approve This Permit”
    Then I should see the Successfully Submission page after approval

  Scenario: Verify an Office Approval Authority can see the Warning page after approving the already approved PTW
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I open a new tab and switch to it
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I answer all questions on the page
    And I leave additional instructions
    And I select Issued From time as 00:00
    And I select Issued To time as 08:00
    And I select the approver designation
    And I click on "Approve This Permit”
    Then I should see the Successfully Submission page after approval
    And I close the tab and navigate back
    And I click on "Approve This Permit”
    Then I should see the Successfully Submission page after double approval

  Scenario: Verify an Office Approval Authority can see the Warning screen after the form goes to the Approval Updates Needed state (after Pending Office Approval state) (5330)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I navigate to OA link
    Then I should see the Warning Screen

  Scenario: Verify an Office Approval Authority can see the Warning screen when the form is in the Pending Master Review state (after Pending Office Approval state) (5333)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on sit
    And I submit permit via service to pending master review state
    And I wait for form status get changed to PENDING_MASTER_REVIEW on Cloud
    And I navigate to OA link
    Then I should see the Warning Screen

  Scenario: Verify Captain can review a form after approval (5300)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I navigate to OA link as Master
    Then I should see the View Permit Page with all attributes after approval

  Scenario: Verify an Office Approval Authority can review a form after activation (5301)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I wait for form status get changed to ACTIVE on Cloud
    And I navigate to OA link
    Then I should see the View Permit Page with all attributes after activation

  Scenario: Verify an Office Approval Authority can review a form after termination of permit by Master (5302)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I submit permit via service to closed state
    And I wait for form status get changed to CLOSED on Cloud
    And I navigate to OA link
    Then I should see the View Permit Page with all attributes after termination

  Scenario: Verify Section 7 details are displayed in the final copy of PTW after termination (3609)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I answer all questions on the page
    And I leave additional instructions
    And I select Issued From time as 00:00
    And I select Issued To time as 08:00
    And I select the approver designation
    And I click on "Approve This Permit”
    And I launch sol-x portal without unlinking wearable
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I submit permit via service to closed state
    And I wait for form status get changed to CLOSED on Cloud
    And I navigate to OA link
    Then I should see the Section 7 shows the correct data

  Scenario: PTW - Section 7 - Verify the section UI when the form is in the Pending_Office_Approval state (3398, 5781)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    Then I should see correct Section 7 details before Office Approval

  Scenario: Verify the expiry time of the form, specified in the office when approving the form, is set as the scheduled expiry time of the form after its activation (5341)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I answer all questions on the page
    And I leave additional instructions
    And I select Issued From time as current_hour:00
    And I select Issued To time as plus_two_hours:00
    And I select the approver designation
    And I click on "Approve This Permit”
    And I launch sol-x portal without unlinking wearable
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    And I view permit with C/O rank
    And I sleep for 5 seconds
    And I press previous for 1 times
    Then I should see the Issued till time is set according to OA issued To time

  Scenario: PTW - Section 7 - Verify the section UI when the form is in the Pending_Master_Approval state (3378)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I answer all questions on the page
    And I leave additional instructions
    And I select Issued From time as 00:00
    And I select Issued To time as 08:00
    And I select the approver designation
    And I click on "Approve This Permit”
    And I launch sol-x portal without unlinking wearable
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I click on pending approval filter
    And I open a permit pending Master Approval with MAS rank
    And I navigate to section 7
    Then I should see correct Section 7 details after Office Approval
