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

# Scenario: Verify location pin turn red after triggering crew assist

# Scenario: Verify location pin turn green below 30s

# Scenario: Verify location pin turn yellow after 30s

# Scenario: Verify crew latest location is updated on crew listing

# Scenario: Verify crew pin is shown after tapping on view pin

# Scenario: Verify total crew count and vessel name

# @manual
# Scenario: Verify total crew list count match inactive user count and COMPASS system

# @manual
# Scenario: Verify Email notification sent to the assign crew

# @manual
# Scenario: Verify Crew to receive pin by email 2 weeks before boarding

# @manual
# Scenario: Verify adhoc crew is added the next day T+1
