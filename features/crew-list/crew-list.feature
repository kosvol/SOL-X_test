@crew-list
Feature: CrewList
  As a ...
  I want to ...
  So that ...

  Scenario: Verify table column headers are correct
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see correct column headers

  Scenario: Verify crew count match
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see total crew count match inactive crew

  Scenario: Verify crew pin is hidden before view pin
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see pin hidden

  Scenario: Verify crew details match
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see all crew details match

  # @skip
  # Scenario: Verify location pin turn red after triggering crew assist

  Scenario: Verify location pin turn green below 30s
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see crew list location indicator is green below 30s
    And I unlink all crew from wearable

  Scenario: Verify location pin turn yellow after 30s
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see crew list location indicator is yellow after 30s
    And I unlink all crew from wearable

  Scenario: Verify crew latest location is display on crew listing
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I link wearable
    Then I should see crew location details on crew screen
    And I unlink all crew from wearable

  Scenario Outline: Verify crew updated location is display on crew listing
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I link wearable to zone <zoneid> and mac <mac>
    And I update location to new zone <new_zoneid> and mac <new_mac>
    Then I should see crew location <new_zone> details on crew screen
    And I unlink all crew from wearable

    Examples:
      | zone        | zoneid                     | mac               | new_zone         | new_zoneid                 | new_mac           |
      | Engine Room | SIT_0AJK702J76YK6GVCEGMTE6 | 00:00:00:80:00:00 | Pump Room Bottom | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 |

  Scenario: Verify crew pin is shown after tapping on view pin with captain's pin
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I view pin
    Then I should see pin reviewed

  Scenario: Verify error message shown for non-existent pin
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I enter a non-existent pin
    Then I should see invalid pin message

  Scenario: Verify error message shown for invalid master pin
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I enter a invalid master pin
    Then I should see not authorize error message

  Scenario: Verify error message disappear after backspace on entered pin
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I enter a non-existent pin
    And I backspace on entered pin
    Then I should not see invalid pin message

  Scenario: Verify crew list is sorted in descending order of seniority
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see crews are sorted by descending order on seniority

  @manual
  Scenario: Verify Email notification sent to the assign crew

  @manual
  Scenario: Verify Crew to receive pin by email 2 weeks before boarding

  ## i think this is not valid anymore
  @manual
  Scenario: Verify adhoc crew is added the next day T+1

  @skip
  Scenario: Verify existing crew id cannot be added to the voyage
# Given I launch sol-x portal
# When I navigate to crew List
# And I add an existing crew id
# Then I should not be able to add
