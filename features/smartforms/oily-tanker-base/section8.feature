@section8
Feature: Section 8: Task Status & EIC Normalisation
  Scenario: Verify section 8 Competent Person sign button is disable for read only user via pending termination state
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "MAS"
    Then Section8 verify RA signature section is hidden


  Scenario: Verify task commenced at should be populated with permit activated time
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW save time info
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    Then Section8 verify task commenced time


  Scenario Outline: Verify extra section8 questions for permits
    Given PermitGenerator create permit
      | permit_type   | permit_status | eic   | gas_reading | bfr_photo | aft_photo |
      | <permit_type> | active        | <eic> | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And Section8 verify extra questions
      | question_type   | eic   |
      | <question_type> | <eic> |
    Examples:
      | permit_type          | question_type | eic |
      | pressure_pipe_vessel | pipe          | yes |
      | pressure_pipe_vessel | pipe          | no  |
      | ele_equip_circuit    | electrical    | yes |
      | ele_equip_circuit    | electrical    | no  |
      | main_anchor          | critical      | yes |
      | main_anchor          | critical      | no  |


  Scenario: Verify section 8 EIC can only be signed by RA for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And Section8 click Submit For Termination
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |


  Scenario: Verify section 8 EIC can only be signed by Issue authority for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And Section8 click sign button for "Issuing Authorized"
    And PinEntry enter pin for rank "C/E"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And Section8 verify signed detail
      | rank | location_stamp        |
      | C/E  | No. 1 Cargo Tank Port |


  Scenario: Verify section 8 EIC can only be signed by EIC competent person for non oa permit
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | enclosed_spaces_entry | active        | yes | no          | 2         | 2         |
    And SmartForms open "active" page
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And Section8 click sign button for "Competent Person"
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And Section8 verify signed detail
      | rank | location_stamp        |
      | C/O  | No. 1 Cargo Tank Port |
