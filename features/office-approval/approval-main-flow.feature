@approval-main-flow
Feature: OfficeApprovalMainFlow
  As a ...
  I want to ...
  So that ...

  Scenario: Verify a View Permit Page - UI (5289, 5290)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    When I wait for OA event
    And I navigate to OA link
    Then I should see the View Permit Page with all attributes before approval

  Scenario: Verify an Office Approval Authority can proceed to the Web Confirmation page from the View Permit page (5291)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    When I wait for OA event
    And I navigate to OA link
    And I click on "Approve This Permit”
    Then I should see the Web Confirmation page with all attributes

  Scenario: Verify the validity time cannot be more than 8 hours (3601, 6506)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I select Issued From time as 00:01
    And I select Issued To time as 01:00
    Then I should see the correct warning message for less

  Scenario: Verify the validity time cannot be less than 1 hour (3601, 6505)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on "Approve This Permit”
    And I select Issued From time as 00:01
    And I select Issued To time as 08:02
    Then I should see the correct warning message for more

  Scenario: Verify the Officer's name is pre-filled in web confirmation page (3647)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on "Approve This Permit”
    Then I should see the officer name is pre-filled

  #Scenario: Verify the expiry time of the form, specified in the office when approving the form, is set as the scheduled expiry time of the form after its activation (5341)
  #  Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
  #  When I wait for OA event
  #  And I navigate to OA link
  #  And I click on "Approve this Permit"
  #  And I set up the “Issued From” date/time as the <current_utc+0_time>
  #  And I set up the "To” date/time as the [<current_utc+0_time>+<expiration_time>-1 hour]
  #  And I approve the permit from Office Approval
  #  And I activate the permit as a Master
  #  And I navigate to active filter screen
  #  And I open the form as RA
  #  And I proceed to the Section 7B screen

  Scenario: Verify an Office Approval Authority can see the Warning screen after the form goes to the Approval Updates Needed state (after Pending Office Approval state) (5330)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    When I wait for OA event
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I navigate to OA link
    Then I should see the Warning Screen

  Scenario: Verify an Office Approval Authority can see the Warning screen when the form is in the Pending Master Review state (after Pending Office Approval state) (5333)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    When I wait for OA event
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on sit
    And I submit permit via service to pending master review state
    And I wait for form status get changed to PENDING_MASTER_REVIEW on Cloud
    And I navigate to OA link
    Then I should see the Warning Screen

  Scenario: Verify Captain can review a form after approval (5300)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    When I wait for OA event
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I navigate to OA link as Master
    Then I should see the View Permit Page with all attributes after approval

  Scenario: Verify an Office Approval Authority can review a form after activation (5301)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I get PTW permit info
    When I wait for OA event
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I wait for form status get changed to ACTIVE on Cloud
    And I navigate to OA link
    Then I should see the View Permit Page with all attributes after activation

  Scenario: PTW - Section 7 - Verify the section UI when the form is in the Pending_Office_Approval state (3398, 5781)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    Then I should see correct Section 7 details before Office Approval

  Scenario: PTW - Section 7 - Verify the section UI when the form is in the Pending_Master_Approval state (3378)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I sleep for 5 seconds
    And I navigate to section 7
    Then I should see correct Section 7 details after Office Approval
