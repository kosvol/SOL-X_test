@crew-list
Feature: CrewList
  As a ...
  I want to ...
  So that ...

  Scenario: Verify count down timer not started after clicking of View pin
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I view pin
    Then I should see count down start from 10 seconds

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

  # Scenario: Verify crew details match
  #   Given I launch sol-x portal
  #   When I navigate to "Crew List" screen
  #   Then I should see all crew details match

  Scenario: Verify location pin turn green below 5 minutes
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see crew list location indicator is green below 5 minutes
    And I unlink all crew from wearable

  Scenario: Verify location pin turn yellow after 5 minutes
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see crew list location indicator is yellow after 5 minutes
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

  Scenario: Verify error message shown for non-existent pin on view pin feature
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I enter a non-existent pin
    Then I should see invalid pin message

  Scenario: Verify error message shown for invalid master pin on view pin feature
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I enter a invalid master pin
    Then I should see not authorize error message

  Scenario: Verify error message disappear after backspace on entered pin on view pin feature
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I enter a non-existent pin
    Then I should not see invalid pin message

  Scenario: Verify crew list is sorted in descending order of seniority
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see crews are sorted by descending order on seniority

  # @manual
  # Scenario: Verify Email notification sent to the assign crew

  # @manual
  # Scenario: Verify Crew to receive pin by email 2 weeks before boarding

  # Scenario: Verify user can add crew on an ad-hoc manner
  #   Given I launch sol-x portal
  #   When I navigate to "Crew List" screen
  #   And I add crew
  #   And I change the crew rank
  #   Then I should see pin review
  #   And I should see crew added with rank changed
  #   And I reset crew data

  # Scenario: Verify newly added crew pin can be reviewed

  Scenario Outline: Verify captain can only change rank of +1 and -1 from current rank
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I add crew <crew_id> id
    Then I should see rank listing for <current_rank> showing 1 rank before and after

    Examples:
      | crew_id       | current_rank |
      | CDEV_SOLX0001 | MAS          |
      | CDEV_SOLX0012 | A/M          |
      | CDEV_TEST0001 | C/O          |
      | CDEV_SOLX0005 | A C/O        |
      # | CDEV_SOLX0006 | 2/O          |
      | CDEV_SOLX0007 | A 2/O        |
      | CDEV_SOLX0008 | 3/O          |
      | CDEV_SOLX0009 | A 3/O        |
      | test_A009     | 4/O          |
      | test_A010     | A 4/O        |
      | test_A041     | 5/O          |
      | CDEV_SOLX0016 | D/C          |
      | CDEV_SOLX0018 | BOS          |
      | CDEV_SOLX0021 | A/B          |
      | test_A043     | O/S          |
      # | test_A015       | SAA          |
      # | test_A017       | C/E          |
      # | test_A018     | A C/E        |
      | test_A019     | 2/E          |
      | test_A020     | A 2/E        |
      | test_A021     | 3/E          |
      | test_A022     | A 3/E        |
      | CDEV_SOLX0023 | 4/E          |
      | CDEV_SOLX0024 | A 4/E        |
      | test_A025     | T/E          |
      | test_A040     | 5/E          |
      | test_A029     | E/C          |
      | CDEV_SOLX0017 | ETO          |
      | test_A050     | ELC          |
      | test_A044     | ETR          |
      # | CDEV_SOLX0020 | PMN          |
      | test_A047     | FTR          |
      | test_A048     | OLR          |
      # | test_data_jun25 | CCK          |
      | test_002      | 2CK          |
  # | test_A039     | FSTO         |
  # | test_A042     | RDCRW        |
  # | test_A046     | SPM          |

  Scenario: Verify Retrieve My Data button is disable if empty Crew ID
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    Then I should see Retrieve My Data button disabled

  Scenario: Verify existing crew id cannot be added to the voyage
    Given I launch sol-x portal
    When I navigate to "Crew List" screen
    And I add an existing crew id
    Then I should see duplicate crew error message
