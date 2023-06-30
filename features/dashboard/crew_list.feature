@crew-list_all
Feature: Script for testing Dashboard/CrewList page

  @crew-list_1
  Scenario: Test#1 Reset auto env to defaults
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
      | edge    | wearables    |
    Then DB service sleep "120" sec for data reloaded
    And CrewMember service reset
    Then DB service sleep "120" sec for data reloaded
    
  @crew-list_2
  Scenario: Test#2 Verify the elements of Crew Management page (SOL-3772)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    Then CrewManagement verify the elements are available
    
  @crew-list_3
  Scenario: Test#3 Verify the total crew list match with DB active crew members (SOL-3522)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement compare crew count
    
  @crew-list_4
  Scenario:  Test#4 Verify crew pin is hidden before view pin
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    When NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement verify the PIN is "not shown"
    
  @crew-list_5
  Scenario: Test#5 Verify error message shown for invalid master pin on view pin feature (SOL-3774)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    When CrewManagement click View PINs button
    And PinEntry enter invalid pin "1234"
    Then PinEntry should see error msg "Incorrect Pin, Please Enter Again"
    
  @crew-list_6
  Scenario: Test#6 Verify the crew data match
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    Then DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    Then DB service sleep "2" sec for data reloaded
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:04 |
    And CrewManagement click View PINs button
    Then PinEntry enter pin for rank "MAS"
    And CrewManagement verify crew member data
      | rank |
      | 2/O  |
    Then Wearable service unlink all wearables
    
  @crew-list_7
  Scenario: Test#7 Verify location pin turn green below 5 minutes
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    Then DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    Then DB service sleep "2" sec for data reloaded
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:01 |
    And CrewManagement verify the indicator
      | rank | color |
      | C/O  | green |
    Then Wearable service unlink all wearables
    
  @crew-list_8
  Scenario: Test#8 Verify location pin turn yellow after 5 minutes
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    Then DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    Then DB service sleep "2" sec for data reloaded
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:01 |
    And CommonSection sleep for "305" sec
    And CrewManagement verify the indicator
      | rank | color  |
      | C/O  | yellow |
    Then Wearable service unlink all wearables
    
  @crew-list_9
  Scenario:  Test#9 Verify crew updated location is display on crew listing (SOL-3521)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    Then DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    Then DB service sleep "2" sec for data reloaded
    And Wearable create new 1 wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:04 |
    Then Wearable service update location
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    And CrewManagement click View PINs button
    Then PinEntry enter pin for rank "MAS"
    And CrewManagement verify crew member data
      | rank |
      | 2/O  |
    Then Wearable service unlink all wearables
    
  @crew-list_10
  Scenario: Test#10 Verify location time period
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    Then DB service clear couch table
      | db_type | table     |
      | edge    | wearables |
    Then DB service sleep "2" sec for data reloaded
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
    Then Wearable service unlink all wearables
    
  @crew-list_11
   Scenario: Test#11 Verify crew list is sorted in descending order of seniority (SOL-3773)
     Given Dashboard open dashboard page
     And Dashboard verify the local time
     Then Dashboard open hamburger menu
     And NavigationDrawer navigate to Dashboard "Crew Management"
     Then CrewManagement verify the crew list are loaded
     Then CrewManagement verify crew list sorting
     
  @crew-list_12
  Scenario: Test#12 Verify Add Crew modal window (SOL-3797)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    When CrewManagement open Add Crew window
    Then AddCrew verify window elements
    
  @crew-list_13
  Scenario: Test#13 Verify existing crew id cannot be added to the vessel (SOL-3518)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "AUTO_0002"
    Then AddCrew verify error message "Unable to add crew to the crew list. Please enter a correct Crew ID."
    
  @crew-list_14
  Scenario: Test#14 Verify user can add crew from Dashboard (SOL-3516)
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
    Then DB service sleep "10" sec for data reloaded
    Then CrewMember service add team with empty vessel
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "AUTO_0002"
    And AddCrew verify new pin is shown
    
  @crew-list_15
  Scenario: Test#15 Verify newly added crew is able to sign by PIN
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
    Then DB service sleep "10" sec for data reloaded
    Then CrewMember service add team with empty vessel
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "AUTO_0026"
    And AddCrew confirm add crew operation and save pin
    And CommonSection sleep for "60" sec
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement compare crew count
    And CrewManagement click View PINs button
    And PinEntry enter saved pin
    Then CrewManagement verify the count down timer
    Then CrewManagement verify the PIN is "shown"
    
  @crew-list_16
  Scenario Outline: Test#16 Verify the range of available ranks that can be added to vessel
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
    Then DB service sleep "10" sec for data reloaded
    Then CrewMember service add team with empty vessel
    And Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "<crew_id>"
    Then AddCrew verify available rank list for "<current_rank>" "<group>"
    Examples:
      | crew_id   | current_rank | group   |
      | AUTO_0026 |     A/M      | group_1 |
      | AUTO_0002 |     C/O      | group_1 |
      | AUTO_0011 |     SAA      | group_2 |
      | AUTO_0012 |     C/E      | group_3 |
      | AUTO_0040 |     RDCRW    | group_4 |
      
  @crew-list_17
  Scenario: Test#17 Reset auto env to defaults
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
      | edge    | wearables    |
    Then DB service sleep "120" sec for data reloaded
    And CrewMember service reset
