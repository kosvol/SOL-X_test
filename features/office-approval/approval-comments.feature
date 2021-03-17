@approval-comments
Feature: PermitList
  As a ...
  I want to ...
  So that ...

  Scenario: Verify an Office Approval Authority can see the Comments block on the View Permit page - UI (5308)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    Then I should see comment reset
    And I should see other Comments block attributes

  Scenario: Verify the Designation list contains all necessary roles (5310)
    Given I submit permit submit_underwater_simultaneous via service with 9015 user and set to pending office approval state
    And I navigate to OA link
    And I click on Add Comments button
    And I click on Designation drop-down
    Then I should the Designation list contains all necessary roles

  #Scenario: Verify the selected role appears in the Designation field (5311)
  #Scenario: Verify the "Send" button becomes active only after all required fields are filled in (5312)
  #Scenario: Verify the comment's attributes after adding (5313)
  #Scenario: Verify the last added comment appears at the top of the list (5314)
  #Scenario: Verify the "See More" button appears at the end of the comment if it is longer than 240 characters (5325)
  #Scenario: Verify the full comment appears after pressing the "See More" button (5326)
  #Scenario: Verify that comments will be saved after the form is sent for updates before approval (5457)
  #Scenario: Verify Captain cannot add comments to the form after approval (5327)
  #Scenario: Verify Office Approval Authority cannot add comments to the form after activation (5328)
  #Scenario: Verify that the comment added during the approval process is at the end of the final copy of PTW (5452)
  #Scenario: Verify that a long comment (more than 240 characters) is displayed in full (5456)
  #Scenario: Verify that comments are displayed in chronological order after the form termination (5454)
  #Scenario: Verify the Comments section at the end of the final copy of PTW - UI (5453)
  #Scenario: Verify Office Approval Authority cannot add comments to the form after termination (5329)
