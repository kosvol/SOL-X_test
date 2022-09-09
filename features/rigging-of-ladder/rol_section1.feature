@rol_section1
Feature: RoL Section 1: Detailed Risk Assessments

  Scenario: Verify DRA details are pre-filled
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    Then RoLSectionOne verify DRA details

  Scenario: Verify all section 1 data is displayed
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    Then RoLSectionOne verify section 1 data

  Scenario: Verify there only save & next button in section 1
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    Then RoLSectionOne should not see previous button
    Then RoLSectionOne verify next button is "Save & Next"
