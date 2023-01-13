@crew-assist
Feature: CrewAssist

    Background:
    Given DB service clear couch table
      | db_type | table     |
      | edge    | alerts    |
      | edge    | wearables |
    And Wearable create new 3 wearables

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

  Scenario Outline: Verify the 'Crew Assist Acknowledger' is able to acknowledge
    Given Wearable service unlink all wearables
    Then Wearable service link crew member
      | rank |        mac        |
      | 3/O  | 00:00:00:00:00:05 |
    And Dashboard open dashboard page
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
      | A C/O   |
      | 2/O     |
      | A 2/O   |
      | 3/O     |
      | A 3/O   |
      | 4/O     |
      | A 4/O   |
      | 5/O     |
      | D/C     |
      | BOS     |
      | A/B     |
      | O/S     |
      | SAA     |
      | C/E     |
      | A C/E   |
      | 2/E     |
      | A 2/E   |
      | 3/E     |
      | A 3/E   |
      | CGENG   |
      | 4/E     |
      | A 4/E   |
      | 5/E     |
      | T/E     |
      | E/C     |
      | ETO     |
      | ELC     |
      | ETR     |
      | PMN     |
      | FTR     |
      | OLR     |
      | WPR     |
      | CCK     |
      | 2CK     |
      | STWD    |
      | FSTO    |
      | RDCRW   |
      | SPM     |

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

  Scenario: Verify other alerts are shown when one was closed by crew member
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
    Then PinEntry enter pin for rank "MAS"
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | C/O  | 00:00:00:00:00:02 |
    Then DashboardAlert verify crew assist alert data
      | rank |        mac        |
      | C/E  | 00:00:00:00:00:03 |
#Test below can has a problem with step 'click Cancel button and back to dashboard'
  Scenario: Verify alert is shown when acknowledge canceled by crew member
    Given Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac        |
      | 2/O  | 00:00:00:00:00:01 |
    Then Dashboard open dashboard page
    Then Wearable service send crew assist alerts
    And DashboardAlert click Acknowledge button
      | rank |
      | 2/O  |
    When PinEntry click Cancel button
    Then DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |
#Test below can has a problem with step 'click Cancel button and back to dashboard'
  Scenario: Verify crew member isn't able to acknowledge by incorrect pin
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
#Test below can has periodically error - second window doesn't see old alerts (cache issue)
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
#Test below can has periodically error - second window doesn't see old alerts (cache issue)
  Scenario: Verify the crew assist alert is disappear in both windows after dismissing
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

  Scenario: Smoke test
    Then Wearable service unlink all wearables
    And Wearable service link crew member
      | rank |        mac       |
      | 2/O  | 00:00:00:00:00:01|
    And Wearable service link crew member
      | rank |        mac       |
      | 3/O  | 00:00:00:00:00:02|
    And Wearable service link crew member
      | rank |        mac       |
      | C/O  | 00:00:00:00:00:03|
    Given Dashboard open dashboard page
    And Wearable service send crew assist alerts
    Then DashboardAlert verify crew assist alert data
      | rank |
      | 2/O  |
    Then DashboardAlert verify crew assist alert data
      | rank |
      | 3/O  |
    Then DashboardAlert verify crew assist alert data
      | rank |
      | C/O  |
    And Dashboard open new window dashboard page
    Then DashboardAlert verify crew assist alert data
      | rank |
      | 2/O  |
    Then DashboardAlert verify crew assist alert data
      | rank |
      | 3/O  |
    Then DashboardAlert verify crew assist alert data
      | rank |
      | C/O  |
    And Browser refresh page
    And DashboardAlert click Acknowledge button
      | rank |
      | 2/O  |
    Then PinEntry enter pin for rank "MAS"
    And Browser switch to window 1
    And DashboardAlert click Acknowledge button
      | rank |
      | 3/O  |
    Then PinEntry enter pin for rank "MAS"
    And DashboardAlert click Acknowledge button
      | rank |
      | C/O  |
    When PinEntry enter invalid pin "1234"
    Then PinEntry should see error msg "Incorrect Pin, Please Enter Again"
    And PinEntry click Cancel button
    And DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | displayed     |
    Then Wearable service dismiss crew assist alerts
    And DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | not displayed |
    And Browser switch to window 2
    And DashboardAlert verify alert availability
      | alert       | availability  |
      | Crew Assist | not displayed |

    # TODO: clear comments after all issues was resolved by new deployment
