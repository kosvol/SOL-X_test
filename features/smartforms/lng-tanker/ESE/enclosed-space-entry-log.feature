@enclosed-space-ent
Feature: EnclosedSpaceEntryLog
  As a ...
  I want to ...
  So that ...


  Scenario: Check Enclosed Spaces Entry log is empty
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    Then I should see no new entry log message in Entry log

  @wip
  Scenario: Check Enclosed Spaces Entry log first log
    Given I submit permit submit_enclose_space_entry via service with 8383 user and set to active state with gas reading require
    When I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I click New Entrant button on Enclose Space Entry PWT
    And I add normal gas readings
    And I review and sign gas readings
    And I enter pin 8383








#    Given I launch sol-x portal without unlinking wearable
#    When I navigate to create new permit
#    And I enter pin 8383
#    And I select Enclosed Spaces Entry permit
#    And I select Enclosed Spaces Entry permit for level 2
#    And I fill up section 1 with default value
#    And I navigate to section 5
#    Then I should see a list of roles
#    And I select Authorized Gas Tester role from list
