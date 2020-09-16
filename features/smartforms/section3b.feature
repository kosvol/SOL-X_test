@section3BDRA
Feature: Section3BDRA
  As a ...
  I want to ...
  So that ...

  # Scenario Outline: Verify All Permit - DRA section B - DRA number and Date of Last Assessment to be pre-populated - Created state
  # Scenario: Verify last assessment is pre-populated

  Scenario: Verify Work site inspection Yes name list display all crews
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    # And I fill up section 1
    And I navigate to section 3b
    Then I should see work site inspected by crew member list display all crews

  Scenario Outline: Verify method name is populated
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 9015
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 3b
    Then I should see method description <method_desc> populated

    Examples:
      | level_one_permit                      | level_two_permit                                                      | method_desc                                                                                           |
      | Critical Equipment Maintenance        | Maintenance on Fire Detection Alarm System                            | Standard Procedure for Maintenance on Fire Detection Alarm System                                     |
      | Cold Work                             | Cold Work - Connecting and Disconnecting Pipelines                    | Standard procedures for connecting and disconnecting pipelines                                        |
      | Hot Work                              | Hot Work Level-2 in Designated Area                                   | General / Standard Hot Work Procedure                                                                 |
      | Personnel Transfer By Transfer Basket | Personnel Transfer By Transfer Basket                                 | Standard procedures for Personnel Transfer by Transfer Basket                                         |
      | Enclosed Spaces Entry                 | Enclosed Spaces Entry                                                 | General procedures for Enclosed Space Entry                                                           |
      | Underwater Operations                 | Simultaneous underwater operation during daytime with other operation | Standard/General procedures for Simultaneous underwater operation during daytime with other operation |
  # to add more

  Scenario: Verify By: Master display after clicking Yes on is DRA sent to office
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3b
    Then I should see By: Master after clicking Yes on Is DRA sent to office

  Scenario: Verify By: Master is not display after clicking No on is DRA sent to office
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3b
    Then I should not see By: Master after clicking No on Is DRA sent to office

  Scenario: Verify crew drop down is displayed after clicking Yes on inspection carried out
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3b
    Then I should see crew drop down list after clicking Yes on Inspection carried out
    And I should see crew list populated

  Scenario: Verify crew drop down is not displayed after clicking No on inspection carried out
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I set maintenance during more than 2 hours
    And I navigate to section 3b
    Then I should not see crew drop down list after clicking No on Inspection carried out