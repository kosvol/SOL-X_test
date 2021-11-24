@section3c
Feature: Section 3C: DRA - Team Members

  Scenario Outline: Verify ra user is automatically selected
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "<rank>"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    When CommonSection navigate to "Section 3C"
    Then Section3C should see dra member "<rank>"
    Examples:
      | rank |
      | C/O  |
      | 2/O  |
      | 3/O  |
      | C/E  |
      | 2/E  |

  Scenario: Verify user can select additional dra team member
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    And CommonSection navigate to "Section 3C"
    When Section3C select DRA member "MAS"
    And Section3C select DRA member "2/O"
    Then Section3C should see list dra members
      | MAS |
      | C/O |
      | 2/O |

  Scenario: Verify user can remove specific DRA team member via cross
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    And CommonSection navigate to "Section 3C"
    When Section3C select DRA member "MAS"
    And Section3C select DRA member "2/O"
    And Section3C remove DRA member "C/O"
    Then Section3C should see list dra members
      | MAS |
      | 2/O |

  Scenario: Verify user can remove specific DRA team member via deselecting from menu
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    And CommonSection navigate to "Section 3C"
    When Section3C select DRA member "MAS"
    And Section3C select DRA member "C/O"
    Then Section3C should see list dra members
      | MAS |

  Scenario: Verify user selection stays selected after toggling through sections
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Critical Equipment Maintenance"
    And FormPrelude select level2 "Maintenance on Fixed Fire Fighting System"
    And CommonSection navigate to "Section 3C"
    When Section3C select DRA member "MAS"
    And Section3C select DRA member "2/O"
    Then Section3C should see list dra members
      | MAS |
      | C/O |
      | 2/O |
    And CommonSection click Previous
    And CommonSection sleep for "2" sec
    And CommonSection click Save & Next
    Then Section3C should see list dra members
      | MAS |
      | C/O |
      | 2/O |
    And CommonSection click Save & Next
    And CommonSection click Previous
    Then Section3C should see list dra members
      | MAS |
      | C/O |
      | 2/O |
