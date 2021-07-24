@section3BDRA
Feature: Section3BDRA
  As a ...
  I want to ...
  So that ...

  Scenario: Verify last assessment is pre-populated
    Given I change ship local time to +8 GMT
    When I submit permit submit_enclose_space_entry via service with 9015 user and set to active state
    And I launch sol-x portal without unlinking wearable
    And I click on active filter
    And I review and withdraw permit with A/M rank
    And I submit permit for termination
    And I sign with valid A/M rank
    And I click on back to home
    And I click on pending withdrawal filter
    And I terminate the permit with MAS rank via Pending Withdrawal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 3b
    Then I should see dra number and last assessment date populated

  Scenario: Verify Work site inspection Yes name list display all crews
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 3b
    Then I should see work site inspected by crew member list display all crews

  Scenario Outline: Verify method name is populated
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3b
    Then I should see method description <method_desc> populated

    Examples:
      | level_one_permit                      | level_two_permit                                                  | method_desc                                                                                       |
      | Critical Equipment Maintenance        | Maintenance on Fire Detection Alarm System                        | Standard Procedure for Maintenance on Fire Detection Alarm System                                 |
      | Cold Work                             | Cold Work - Connecting and Disconnecting Pipelines                | Standard procedures for connecting and disconnecting pipelines                                    |
      | Hot Work                              | Hot Work Level-2 in Designated Area                               | General / Standard Hot Work Procedure                                                             |
      | Personnel Transfer By Transfer Basket | Personnel Transfer By Transfer Basket                             | Standard procedures for Personnel Transfer by Transfer Basket                                     |
      | Enclosed Spaces Entry                 | Enclosed Spaces Entry                                             | General procedures for Enclosed Space Entry                                                       |
      | Underwater Operations                 | Underwater Operation at night or concurrent with other operations | Standard/General procedures for Underwater Operation at night or concurrent with other operations |

  Scenario: Verify By: Master display after clicking Yes on is DRA sent to office
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3b
    Then I should see By: Master after clicking Yes on Is DRA sent to office

  Scenario: Verify By: Master is not display after clicking No on is DRA sent to office
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3b
    Then I should not see By: Master after clicking No on Is DRA sent to office

  Scenario: Verify crew drop down is displayed after clicking Yes on inspection carried out
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3b
    Then I should see crew drop down list after clicking Yes on Inspection carried out
    And I should see crew list populated

  Scenario: Verify crew drop down is not displayed after clicking No on inspection carried out
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Fixed Fire Fighting System permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 3b
    Then I should not see crew drop down list after clicking No on Inspection carried out