@crew-list_all
Feature: CrewList / Crew Management page
  # @manual
  # Scenario: Verify Email notification sent to the assign crew

  # @manual
  # Scenario: Verify Crew to receive pin by email 2 weeks before boarding
  @crew-list_1
  Scenario: Reset auto env to defaults
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
      | edge    | wearables    |
    Then DB service sleep "120" sec for data reloaded
    And CrewMember service reset
    Then DB service sleep "120" sec for data reloaded
  @crew-list_2
  Scenario: Verify the elements of Crew Management page (SOL-3772)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    Then CrewManagement verify the elements are available
  @crew-list_3
  Scenario: Verify the total crew list match with DB active crew members (SOL-3522)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement compare crew count
  @crew-list_4
  Scenario: Verify crew pin is hidden before view pin
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    When NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement verify the PIN is "not shown"
  @crew-list_5
  Scenario: Verify error message shown for invalid master pin on view pin feature (SOL-3774)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    When CrewManagement click View PINs button
    And PinEntry enter invalid pin "1234"
    Then PinEntry should see error msg "Incorrect Pin, Please Enter Again"
  @crew-list_6
  Scenario: Verify the crew data match
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
  Scenario: Verify location pin turn green below 5 minutes
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
  Scenario: Verify location pin turn yellow after 5 minutes
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
  Scenario: Verify crew updated location is display on crew listing (SOL-3521)
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
  Scenario: Verify location time period
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
   Scenario: Verify crew list is sorted in descending order of seniority (SOL-3773)
     Given Dashboard open dashboard page
     And Dashboard verify the local time
     Then Dashboard open hamburger menu
     And NavigationDrawer navigate to Dashboard "Crew Management"
     Then CrewManagement verify the crew list are loaded
     Then CrewManagement verify crew list sorting
  @crew-list_12
  Scenario: Verify Add Crew modal window (SOL-3797)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    When CrewManagement open Add Crew window
    Then AddCrew verify window elements
  @crew-list_13
  Scenario: Verify existing crew id cannot be added to the vessel (SOL-3518)
    Given Dashboard open dashboard page
    And Dashboard verify the local time
    Then Dashboard open hamburger menu
    And NavigationDrawer navigate to Dashboard "Crew Management"
    Then CrewManagement verify the crew list are loaded
    And CrewManagement open Add Crew window
    When AddCrew add crew member by id "AUTO_0002"
    Then AddCrew verify error message "Unable to add crew to the crew list. Please enter a correct Crew ID."
  @crew-list_14
  Scenario: Verify user can add crew from Dashboard (SOL-3516)
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
  Scenario: Verify newly added crew is able to sign by PIN
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
  Scenario Outline: Verify the range of available ranks that can be added to vessel
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
  @crew-list_17
  Scenario: Reset auto env to defaults
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
      | edge    | wearables    |
    Then DB service sleep "120" sec for data reloaded
    And CrewMember service reset
