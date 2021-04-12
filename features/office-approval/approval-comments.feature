@approval-comments
Feature: OfficeApprovalComments
  As a ...
  I want to ...
  So that ...

  Scenario: Verify an Office Approval Authority can see the Comments block on the View Permit page - UI (5308)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    Then I should see comment reset
    And I should see Comments block attributes

  Scenario: Verify the Designation list contains all necessary roles (5310)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I click on Designation drop-down
    Then I should see the Designation list contains all necessary roles

  Scenario: Verify the selected role appears in the Designation field (5311)
    Given I submit permit ssubmit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I click on Designation drop-down
    And I select any role
    Then I should see the selected role in the Designation field

  Scenario: Verify the "Send" button becomes active only after all required fields are filled in (5312)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
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
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    Then I should see comment attributes

  Scenario: Verify the last added comment appears at the top of the list (5314)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I add comment on oa permit
    And close the comment block
    And I click on Add/Show Comments button
    And I add a short comment
    Then I should see the last comment is at the top of the list

  Scenario: Verify the "See More" button appears at the end of the comment if it is longer than 240 characters (5325)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I add a long comment
    Then I should see the See More button for a long comment
    And I should see only 240 chars are displayed

  Scenario: Verify the full comment appears after pressing the "See More" button (5326)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I add a long comment
    And I click on See More button
    Then I should see the full comment text

  Scenario: Verify that comments will be saved after the form is sent for updates before approval (5457)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And I request the permit for update via oa link manually
    And I submit permit via service to to pending office approval state
    And I navigate to OA link
    And I click on Add/Show Comments button
    Then I should see the last comment is at the top of the list
  @ska
  Scenario: Verify no one cannot add comments to the form after approval (5327)
    Given I submit permit submit_non_intrinsical_camera via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I add a short comment
    And I approve oa permit via oa link manually
    And I navigate to OA link
    And I click on Add/Show Comments button
    Then I should see the last comment is at the top of the list
    And I should see the correct notification at the bottom after approval
    And I should not see active fields and buttons


#Scenario: Verify Office Approval Authority cannot add comments to the form after activation (5328)
#Scenario: Verify that the comment added during the approval process is at the end of the final copy of PTW (5452)
#Scenario: Verify that a long comment (more than 240 characters) is displayed in full (5456)
#Scenario: Verify that comments are displayed in chronological order after the form termination (5454)
#Scenario: Verify the Comments section at the end of the final copy of PTW - UI (5453)
#Scenario: Verify Office Approval Authority cannot add comments to the form after termination (5329)
