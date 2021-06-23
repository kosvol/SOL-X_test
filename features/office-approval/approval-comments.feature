@approval-comments
Feature: OfficeApprovalComments
  As a ...
  I want to ...
  So that ...

  Scenario: Verify an Office Approval Authority can see the Comments block on the View Permit page - UI (5308)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    Then I should see Comments block attributes

  Scenario: Verify the Designation list contains all necessary roles (5310)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I click on Designation drop-down
    Then I should see the Designation list contains all necessary roles

  Scenario: Verify the selected role appears in the Designation field (5311)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I click on Designation drop-down
    And I select any role
    Then I should see the selected role in the Designation field

  Scenario: Verify the "Send" button becomes active only after all required fields are filled in (5312)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    Then I should see the Send button is disabled
    And I key a comment
    Then I should see the Send button is disabled
    And close the comment block
    And I click on Add Comments button
    And I key a name
    Then I should see the Send button is disabled
    And I key a comment
    Then I should see the Send button is enabled

  Scenario: Verify the comment's attributes after adding (5313)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    Then I should see comment attributes before termination

  Scenario: Verify the last added comment appears at the top of the list (5314)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a long comment
    And close the comment block
    And I click on Add/Show Comments button
    And I add a short comment
    Then I should see the last comment is at the top of the list

  Scenario: Verify the "See More" button appears at the end of the comment if it is longer than 240 characters (5325)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a long comment
    Then I should see the See More button for a long comment
    And I should see only 240 chars are displayed

  Scenario: Verify the full comment appears after pressing the "See More" button (5326)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a long comment
    And I click on See More button
    Then I should see the full comment text before termination

  Scenario: Verify that comments will be saved after the form is sent for updates before approval (5457)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And close the comment block
    And I request the permit for update via oa link manually
    And I wait for form status get changed to APPROVAL_UPDATES_NEEDED on sit
    And I submit permit via service to pending office approval state
    And I wait for form status get changed to PENDING_OFFICE_APPROVAL on Cloud
    And I navigate to OA link
    And I click on Add/Show Comments button
    Then I should see the last comment is at the top of the list

  Scenario: Verify no one cannot add comments to the form after approval (5327)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And close the comment block
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I navigate to OA link
    And I click on Add/Show Comments button
    Then I should see the last comment is at the top of the list
    And I should see the correct notification at the bottom after approval
    And I should not see active fields and buttons

  Scenario: Verify Office Approval Authority cannot add comments to the form after activation (5328)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And close the comment block
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I wait for form status get changed to ACTIVE on Cloud
    And I navigate to OA link
    And I click on Add/Show Comments button
    Then I should see the last comment is at the top of the list
    And I should see the correct notification at the bottom after activation
    And I should not see active fields and buttons

  Scenario: Verify Office Approval Authority cannot add comments to the form after termination (5329)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And close the comment block
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I submit permit via service to closed state
    And I wait for form status get changed to CLOSED on Cloud
    And I navigate to OA link
    Then I should not see the Add/Show Comments button
    And I should see the Print Permit button at the bottom bar

  Scenario: Verify the "Approved date" is displayed at the bottom of the OA PTW form (5460, 5455)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I submit permit via service to closed state
    And I wait for form status get changed to CLOSED on Cloud
    And I navigate to OA link
    Then I should see This Permit Has been approved on label with the correct date

  Scenario: Verify that the comment added during the approval process is at the end of the final copy of PTW (5452, 5453)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And close the comment block
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I submit permit via service to closed state
    And I wait for form status get changed to CLOSED on Cloud
    And I navigate to OA link
    And I sleep for 5 seconds
    Then I should see the Approval comments block at the bottom of the form
    And I should see comment attributes after termination

  Scenario: Verify that a long comment (more than 240 characters) is displayed in full (5456)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a long comment
    And close the comment block
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I submit permit via service to closed state
    And I wait for form status get changed to CLOSED on Cloud
    And I navigate to OA link
    Then I should see the full comment text after termination

  Scenario: Verify that comments are displayed in chronological order after the form termination (5454, 5453)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    When I wait for OA event
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And close the comment block
    And I sleep for 60 seconds
    And I click on Add/Show Comments button
    And I add a long comment
    And close the comment block
    And I sleep for 60 seconds
    And I click on Add/Show Comments button
    And I add a short comment
    And I take note of comments counter
    And close the comment block
    And I approve oa permit via oa link manually
    And I wait for form status get changed to PENDING_MASTER_APPROVAL on sit
    And I submit permit via service to closed state
    And I wait for form status get changed to CLOSED on Cloud
    And I navigate to OA link
    Then I should see comments are displayed in chronological order
    And I should see the comments counter shows the same number
