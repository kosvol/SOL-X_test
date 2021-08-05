@location-tracking @SOL-1838
Feature: LocationTracking
  As a ...
  I want to ...
  So that ...

  Background:
    Given I clear wearable history and active users

  Scenario: SOL-5489 Verify connectivity blob display either green or red during online or offline
    Given I launch sol-x portal without unlinking wearable
    Then I should see green online blob
    And I turn off wifi
    Then I should see red online blob
    And I turn on wifi
    Then I should see green online blob

  Scenario: Verify crew list table header is correct
    Given I launch sol-x portal without unlinking wearable
    Then I should see correct table headers for crew list

  Scenario: Verify PTW is tied to crew
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    And I sleep for 5 seconds
    When I launch sol-x portal
    And I link C/O user wearable
    Then I should see crew link to PTW
    And I unlink all crew from wearable

  Scenario: Verify crew able to access ptw via dashboard crew list
    Given I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    And I sleep for 5 seconds
    When I launch sol-x portal
    And I link C/O user wearable
    And I click on any ptw
    And I enter pin for rank MAS
    Then I should see correct permit display
    And I should see navigation dropdown
    And I unlink all crew from wearable

  # Scenario: Verify entry log counts match

  # Scenario: Verify entry log navigate to entry log page

  Scenario: Verify active crew with location details are correct
    Given I launch sol-x portal
    When I link wearable
    Then I should see active crew details
    And I unlink all crew from wearable

  Scenario: Verify total crew count display on map while having same location
    Given I launch sol-x portal
    When I link wearable to zone 01EKYSC64D6MYZ2MF6CJDAMH8K and mac 27:58:E1:0D:68:F1
    And I link wearable to zone 01EKYSC64D6MYZ2MF6CJDAMH8K and mac 27:58:E1:0D:68:F1
    Then I should see Full Ship location indicator showing 2 on location pin
    And I should see Engine Room location indicator showing 2 on location pin
    And I unlink all crew from wearable

  Scenario Outline: Verify active crew member location changed
    Given I launch sol-x portal
    When I link wearable to zone <zoneid> and mac <mac>
    And I update location to new zone <new_zoneid> and mac <new_mac>
    Then I should see ui location updated to <new_zone>
    And I unlink all crew from wearable

    Examples:
      | zone        | zoneid                      | mac               | new_zone    | new_zoneid                  | new_mac           |
      | Engine Room | AUTO_0AF6FGV9QFVQEDA6XAJWV8 | 00:00:00:00:A0:00 | Aft Station | AUTO_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 |

  Scenario: Verify active duration countdown starts at 15s
    Given I launch sol-x portal
    Then I should see countdown starts at 15s
    And I unlink all crew from wearable

  Scenario: Verify active crew last seen status is Just now
    Given I launch sol-x portal
    Then I should see Just now as current active crew
    And I unlink all crew from wearable

  Scenario: Verify active crew member indicator is green below 5 minutes
    Given I launch sol-x portal
    Then I should see activity indicator is green below 5 minutes
    And I unlink all crew from wearable

  Scenario: Verify active crew member indicator is yellow after 5 minutes
    Given I launch sol-x portal
    Then I should see activity indicator is yellow after 5 minutes
    And I unlink all crew from wearable

  Scenario Outline: Verify active crew member count is correct on engine room against full ship
    Given I launch sol-x portal
    When I link wearable to zone <zoneid> and mac <mac>
    Then I should see <zone> count represent 1
    And I expand location drop down menu
    And I should see ui location updated to <location>
    And I collapse location drop down menu
    And I should see Full Ship count represent 1
    And I expand location drop down menu
    And I should see ui location updated to <location>
    And I collapse location drop down menu
    And I should see Lower Accomm. count represent 0
    And I expand location drop down menu
    And I should see ui location updated to <location>
    And I collapse location drop down menu
    And I unlink all crew from wearable

    Examples:
      | zone         | zoneid                      | mac               | location      |
      | Main Deck    | AUTO_0ABXE1MTWY05N3SP16F96T | 00:00:00:00:00:90 | Aft Station   |
      | Pump Room    | AUTO_0ABXE1CH1MN0QMK21PPK40 | C4:BE:84:CE:19:82 | Pump Room Top |
      | Funnel Stack | AUTO_0ABXE10S7JGZ0TYHR704GH | 00:00:00:00:00:A0 | IG Platform 2 |
  # | Upper Deck   | CDEV_0PKFCRX6C6FDCAGKDP3A0 | 48:46:00:00:41:43 |
  # | Accomm.      | CDEV_0PKFGWR2F7ZP8MFAC8FR3 | A0:E6:F8:2D:08:78 |
  # | Nav. Bridge  | CDEV_0PKFJZ4B7F7C3K8RZMXJG | B0:B4:48:FC:71:5E |

  Scenario: Verify total count for full ship is correct when toggle at inactive
    Given I launch sol-x portal
    Then I should see Full Ship count represent 0
    And I unlink all crew from wearable

  Scenario: Verify total count for full ship is correct when toggle at active
    Given I launch sol-x portal
    And I link wearable
    And I link wearable
    Then I should see Full Ship count represent 2
    And I unlink all crew from wearable

  Scenario: Verify PRE activity tab shows inactive after active permit got terminated
    When I launch sol-x portal
    And I submit a scheduled PRE permit
    And I sleep for 85 seconds
    Then I should see PRE tab active on dashboard
    When I terminate the PRE permit via service
    And I sleep for 20 seconds
    Then I should not see PRE tab active on dashboard

  Scenario: Verify PRE active tab is grey with inactive PRE
    Given I clear PRE forms
    When I launch sol-x portal
    Then I should not see PRE tab active on dashboard

  Scenario: Verify PRE active tab is green with active PRE
    Given I clear PRE forms
    When I launch sol-x portal
    And I submit a scheduled PRE permit
    And I sleep for 85 seconds
    Then I should see PRE tab active on dashboard