@crew-list
Feature: CrewList
  As a ...
  I want to ...
  So that ...

  Background: Navigate to the "Crew Management" page
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    And Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"

  # @manual
  # Scenario: Verify Email notification sent to the assign crew

  # @manual
  # Scenario: Verify Crew to receive pin by email 2 weeks before boarding

#OLD
  Scenario: Verify table column headers are correct
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see correct column headers
#### REFACTORED
  Scenario: Verify the elements of Crew Management page
  Given Dashboard open dashboard page
  And Dashboard open hamburger menu
  And NavigationDrawer navigate to Dashboard "Crew Management"
  Then CrewManagement verify the elements are available
###

#OLD
  Scenario: Verify crew count match
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see total crew count match inactive crew
### REFACTORED
  Scenario: Verify the total crew quantity match with quantity in crew list
    Given CrewManagement compare crew count summary with crew list
     And CrewManagement compare crew count UI with DB
###

#OLD
  Scenario: Verify count down timer not started after clicking of View pin
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I view pin
    Then I should see count down start from 10 seconds
#OLD
  Scenario: Verify crew pin is shown after tapping on view pin with captain pin
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I view pin
    Then I should see pin reviewed
### REFACTORED
  Scenario Outline: Verify Master is able to View pin
    Given CrewManagement click View PINs button
    And PinEntry enter pin for rank "<rank>"
    Then CrewManagement verify the count down timer
    And CrewManagement verify the PIN is "shown"
    Examples:
    | rank |
    | MAS  |
    | A/M  |
###

#OLD
  Scenario: Verify error message shown for non-existent pin on view pin feature
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I enter a non-existent pin
    Then I should see invalid pin message
### REFACTORED
  Scenario: Verify user with non-Master is not able to View pin
    Given CrewManagement click View PINs button
    And PinEntry verify the error message is correct for the wrong rank
      | 4/O   |
      | A 4/O |
      | 5/O   |
      | D/C   |
      | SAA   |
      | BOS   |
      | A/B   |
      | O/S   |
      | RDCRW |
      | C/E   |
      | A C/E |
      | 2/E   |
      | A 2/E |
      | 3/E   |
      | A 3/E |
      | 4/E   |
      | A 4/E |
      | 5/E   |
      | E/C   |
      | ETO   |
      | ELC   |
      | ETR   |
      | T/E   |
      | CGENG |
      | PMN   |
      | FTR   |
      | OLR   |
      | WPR   |
      | CCK   |
      | 2CK   |
      | STWD  |
      | FSTO  |
      | SPM   |
###
#OLD
  Scenario: Verify error message shown for invalid master pin on view pin feature
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I enter a invalid master pin
    Then I should see not authorize error message
### REFACTORED
  Scenario: Verify error message shown for invalid master pin on view pin feature
    Given CrewManagement click View PINs button
    And PinEntry enter invalid pin "1234"
    Then PinEntry should see error msg "Incorrect Pin, Please Enter Again"

  ##

#OLD
  Scenario: Verify crew pin is hidden before view pin
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see pin hidden
### REFACTORED
    Scenario: Verify crew pin is hidden before view pin
      Given CrewManagement verify the PIN is "not shown"
###

#OLD
  # Scenario: Verify crew details match
  #   Given I launch sol-x portal
  #   When I navigate to "Crew Management" screen for forms
  #   Then I should see all crew details match
  Scenario: Verify crew latest location is display on crew listing
    Given I clear wearable history and active users
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I link wearable
    Then I should see crew location details on crew screen
    And I unlink all crew from wearable
### REFACTORED need check with opens PINS
  Scenario: Verify the crew data match
    Given DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | D/C  | 00:00:00:00:00:04 |
    And CrewManagement click View PINs button
    Then PinEntry enter pin for rank "MAS"
    And CrewManagement verify crew member data
      | rank |
      | D/C  |
    Then Wearable service unlink all wearables
  ###

#OLD
  Scenario: Verify location pin turn green below 5 minutes
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see crew list location indicator is green below 5 minutes
    And I unlink all crew from wearable
### REFACTORED
  Scenario: Verify location pin turn green below 5 minutes
    Given DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:01 |
    Given CrewManagement verify the indicator
      | rank | color |
      | C/O  | green |
      ###

#OLD
  Scenario: Verify location pin turn yellow after 5 minutes
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see crew list location indicator is yellow after 5 minutes
    And I unlink all crew from wearable
## REFACTORED
  Scenario: Verify location pin turn yellow after 5 minutes
    Given DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:01 |
    And CommonSection sleep for "305" sec
    Given CrewManagement verify the indicator
      | rank | color  |
      | C/O  | yellow |
###

#OLD
  Scenario Outline: Verify crew updated location is display on crew listing
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I link wearable to zone <zoneid> and mac <mac>
    And I update location to new zone <new_zoneid> and mac <new_mac>
    Then I should see crew location <new_zone> details on crew screen
    And I unlink all crew from wearable

    Examples:
      | zone        | zoneid            | mac               | new_zone    | new_zoneid    | new_mac           |
      | Engine Room | Z-FORE-PEAK-STORE | 00:00:00:00:00:00 | Aft Station | Z-AFT-STATION | 00:00:00:00:00:10 |

@test2 ## REFACTOR
  Scenario: Verify crew updated location is display on crew listing
    Given DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:04 |
    Then Wearable service update location
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
#    And CrewManagement click View PINs button
#    Then PinEntry enter pin for rank "MAS"
    And CrewManagement verify crew member data
      | rank |
      | 2/O  |
     And CommonSection sleep for "2" sec
    Then Wearable service unlink all wearables
@test
  Scenario: Verify location time period
    Given DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    When Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then CrewManagement verify location interval
      | rank |  time    |
      | 2/O  | Just Now |
    And CommonSection sleep for "65" sec
    Then CrewManagement verify location interval
      | rank |  time    |
      | 2/O  | min ago  |
    And CommonSection sleep for "245" sec
    Then CrewManagement verify location interval
      | rank |  time    |
      | 2/O  | mins ago |


#OLD not to do
  Scenario: Verify error message disappear after backspace on entered pin on view pin feature
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I enter a non-existent pin
    Then I should see invalid pin message
#OLD
  Scenario: Verify crew list is sorted in descending order of seniority
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see crews are sorted by descending order on seniority
#OLD
  Scenario: Verify user can add crew on an ad-hoc manner
    Given I launch sol-x portal
    And I remove crew from vessel
    When I navigate to "Crew Management" screen for forms
    And I add crew
    Then I sleep for 1000 seconds
    When I create the ptw with the new pin
    Then I should see smart form landing screen
    And I remove crew from vessel
#OLD
  Scenario Outline: Verify captain can only change rank of +1 and -1 from current rank
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
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
#OLD
  Scenario: Verify Retrieve My Data button is disable if empty Crew ID
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see Retrieve My Data button disabled
#OLD
  Scenario: Verify existing crew id cannot be added to the voyage
    Given I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I add an existing crew id
    Then I should see duplicate crew error message
