@crew-assist
Feature: CrewAssist

  @test
  Scenario: Create wearable
    Given Wearable create new 3 wearables

  @test
  Scenario: Verify the crew assist message is shown on the Dashboard
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:01 |
    Then Dashboard open dashboard page
    When Wearable service send crew assist alerts
    And DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |

  @test2
  Scenario: Verify the crew assist message is disappear after dismissing
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | C/E  | 00:00:00:00:00:02 |
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    And Wearable service send crew assist alerts
    Then Wearable service dismiss crew assist alerts
    And DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | not displayed |
  @test3
  Scenario: Verify the crew assist data match with wearable data
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:03 |
    Given Dashboard open dashboard page
    And Wearable service send crew assist alerts
    Then DashboardAlert verify crew assist alert data
      | rank |
      | 2/O  |

  @test4
  Scenario Outline: Verify the 'Crew Assist Acknowledger' is able to acknowledge
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 3/O  | 00:00:00:00:00:05 |
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    Then Wearable service send crew assist alerts
    And DashboardAlert click Acknowledge button
      | rank |
      | 3/O  |
    Then PinEntry enter pin for rank "<rank>"
    And DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | not displayed |
    Examples:
      | rank    |
      | MAS     |
      | A/M     |
      | C/O     |
#      | A C/O   |
#      | 2/O     |
#      | A 2/O   |
#      | 3/O     |
#      | A 3/O   |
#      | 4/O     |
#      | A 4/O   |
#      | 5/O     |
#      | D/C     |
#      | BOS     |
#      | A/B     |
#      | O/S     |
#      | SAA     |
#      | C/E     |
#      | A C/E   |
#      | 2/E     |
#      | A 2/E   |
#      | 3/E     |
#      | A 3/E   |
#      | CGENG   |
#      | 4/E     |
#      | A 4/E   |
#      | 5/E     |
#      | T/E     |
#      | E/C     |
#      | ETO     |
#      | ELC     |
#      | ETR     |
#      | PMN     |
#      | FTR     |
#      | OLR     |
#      | WPR     |
#      | CCK     |
#      | 2CK     |
#      | STWD    |
#      | FSTO    |
#      | RDCRW   |
#      | SPM     |

  @test5
  Scenario: Verify the multiple crew assist messages are displayed on the Dashboard
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    And Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:02 |
    And Wearable service link crew member
      | rank |        mac        |
      | C/E  | 00:00:00:00:00:03 |
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    And Wearable service send crew assist alerts
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:02 |
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | C/E  | 00:00:00:00:00:03 |

  @test6
  Scenario: Verify the crew members is able to dismissed multiple crew assist messages
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    And Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:02 |
    And Wearable service link crew member
      | rank |        mac        |
      | C/E  | 00:00:00:00:00:03 |
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    And Wearable service send crew assist alerts
    When Wearable service dismiss crew assist alerts
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | not displayed |

  @test7
  Scenario: Verify another alerts are shown when one was closed by crew
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    And Wearable service link crew member
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:02 |
    And Wearable service link crew member
      | rank |        mac        |
      | C/E  | 00:00:00:00:00:03 |
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    And Wearable service send crew assist alerts
    And DashboardAlert click Acknowledge button
      | rank |
      | 2/O  |
    Then PinEntry enter pin for rank "2/O"
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:02 |
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | C/E  | 00:00:00:00:00:03 |

  @test8
  Scenario: Verify alert is shown when approve canceled by crew
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    Then Wearable service send crew assist alerts
    And DashboardAlert click Acknowledge button
      | rank |
      | 2/O  |
    When PinEntry click Cancel button
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |

  @test9
  Scenario: Verify crew isn't able to acknowledge by incorrect pin
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then Dashboard open dashboard page
    And Dashboard verify the local time
    Then Wearable service send crew assist alerts
    And DashboardAlert click Acknowledge button
      | rank |
      | 2/O  |
    When PinEntry enter invalid pin "1234"
    Then PinEntry should see error msg "Incorrect Pin, Please Enter Again"
    When PinEntry click Cancel button
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |

  @test10
  Scenario: Verify the crew assist alert is shown after refreshing page
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then Dashboard open dashboard page
    And Wearable service send crew assist alerts
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |
    And Browser refresh page
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |

  @test11 #second window doesn't see  old alerts
  Scenario: Verify the crew assist alert is shown in another window
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then Dashboard open dashboard page
    And Wearable service send crew assist alerts
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |
    And Dashboard open new window dashboard page
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |

  @test12 #second window doesn't see  old alerts
  Scenario: Verify the crew assist alert is disappear in both windows after dismissing
    When Wearable service dismiss crew assist alerts
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then Dashboard open dashboard page
    And Wearable service send crew assist alerts
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |
    Then Dashboard open new window dashboard page
    And DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    When Wearable service dismiss crew assist alerts
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | not displayed |
    And Browser switch to window 1
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | not displayed |

  @test9999999
  Scenario: Smoke
    Then Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac       |
      | O/S  | 00:00:00:00:00:01|
    And Wearable service link crew member
      | rank |        mac       |
      | 2/O  | 00:00:00:00:00:02|
    Given Dashboard open dashboard page
    And Wearable service send crew assist alerts
    Then DashboardAlert verify crew assist alert data
      | rank |
      | O/S  |
    Then DashboardAlert click Acknowledge button
      | rank |
      | 2/O  |
    And PinEntry enter pin for rank "2/O"
    And CommonSection sleep for "2" sec
    Then Wearable service unlink all wearables



  # Background: Given I clear wearable history and active users

  Scenario: Verify alert dialog popup display crew rank,name and location
    Given I clear wearable history and active users
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    Then I should see crew assist popup display crew rank,name and location on dashboard
    And I unlink all crew from wearable

  # @skip
  # Scenario: Verify location pin is red
  #   Given I launch sol-x portal
  #   When I trigger crew assist from wearable
  #   Then I should crew location indicator is red
  #   And I unlink all crew from wearable

  Scenario: Verify multiple dialog show on screen
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    When I trigger second crew assist
    And I should see two crew assist dialogs on dashboard
    And I unlink all crew from wearable

  # @skip
  # Scenario: Verify crew assist dialog display current time ?

  # @skip
  # Scenario: Verify map location pin turn red after triggering crew assist ?

  # @skip
  # Scenario: Verify active permits display on crew assists dialog box

  # @skip
  # Scenario: Versify pending permits display on crew assists dialog box

  Scenario: Verify crew assist dialog should not display on refresh after acknowledging
    Given I launch sol-x portal
    And I trigger crew assist from wearable
    And I acknowledge the assistance with pin 1111
    Then I should not see crew assist dialog
    When I refresh the browser
    Then I should not see crew assist dialog
    And I unlink all crew from wearable

  Scenario: Verify crew assist dialog still display after cancel from pin screen
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    And I acknowledge the assistance with invalid pin 1234
    And I dismiss enter pin screen
    Then I should see crew assist popup display crew rank,name and location on dashboard
    And I unlink all crew from wearable

  Scenario: Verify crew assist dialog cannot be dismissed with invalid pin
    Given I launch sol-x portal
    When I trigger crew assist from wearable
    And I acknowledge the assistance with invalid pin 1234
    Then I should see invalid pin message
    And I unlink all crew from wearable

  Scenario: Verify crew assist dialog dismiss from all other tablet after acknowledge
    Given I launch sol-x portal
    And I launch sol-x portal on another tab
    When I trigger crew assist from wearable
    And I acknowledge the assistance with pin 8383
    Then I should see crew assist dialog dismiss in both tab
    And I unlink all crew from wearable

  Scenario: Verify crew can dismiss from multiple browser after dismiss from wearable
    Given I launch sol-x portal
    And I launch sol-x portal on another tab
    When I trigger crew assist from wearable
    And I dismiss crew assist from wearable
    Then I should see crew assist dialog dismiss in both tab
    And I unlink all crew from wearable
