@section3a
Feature: Section 3A: DRA - Method & Hazards

  Scenario: Verify permit number date and time is pre-filled in section 3a
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Enclosed Spaces Entry"
    When CommonSection navigate to "Section 3A"
    Then Section3A verify answers


  Scenario Outline: Verify risk matrix meets criteria for low risk for without applying measure
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Without Applying Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected |
      | Without Applying Measures | Low Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Low Risk       | Low Risk      |
    Examples:
      | likelihood | consequence |
      | 1          | 1           |
      | 1          | 4           |
      | 2          | 1           |
      | 2          | 3           |
      | 3          | 1           |
      | 3          | 2           |

  Scenario Outline: Verify risk matrix meets criteria for medium risk for without applying measure
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Without Applying Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected    |
      | Without Applying Measures | Medium Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Low Risk       | Low Risk      |
    Examples:
      | likelihood | consequence |
      | 2          | 4           |
      | 3          | 3           |
      | 1          | 5           |
      | 4          | 2           |
      | 5          | 1           |


  Scenario Outline: Verify risk matrix meets criteria for high risk for without applying measure
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Without Applying Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected  |
      | Without Applying Measures | High Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | High Risk        | Low Risk       | Low Risk      |
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
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Without Applying Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected       |
      | Without Applying Measures | Very High Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Very High Risk   | Low Risk       | Low Risk      |
    Examples:
      | likelihood | consequence |
      | 4          | 5           |
      | 5          | 5           |
      | 5          | 4           |


  Scenario Outline: Verify risk matrix meets criteria for low risk for existing control measure
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Existing Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected |
      | Existing Control Measures | Low Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Low Risk       | Low Risk      |
    Examples:
      | likelihood | consequence |
      | 1          | 1           |
      | 1          | 4           |
      | 2          | 1           |
      | 2          | 3           |
      | 3          | 1           |
      | 3          | 2           |
      | 4          | 1           |


  Scenario Outline: Verify risk matrix meets criteria for medium risk for existing control measure
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Existing Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected    |
      | Existing Control Measures | Medium Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Medium Risk    | Medium Risk   |
    Examples:
      | likelihood | consequence |
      | 2          | 4           |
      | 1          | 5           |
      | 5          | 1           |


  Scenario Outline: Verify risk matrix meets criteria for high risk for existing control measure
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Existing Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected  |
      | Existing Control Measures | High Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | High Risk      | High Risk     |
    Examples:
      | likelihood | consequence |
      | 2          | 5           |
      | 3          | 5           |
      | 4          | 4           |
      | 5          | 3           |


  Scenario Outline: Verify risk matrix meets criteria for very high risk for existing control measure
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood   | consequence   |
      | Existing Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                      | expected       |
      | Existing Control Measures | Very High Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk  |
      | Medium Risk      | Very High Risk | Very High Risk |
    Examples:
      | likelihood | consequence |
      | 4          | 5           |
      | 5          | 5           |


  Scenario Outline: Verify risk matrix meets criteria for low risk for additional hazard
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                        | likelihood   | consequence   |
      | Additional Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                        | expected |
      | Additional Control Measures | Low Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Low Risk       | Low Risk      |
    Examples:
      | likelihood | consequence |
      | 1          | 4           |
      | 2          | 3           |
      | 3          | 2           |
      | 4          | 1           |

  Scenario Outline: Verify risk matrix meets criteria for medium risk for additional hazard
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                        | likelihood   | consequence   |
      | Additional Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                        | expected    |
      | Additional Control Measures | Medium Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Low Risk       | Medium Risk   |
    Examples:
      | likelihood | consequence |
      | 1          | 5           |


  Scenario Outline: Verify risk matrix meets criteria for high risk for additional hazard
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                        | likelihood   | consequence   |
      | Additional Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                        | expected  |
      | Additional Control Measures | High Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Low Risk       | High Risk     |
    Examples:
      | likelihood | consequence |
      | 2          | 5           |
      | 3          | 5           |
      | 4          | 4           |
      | 5          | 3           |


  Scenario Outline: Verify risk matrix meets criteria for very high risk for additional hazard
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                        | likelihood   | consequence   |
      | Additional Control Measures | <likelihood> | <consequence> |
    And DRA verify risk indicator
      | type                        | expected       |
      | Additional Control Measures | Very High Risk |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk  |
      | Medium Risk      | Low Risk       | Very High Risk |
    Examples:
      | likelihood | consequence |
      | 5          | 4           |


  Scenario: Verify evaluation risk matrix meets criteria for additional hazard
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA edit hazards
      | type                      | likelihood | consequence |
      | Existing Control Measures | 5          | 5           |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk  |
      | Medium Risk      | Very High Risk | Very High Risk |
    And DRA edit hazards
      | type                        | likelihood | consequence |
      | Additional Control Measures | 1          | 1           |
    Then DRA verify evaluation of residual risk
      | without_measures | after_measures | residual_risk |
      | Medium Risk      | Very High Risk | Low Risk      |

  @ww
  Scenario: Verify added additional hazard is saved
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA add additional measures
    And DRA Save DRA
    And Section3A click edit hazards
    Then DRA should see additional measures
  @ww
  Scenario: Verify delete risk button
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA delete a hazard
    And DRA Save DRA
    And DRA should see a hazard is deleted


  Scenario: Verify user can add new hazard
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Anchor"
    And CommonSection navigate to "Section 3A"
    And Section3A click edit hazards
    And DRA add extra hazard
    And DRA Save DRA
    And Section3A click edit hazards
    Then DRA should see extra hazard
