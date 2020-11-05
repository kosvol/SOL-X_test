@submit-permits-on-section6
Feature: SubmitPermit
  As a ...
  I want to ...
  So that ...

  @x13
  Scenario: Verify master can send for oa approval twice
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    When I press next for 10 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I should see comment reset
    And I add comment on oa permit
    And I approve oa permit via oa link manually
    And I click on pending approval filter
    And Master request for oa permit update
    And I reapprove the updated permit
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I approve oa permit via oa link manually
    And I click on pending approval filter
    And I approve permit
    And I click on back to home
    And I click on active filter
    Then I should see permit valid for 8 hours

  @smoke-test-1
  Scenario:  Submit permit data Enclosed Spaces Entry
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3b
    And I set time
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
    # And I fill up section 5
    And I press next for 1 times
    # fill gas reader?
    And I submit smoke test permit
    And I click on back to home
  # And I click on pending approval filter
  # And I review page 1 of submitted enclose workspace permit
  # And I review page 2 of submitted enclose workspace permit
  # And I review page 3a of submitted enclose workspace permit
  # And I review page 3b of submitted enclose workspace permit
  # And I review page 3c of submitted enclose workspace permit
  # And I review page 3d of submitted enclose workspace permit
  # And I review page 4a of submitted enclose workspace permit
  # And I review page 4a checklist of submitted enclose workspace permit
  # And I review page 4b of submitted enclose workspace permit
  # And I review page 5 of submitted enclose workspace permit
  # And I review page 6 of submitted enclose workspace permit

  @smoke-test-2
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

#   Scenario: Verify submitted permit data gets reflected for Cold Work - Connecting and Disconnecting Pipelines
#     Given I launch sol-x portal without unlinking wearable
#     And I navigate to create new permit
#     And I enter pin 9015
#     And I select Cold Work permit
#     And I select Cold Work - Connecting and Disconnecting Pipelines permit for level 2
#     And I fill up section 1 with default value
#     And I navigate to section 3b
#     And I fill up section 3b
#     And I press next for 1 times
#     And I fill up section 3c
#     And I press next for 1 times
#     And I fill up section 3d
#     And I press next for 1 times
#     And I fill up section 4a
#     And I press next for 1 times
#     And I fill up checklist yes, no, na
#     And I select PPE equipment
#     And I press next for 1 times
#     And I select yes to EIC
#     And I press next for 1 times
#     And I fill up section 5
#     And I press next for 1 times
#     # select gas reader?
#     Then I submit permit for Master Approval
#     And I click on back to home
#     And I click on pending approval filter
#     And I review page 1 of submitted cold work permit
#     And I review page 2 of submitted cold work permit
#     And I review page 3a of submitted cold work permit
#     And I review page 3b of submitted cold work permit
#     And I review page 3c of submitted cold work permit
#     And I review page 3d of submitted cold work permit
#     And I review page 4a of submitted cold work permit
#     And I review page 4a checklist of submitted cold work permit
#     And I review page 4b of submitted cold work permit
#     And I review page 5 of submitted cold work permit
#   # And I review page 6 of submitted cold work permit

#   Scenario: Verify submitted permit data gets reflected for Hot Work
#     Given I launch sol-x portal without unlinking wearable
#     And I navigate to create new permit
#     And I enter pin 9015
#     And I select Hot Work permit
#     And I select Hot Work Level-2 in Designated Area permit for level 2
#     And I fill up section 1 with default value
#     And I navigate to section 3b
#     And I fill up section 3b
#     And I press next for 1 times
#     And I fill up section 3c
#     And I press next for 1 times
#     And I fill up section 3d
#     And I press next for 1 times
#     And I fill up section 4a
#     And I press next for 1 times
#     And I fill up checklist yes, no, na
#     And I press next for 1 times
#     And I select yes to EIC
#     And I press next for 1 times
#     And I fill up section 5
#     And I press next for 1 times
#     # select gas reader?
#     Then I submit permit for Master Approval
#     And I click on back to home
#     And I click on pending approval filter
#     And I review page 1 of submitted hot work permit
#     And I review page 2 of submitted hot work permit
#     And I review page 3a of submitted hot work permit
#     And I review page 3b of submitted hot work permit
#     And I review page 3c of submitted hot work permit
#     And I review page 3d of submitted hot work permit
#     And I review page 4a of submitted hot work permit
#     And I review page 4a checklist of submitted hot work permit
#     And I review page 4b of submitted hot work permit
#     And I review page 5 of submitted hot work permit
#   # And I review page 6 of submitted hot work permit

#   Scenario: Verify work on hazardous substance checklist can be opened in read only mode
#     Given I launch sol-x portal without unlinking wearable
#     And I navigate to create new permit
#     And I enter pin 9015
#     And I select Hot Work permit
#     And I select Hot Work Level-1 (Loaded & Ballast Passage) permit for level 2
#     And I fill up section 1 with default value
#     And I navigate to section 3b
#     And I fill up section 3b
#     And I press next for 1 times
#     And I fill up section 3c
#     And I press next for 1 times
#     And I fill up section 3d
#     And I press next for 1 times
#     And I fill up section 4a
#     And I uncheck the pre-selected checklist
#     And I select the matching Work on Hazardous Substances checklist
#     And I press next for 1 times
#     And I fill up checklist yes, no, na
#     And I select PPE equipment
#     And I press next for 1 times
#     And I select yes to EIC
#     And I press next for 1 times
#     And I fill up section 5
#     And I press next for 1 times
#     # select gas reader?
#     Then I submit permit for Master Approval
#     And I click on back to home
#     And I click on pending approval filter
#     And I review page 1 of submitted hot work with hazard permit
#     And I review page 2 of submitted hot work with hazard permit
#     And I review page 3a of submitted hot work with hazard permit
#     And I review page 3b of submitted hot work with hazard permit
#     And I review page 3c of submitted hot work with hazard permit
#     And I review page 3d of submitted hot work with hazard permit
#     And I review page 4a of submitted hot work with hazard permit
#     And I review page 4a checklist of submitted hot work with hazard permit
#     And I review page 4b of submitted hot work with hazard permit
#     And I review page 5 of submitted hot work with hazard permit
# # And I review page 6 of submitted non maintenance permit
