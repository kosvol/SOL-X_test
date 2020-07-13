@section3BDRA
Feature: Section3BDRA
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify method name is populated
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1
    And I navigate to section 3b
    Then I should see method description <method_desc> populated

    Examples:
      | level_one_permit               | level_two_permit                          | method_desc                                               |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System | Standard procedure for Maintenance on Emergency Fire Pump |
  # | Cold Work                             | Maintenance on Fixed Fire Fighting System | Standard procedure for Cleaning Up of Spills                                                          |
  # | Hot Work                              | Maintenance on Fixed Fire Fighting System | General / Standard Hot Work Procedure                                                                 |
  # | Personnel Transfer by Transfer Basket | Maintenance on Fixed Fire Fighting System | Standard procedure for Personnel Transfer by Transfer Basket                                          |
  # | Enclosed Space Entry                  | Maintenance on Fixed Fire Fighting System | General procedure for Enclosed Space Entry                                                            |
  # | Underwater Operation                  | Maintenance on Fixed Fire Fighting System | Standard/General procedures for Simultaneous underwater operation during daytime with other operation |


  Scenario: Verify By: Master display after clicking Yes on is DRA sent to office
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill up section 1
    And I navigate to section 3b
    Then I should see By: Master after clicking Yes on Is DRA sent to office

  Scenario: Verify By: Master is not display after clicking No on is DRA sent to office
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill up section 1
    And I navigate to section 3b
    Then I should not see By: Master after clicking No on Is DRA sent to office

  Scenario: Verify crew drop down is displayed after clicking Yes on inspection carried out
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill up section 1
    And I navigate to section 3b
    Then I should see crew drop down list after clicking Yes on Inspection carried out
    And I should see crew list populated

  Scenario: Verify crew drop down is not displayed after clicking No on inspection carried out
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill up section 1
    And I navigate to section 3b
    Then I should not see crew drop down list after clicking No on Inspection carried out