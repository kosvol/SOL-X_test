@rol_section2
Feature: RoL Section 2: Checklist

  Scenario: Verify Checklist details are pre-filled
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    And CommonSection click Save & Next
    Then RoLSectionTwo verify checklist details

  Scenario: Verify all section 2 data is displayed
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    And CommonSection click Save & Next
    Then RoLSectionTwo verify section 2 data
    And RoLSectionTwo verify checklist warning box

  Scenario: Verify Description of boarding arrangement dropdown input fields are correct
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    When FormPrelude select level1 "Rigging of Gangway & Pilot Ladder"
    And CommonSection click Save & Next
    Then RoLSectionTwo verify dropdown for Description of boarding arrangement
      | Port Pilot Ladder            |
      | Starboard Pilot Ladder       |
      | Port Combination Ladder      |
      | Starboard Combination Ladder |
      | Port Gangway                 |
      | Starboard Gangway            |
      | MOT                          |