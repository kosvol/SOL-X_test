@location-tracking @SOL-1838
Feature: LocationTracking
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify wearable is single sign on

  Scenario: Verify inactive crew count is correct
    Given I launch sol-x portal
    Then I should see inacive crew count is correct
    And I unlink all crew from wearable

@1
  Scenario: Verify active crew count is correct
    Given I launch sol-x portal
    Then I should see acive crew count is correct
    And I unlink all crew from wearable

  Scenario: Verify active crew with location details are correct
    Given I launch sol-x portal
    When I link wearable
    Then I should see active crew details
    And I unlink all crew from wearable

  # Scenario: Verify active crew member name longer than 3 chars to display on map

  Scenario Outline: Verify active crew member location changed after 30s
    Given I launch sol-x portal
    When I link wearable to zone <zoneid> and mac <mac>
    And I toggle activity crew list
    And I update location to new zone <new_zoneid> and mac <new_mac>
    Then I should see ui location updated
    And I unlink all crew from wearable

    Examples:
    | zone         | zoneid                     | mac               | new_zone  | new_zoneid                 | new_mac           |
    | Engine Room  | SIT_0AJK702J76YK6GVCEGMTE6 | 00:00:00:80:00:00 | Pump Room | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 |

  Scenario: Verify active duration countdown starts at 15s
    Given I launch sol-x portal
    Then I should see countdown starts at 15s
    And I unlink all crew from wearable

  Scenario: Verify active crew last seen status is Just now
    Given I launch sol-x portal
    Then I should see Just now as current active crew
    And I unlink all crew from wearable

  Scenario: Verify active crew member indicator is green below 30s
    Given I launch sol-x portal
    Then I should see activity indicator is green below 30s
    And I unlink all crew from wearable

  Scenario: Verify active crew member indicator is yellow after 30s
    Given I launch sol-x portal
    Then I should see activity indicator is yellow after 30s
    And I unlink all crew from wearable

  Scenario Outline: Verify active crew member count is correct on engine room against full ship
    Given I launch sol-x portal
    When I link wearable to zone <zoneid> and mac <mac>
    Then I should see <zone> count 1
    And I unlink all crew from wearable

    Examples:
    | zone         | zoneid                     | mac               |
    | Engine Room  | SIT_0AJK702J76YK6GVCEGMTE6 | 00:00:00:80:00:00 |
    | Pump Room    | SIT_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 |
    | Funnel Stack | SIT_0ABXE10S7JGZ0TYHR704GH | 00:00:00:00:00:A0 |
    # | Upper Deck   | CDEV_0PKFCRX6C6FDCAGKDP3A0 | 48:46:00:00:41:43 |
    # | Accomm.      | CDEV_0PKFGWR2F7ZP8MFAC8FR3 | A0:E6:F8:2D:08:78 |
    # | Nav. Bridge  | CDEV_0PKFJZ4B7F7C3K8RZMXJG | B0:B4:48:FC:71:5E |

  # Scenario: Verify total count for full ship is correct