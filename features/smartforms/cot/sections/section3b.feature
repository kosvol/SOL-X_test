@section3b
Feature: Section 3B: DRA - Checks & Measures

  Scenario: Verify Work site inspection Yes name list display all crews
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Space Entry"
    And CommonSection navigate to "Section 3B"
    When Section3B answer work site inspection carried out "yes"
    Then Section3B "should" see inspection crew list

  Scenario: Verify crew drop down is not displayed after clicking No on inspection carried out
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    When CommonSection navigate to "Section 3B"
    When Section3B answer work site inspection carried out "no"
    Then Section3B "should not" see inspection crew list

  Scenario Outline: Verify method name is populated for level1 permit
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    When CommonSection navigate to "Section 3B"
    Then Section3B verify method description "<method_desc>"
    Examples:
      | level_one_permit                      | method_desc                                                   |
      | Personnel Transfer by Transfer Basket | Standard procedures for Personnel Transfer by Transfer Basket |
      | Enclosed Space Entry                  | General procedures for Enclosed Space Entry                   |

  Scenario Outline: Verify method name is populated for level2 permit
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<level_one_permit>"
    And FormPrelude select level2 "<level_two_permit>"
    When CommonSection navigate to "Section 3B"
    Then Section3B verify method description "<method_desc>"
    Examples:
      | level_one_permit               | level_two_permit                                                  | method_desc                                                                                       |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                        | Standard Procedure for Maintenance on Fire Detection Alarm System                                 |
      | Cold Work                      | Cold Work - Connecting and Disconnecting Pipelines                | Standard procedures for connecting and disconnecting pipelines                                    |
      | Hot Work                       | Hot Work Level-2 in Designated Area                               | General / Standard Hot Work Procedure                                                             |
      | Underwater Operations          | Underwater Operation at night or concurrent with other operations | Standard/General procedures for Underwater Operation at night or concurrent with other operations |


  Scenario Outline: Verify By: Master display answer on is DRA sent to office
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    And CommonSection navigate to "Section 3B"
    When Section3B answer DRA been sent to the office for review as "<answer>"
    Then Section3B "<expected>" see By: Master displayed
    Examples:
      | answer | expected   |
      | yes    | should     |
      | no     | should not |