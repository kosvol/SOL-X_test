@submit-permits-on-section6
Feature: SubmitPermit
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify ROL smoke test

  # @x13
  # Scenario: Verify master can send for oa approval twice
  #   Given I launch sol-x portal without unlinking wearable
  #   And I navigate to create new permit
  #   And I enter pin 9015
  #   And I select Critical Equipment Maintenance permit
  #   And I select Maintenance on Magnetic Compass permit for level 2
  #   And I fill section 1 of maintenance permit with duration more than 2 hours
  #   When I press next for 10 times
  #   Then I submit permit for Master Review
  #   When I click on back to home
  #   And I click on pending approval filter
  #   And I set oa permit to office approval state manually
  #   And I navigate to OA link
  #   And I should see comment reset
  #   And I add comment on oa permit
  #   And I approve oa permit via oa link manually
  #   And I click on pending approval filter
  #   And Master request for oa permit update
  #   And I reapprove the updated permit
  #   And I click on pending approval filter
  #   And I set oa permit to office approval state manually
  #   And I navigate to OA link
  #   And I approve oa permit via oa link manually
  #   And I click on pending approval filter
  #   And I approve permit
  #   And I click on back to home
  #   And I click on active filter
  #   Then I should see permit valid for 8 hours

  @pending-approval-smoke-test-1
  Scenario: Submit permit data Enclosed Spaces Entry into pending approval state
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3a
    And I add a new hazard
    And I press next for 1 times
    And I set time
    And I should see crew drop down list after clicking Yes on Inspection carried out
    And I select 1 role from list
    And I fill up section 3b
    And I press next for 1 times
    And I fill up section 3c
    And I press next for 1 times
    And I fill up section 3d
    And I press next for 1 times
    And I fill up section 4a
    And I press next for 1 times
    And I fill up checklist yes, no, na
    And I press next for 1 times
    And I select yes to EIC
    And I fill up EIC certificate
    And I press next for 1 times
    And I fill up section 5
    And I press next for 1 times
    And I add all gas readings
    And I enter pin 9015
    And I dismiss gas reader dialog box
    And I submit smoke test permit
    And I click on back to home
    And I sleep for 5 seconds

  @active-smoke-test-1
  Scenario: Submit permit data Enclosed Spaces Entry into active
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3a
    And I add a new hazard
    And I press next for 1 times
    And I set time
    And I should see crew drop down list after clicking Yes on Inspection carried out
    And I select 1 role from list
    And I fill up section 3b
    And I press next for 1 times
    And I fill up section 3c
    And I press next for 1 times
    And I fill up section 3d
    And I press next for 1 times
    And I fill up section 4a
    And I press next for 1 times
    And I fill up checklist yes, no, na
    And I press next for 1 times
    And I select yes to EIC
    And I fill up EIC certificate
    And I press next for 1 times
    And I fill up section 5
    And I press next for 1 times
    And I add all gas readings
    And I enter pin 9015
    And I dismiss gas reader dialog box
    And I submit smoke test permit
    And I click on back to home
    And I sleep for 5 seconds
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I sleep for 5 seconds

  @pending-approval-smoke-test-2
  Scenario: Verify submitted permit data gets reflected for Enclosed Spaces Entry
    Given I launch sol-x portal without unlinking wearable
    And I click on pending approval filter
    And I review page 1 of submitted enclose workspace permit
    And I review page 2 of submitted enclose workspace permit
    And I review page 3a of submitted enclose workspace permit
    And I review page 3b of submitted enclose workspace permit
    And I review page 3c of submitted enclose workspace permit
    And I review page 3d of submitted enclose workspace permit
    And I review page 4a of submitted enclose workspace permit
    And I review page 4a checklist of submitted enclose workspace permit
    And I review page 4b of submitted enclose workspace permit
    And I review page 5 of submitted enclose workspace permit
    And I review page 6 of submitted enclose workspace permit