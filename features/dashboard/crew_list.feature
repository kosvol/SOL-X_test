@crew-list
Feature: CrewList
  As a ...
  I want to ...
  So that ...

  Background: Navigate to the "Crew Management" page
    Given Dashboard open dashboard page
#    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"

  # @manual
  # Scenario: Verify Email notification sent to the assign crew

  # @manual
  # Scenario: Verify Crew to receive pin by email 2 weeks before boarding

#OLD
  Scenario: Verify table column headers are correct
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see correct column headers
#### REFACTORED
  Scenario: Verify the elements of Crew Management page
  And Dashboard open dashboard page
  And Dashboard open hamburger menu
  And NavigationDrawer navigate to Dashboard "Crew Management"
  Then CrewManagement verify the elements are available
###

#OLD
  Scenario: Verify crew count match
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see total crew count match inactive crew
### REFACTORED
  Scenario: Verify the total crew quantity match with quantity in crew list
    And CrewManagement compare crew count
###

#OLD
  Scenario: Verify count down timer not started after clicking of View pin
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I view pin
    Then I should see count down start from 10 seconds
#OLD
  Scenario: Verify crew pin is shown after tapping on view pin with captain pin
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I view pin
    Then I should see pin reviewed
@test ### REFACTORED
  Scenario Outline: Verify Master is able to View pin
    And CrewManagement click View PINs button
    And PinEntry enter pin for rank "<rank>"
    Then CrewManagement verify the count down timer
    And CrewManagement verify the PIN is "shown"
    Examples:
    | rank |
#    | MAS  |
    | A/M  |
###

#OLD
  Scenario: Verify error message shown for non-existent pin on view pin feature
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I enter a non-existent pin
    Then I should see invalid pin message
### REFACTORED
  Scenario: Verify user with non-Master is not able to View pin
    And CrewManagement click View PINs button
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
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I enter a invalid master pin
    Then I should see not authorize error message
### REFACTORED
  Scenario: Verify error message shown for invalid master pin on view pin feature
    And CrewManagement click View PINs button
    And PinEntry enter invalid pin "1234"
    Then PinEntry should see error msg "Incorrect Pin, Please Enter Again"

  ##

#OLD
  Scenario: Verify crew pin is hidden before view pin
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see pin hidden
### REFACTORED
    Scenario: Verify crew pin is hidden before view pin
      And CrewManagement verify the PIN is "not shown"
###

#OLD
  # Scenario: Verify crew details match
  #   And I launch sol-x portal
  #   When I navigate to "Crew Management" screen for forms
  #   Then I should see all crew details match
  Scenario: Verify crew latest location is display on crew listing
    And I clear wearable history and active users
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I link wearable
    Then I should see crew location details on crew screen
    And I unlink all crew from wearable
### REFACTORED need check with opens PINS
  Scenario: Verify the crew data match
    And DB service clear couch table
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
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see crew list location indicator is green below 5 minutes
    And I unlink all crew from wearable
### REFACTORED
  Scenario: Verify location pin turn green below 5 minutes
    And DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:01 |
    And CrewManagement verify the indicator
      | rank | color |
      | C/O  | green |
      ###

#OLD
  Scenario: Verify location pin turn yellow after 5 minutes
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see crew list location indicator is yellow after 5 minutes
    And I unlink all crew from wearable
## REFACTORED
  Scenario: Verify location pin turn yellow after 5 minutes
    And DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:01 |
    And CommonSection sleep for "305" sec
    And CrewManagement verify the indicator
      | rank | color  |
      | C/O  | yellow |
###

#OLD
  Scenario Outline: Verify crew updated location is display on crew listing
    And I launch sol-x portal
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
    And DB service clear couch table
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
### REFACTORED
  Scenario: Verify location time period
    And DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    And Wearable create new 1 wearables
    When Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then CrewManagement verify location interval
      | rank |  time    |
      | 2/O  | Just now |
    And CommonSection sleep for "25" sec
    Then CrewManagement verify location interval
      | rank |  time    |
      | 2/O  | secs ago |
    And CommonSection sleep for "60" sec
    Then CrewManagement verify location interval
      | rank |  time    |
      | 2/O  | min ago  |
    And CommonSection sleep for "240" sec
    Then CrewManagement verify location interval
      | rank |  time    |
      | 2/O  | mins ago |


#OLD not to do
  Scenario: Verify error message disappear after backspace on entered pin on view pin feature
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I enter a non-existent pin
    Then I should see invalid pin message
#OLD
  Scenario: Verify crew list is sorted in descending order of seniority
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see crews are sorted by descending order on seniority
### REFACTORED
   Scenario: Verify crew list is sorted in descending order of seniority
     And CrewManagement verify crew list sorting
 ##

#OLD
  Scenario: Verify user can add crew on an ad-hoc manner
    And I launch sol-x portal
    And I remove crew from vessel
    When I navigate to "Crew Management" screen for forms
    And I add crew
    Then I sleep for 1000 seconds
    When I create the ptw with the new pin
    Then I should see smart form landing screen
    And I remove crew from vessel
    
 @test2  ##REF
  Scenario: Verify user can add crew on an ad-hoc manner
#    Given DB service clear couch table
#      | db_type | table        |
#      | edge    | crew_members |
#      | cloud   | crew_members |
#    Then CrewMember service reset with empty vessel
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "AUTO_0026"
    And AddCrew confirm add crew operation and save pin
    And CommonSection sleep for "60" sec
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    And CrewManagement compare crew count
    And CrewManagement click View PINs button
    And PinEntry enter saved pin
    Then CrewManagement verify the PIN is "shown"
#OLD
  Scenario Outline: Verify captain can only change rank of +1 and -1 from current rank
    And I launch sol-x portal
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
##REFACTORED
  Scenario Outline: Verify the range of available ranks that can be added to vessel
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "<crew_id>"
    Then AddCrew verify available rank list for "<current_rank>" "<group>"
    Examples:
      | crew_id   | current_rank | group   |
      | AUTO_0026 |     A/M      | group_1 |
      | AUTO_0002 |     C/O      | group_1 |
      | AUTO_0027 |     A C/O    | group_1 |
      | AUTO_0003 |     2/O      | group_1 |
      | AUTO_0028 |     A 2/O    | group_1 |
      | AUTO_0004 |     3/O      | group_1 |
      | AUTO_0029 |     A 3/O    | group_1 |
      | AUTO_0005 |     4/O      | group_1 |
      | AUTO_0030 |     A 4/O    | group_1 |
      | AUTO_0006 |     5/O      | group_1 |
      | AUTO_0007 |     D/C      | group_1 |
      | AUTO_0008 |     BOS      | group_1 |
      | AUTO_0009 |     A/B      | group_1 |
      | AUTO_0010 |     O/S      | group_1 |
      | AUTO_0011 |     SAA      | group_2 |
      | AUTO_0012 |     C/E      | group_3 |
      | AUTO_0031 |     A C/E    | group_1 |
      | AUTO_0013 |     2/E      | group_1 |
      | AUTO_0032 |     A 2/E    | group_1 |
      | AUTO_0014 |     3/E      | group_1 |
      | AUTO_0033 |     A 3/E    | group_1 |
      | AUTO_0015 |     CGENG    | group_1 |
      | AUTO_0016 |     4/E      | group_1 |
      | AUTO_0034 |     A 4/E    | group_1 |
      | AUTO_0017 |     5/E      | group_1 |
      | AUTO_0018 |     T/E      | group_1 |
      | AUTO_0019 |     E/C      | group_1 |
      | AUTO_0020 |     ETO      | group_1 |
      | AUTO_0021 |     ELC      | group_1 |
      | AUTO_0022 |     ETR      | group_1 |
      | AUTO_0023 |     PMN      | group_1 |
      | AUTO_0024 |     FTR      | group_1 |
      | AUTO_0025 |     OLR      | group_1 |
      | AUTO_0035 |     WPR      | group_2 |
      | AUTO_0036 |     CCK      | group_3 |
      | AUTO_0037 |     2CK      | group_1 |
      | AUTO_0038 |     STWD     | group_2 |
      | AUTO_0039 |     FSTO     | group_4 |
      | AUTO_0040 |     RDCRW    | group_4 |
      | AUTO_0041 |     SPM      | group_4 |
    ##

#OLD
  Scenario: Verify Retrieve My Data button is disable if empty Crew ID
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    Then I should see Retrieve My Data button disabled
##REFACTORED
Scenario: Verify Retrieve My Data button is disable if empty Crew ID
  And CrewManagement open Add Crew window
  Then AddCrew verify button availability
    | button           | availability |
    | Retrieve My Data | disabled     |
  ##

#OLD
  Scenario: Verify existing crew id cannot be added to the voyage
    And I launch sol-x portal
    When I navigate to "Crew Management" screen for forms
    And I add an existing crew id
    Then I should see duplicate crew error message
##REFACTORED
  Scenario: Verify existing crew id cannot be added to the vessel
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "AUTO_0002"
    Then AddCrew verify error message "Unable to add crew to the crew list. Please enter a correct Crew ID."
 ##