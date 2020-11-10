@section3ADRA
Feature: Section3ADRA
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify edit risk button

  Scenario: Verify permit number date and time is pre-filled in section 3a
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    Then I should see DRA number,Date and Time populated
    And I tear down created form

  Scenario Outline: Verify risk matrix meets criteria for low risk for without applying measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for without applying measure
    Then I should see risk as low risk
    And I should see correct risk evaluation medium,low,low

    Examples:
      | likelihood | consequence |
      | 1          | 1           |
      | 1          | 2           |
      | 1          | 3           |
      | 1          | 4           |
      | 2          | 1           |
      | 2          | 2           |
      | 2          | 3           |
      | 3          | 1           |
      | 3          | 2           |
      | 4          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for medium risk for without applying measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for without applying measure
    Then I should see risk as medium risk
    And I should see correct risk evaluation medium,low,low

    Examples:
      | likelihood | consequence |
      | 2          | 4           |
      | 3          | 3           |
      | 1          | 5           |
      | 4          | 2           |
      | 5          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for high risk for without applying measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for without applying measure
    Then I should see risk as high risk
    And I should see correct risk evaluation high,low,low

    Examples:
      | likelihood | consequence |
      | 2          | 5           |
      | 3          | 5           |
      | 3          | 4           |
      | 4          | 4           |
      | 4          | 3           |
      | 5          | 2           |
      | 5          | 3           |

  Scenario Outline: Verify risk matrix meets criteria for very high risk for without applying measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for without applying measure
    Then I should see risk as very high risk
    And I should see correct risk evaluation very high,low,low

    Examples:
      | likelihood | consequence |
      | 4          | 5           |
      | 5          | 5           |
      | 5          | 4           |

  Scenario Outline: Verify risk matrix meets criteria for low risk for existing control measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for existing control measure
    Then I should see risk as low risk
    And I should see correct risk evaluation medium,low,low

    Examples:
      | likelihood | consequence |
      # | 1          | 1           |
      # | 1          | 2           |
      # | 1          | 3           |
      | 1          | 4           |
  # # | 2          | 1           |
  # # | 2          | 2           |
  # | 2          | 3           |
  # # | 3          | 1           |
  # # | 3          | 2           |
  # | 4          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for medium risk for existing control measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for existing control measure
    Then I should see risk as medium risk
    And I should see correct risk evaluation medium,medium,medium

    Examples:
      | likelihood | consequence |
      # | 2          | 4           |
      # | 3          | 3           |
      | 1          | 5           |
  # | 4          | 2           |
  # | 5          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for high risk for existing control measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for existing control measure
    Then I should see risk as high risk
    And I should see correct risk evaluation medium,high,high

    Examples:
      | likelihood | consequence |
      | 2          | 5           |
  #     # | 3          | 5           |
  #     # | 3          | 4           |
  #     | 4          | 4           |
  #     # | 4          | 3           |
  #     | 5          | 2           |
  # # | 5          | 3           |

  Scenario Outline: Verify risk matrix meets criteria for very high risk for existing control measure
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for existing control measure
    Then I should see risk as very high risk
    And I should see correct risk evaluation medium,very high,very high

    Examples:
      | likelihood | consequence |
      # | 4          | 5           |
      # | 5          | 5           |
      | 5          | 4           |

  Scenario Outline: Verify risk matrix meets criteria for low risk for additional hazard
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I click on View Edit Hazard
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for additional hazard
    Then I should see risk as low risk
    And I should see correct risk evaluation medium,low,low

    Examples:
      | likelihood | consequence |
      # | 1          | 1           |
      # | 1          | 2           |
      # | 1          | 3           |
      | 1          | 4           |
  # | 2          | 1           |
  # | 2          | 2           |
  # | 2          | 3           |
  # | 3          | 1           |
  # | 3          | 2           |
  # | 4          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for medium risk for additional hazard
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I click on View Edit Hazard
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for additional hazard
    Then I should see risk as medium risk
    And I should see correct risk evaluation medium,low,medium

    Examples:
      | likelihood | consequence |
      # | 2          | 4           |
      # | 3          | 3           |
      | 1          | 5           |
  # | 4          | 2           |
  # | 5          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for high risk for additional hazard
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I click on View Edit Hazard
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for additional hazard
    Then I should see risk as high risk
    And I should see correct risk evaluation medium,low,high

    Examples:
      | likelihood | consequence |
      # | 2          | 5           |
      # | 3          | 5           |
      # | 3          | 4           |
      # | 4          | 4           |
      # | 4          | 3           |
      | 5          | 2           |
  # | 5          | 3           |

  Scenario Outline: Verify risk matrix meets criteria for very high risk for additional hazard
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I click on View Edit Hazard
    And I toggle likelihood <likelihood> and <consequence> consequence matrix for additional hazard
    Then I should see risk as very high risk
    And I should see correct risk evaluation medium,low,very high

    Examples:
      | likelihood | consequence |
      # | 4          | 5           |
      # | 5          | 5           |
      | 5          | 4           |

  Scenario: Verify evaluation risk matrix meets criteria for additional hazard
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I toggle likelihood 5 and 5 consequence matrix for existing control measure
    And I should see correct risk evaluation medium,very high,very high
    And I toggle likelihood 1 and 1 consequence matrix for additional hazard follow through
    Then I should see correct risk evaluation medium,very high,low

  Scenario: Verify added additional hazard is saved
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I click on View Edit Hazard
    And I add a additional hazard
    Then I should see additional hazard data save

  Scenario: Verify delete risk button
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Anchor permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I delete a hazard
    Then I should see hazard deleted

  Scenario: Verify user can add new hazard
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    # And I set maintenance during more than 2 hours
    And I navigate to section 3a
    And I add a new hazard
    Then I should see added new hazard