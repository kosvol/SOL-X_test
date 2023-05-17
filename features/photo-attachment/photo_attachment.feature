@add_photos
Feature: Photo Attachment: Add Photos

  Scenario Outline: Verify user can see the camera button in CREATED state
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading |
      | enclosed_spaces_entry | created       | no  | no          |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "2" sec
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "<section>"
    Then CommonSection "should" see camera button
    Examples:
      | section               |
      | Section 1             |
      | Section 2             |
      | Section 3A            |
      | Section 3B            |
      | Section 3C            |
      | Section 3D            |
      | Section 4A            |
      | Enclosed Spaces Entry |
      | Section 4B            |
      | Section 5             |
      | Section 6             |

  Scenario: Verify user cannot add more than 3 photos in CREATED state
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | created       | no  | no          | 2         |
    And SmartForms navigate to state page
      | type | state   |
      | ptw  | created |
    And CommonSection sleep for "2" sec
    And CreatedPTW click edit
    And PinEntry enter pin for rank "C/O"
    And CommonSection click camera button
    Then PhotoAttachment should see section header
    And PhotoAttachment verify photo count "2"
    And PhotoAttachment verify "2" photo limit warning before approval
    Then PhotoAttachment click Capture Photo button
    And PhotoAttachment click Add Photo button
    And PhotoAttachment verify photo count "3"
    And PhotoAttachment verify "3" photo limit warning before approval
    Then PhotoAttachment verify Capture Photo button is "disable"

  Scenario Outline: Verify user can see the camera button in APPROVAL_UPDATES_NEEDED state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              |
      | enclosed_spaces_entry | updates_needed | APPROVAL_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "<section>"
    Then CommonSection "should" see camera button
    Examples:
      | section               |
      | Section 1             |
      | Section 2             |
      | Section 3A            |
      | Section 3B            |
      | Section 3C            |
      | Section 3D            |
      | Section 4A            |
      | Enclosed Spaces Entry |
      | Section 4B            |
      | Section 5             |
      | Section 6             |

  Scenario: Verify user cannot add more than 3 photos in APPROVAL_UPDATES_NEEDED state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status              | bfr_photo |
      | enclosed_spaces_entry | updates_needed | APPROVAL_UPDATES_NEEDED | 2         |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And PhotoAttachment click camera button
    And I sleep for 3 seconds
    And PhotoAttachment verify photo thumbnail is "2"
    Then PhotoAttachment verify "2" photo limit warning before approval
    And PhotoAttachment click Capture Photo button
    And PhotoAttachment click Add Photo button
    And PhotoAttachment verify photo thumbnail is "3"
    Then PhotoAttachment verify "3" photo limit warning before approval
    And PhotoAttachment verify Capture Photo button is "disable"

  Scenario: Verify user can only see the camera button in section 8 in ACTIVE state
    Given PermitGenerator create permit
      | permit_type         | permit_status | new_status |
      | hot_work_designated | active        | ACTIVE     |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 8"
    Then CommonSection "should" see camera button

  Scenario Outline: Verify user cannot see the camera button in other sections of ACTIVE state
    Given PermitGenerator create permit
      | permit_type         | permit_status | new_status |
      | hot_work_designated | active        | ACTIVE     |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "<section>"
    Then CommonSection "should not" see camera button
    Examples:
      | section                         |
      | Section 1                       |
      | Section 2                       |
      | Section 3A                      |
      | Section 3B                      |
      | Section 3C                      |
      | Section 3D                      |
      | Section 4A                      |
      | Hot Work Within Designated Area |
      | Section 4B                      |
      | Section 5                       |
      | Section 6                       |
      | Section 7                       |
      | Section 7B                      |

  Scenario: Verify user cannot add more than 3 photos in ACTIVE state
    Given PermitGenerator create permit
      | permit_type         | permit_status | new_status | aft_photo |
      | hot_work_designated | active        | ACTIVE     | 2         |
    And SmartForms navigate to state page
      | type | state  |
      | ptw  | active |
    And ActivePTW click View/Terminate button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 8"
    And PhotoAttachment click camera button
    And I sleep for 3 seconds
    And PhotoAttachment verify photo thumbnail is "2"
    Then PhotoAttachment verify "2" photo limit warning after approval
    And PhotoAttachment click Capture Photo button
    And PhotoAttachment click Add Photo button
    And PhotoAttachment verify photo thumbnail is "3"
    Then PhotoAttachment verify "3" photo limit warning after approval
    And PhotoAttachment verify Capture Photo button is "disable"

  Scenario: Verify user can only see the camera button in section 8 in ACTIVE_UPDATES_NEEDED state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status            |
      | enclosed_spaces_entry | updates_needed | ACTIVE_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 8"
    Then CommonSection "should" see camera button

  Scenario Outline: Verify user cannot see the camera button in other sections of ACTIVE_UPDATES_NEEDED state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status            |
      | enclosed_spaces_entry | updates_needed | ACTIVE_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "<section>"
    Then CommonSection "should not" see camera button
    Examples:
      | section               |
      | Section 1             |
      | Section 2             |
      | Section 3A            |
      | Section 3B            |
      | Section 3C            |
      | Section 3D            |
      | Section 4A            |
      | Enclosed Spaces Entry |
      | Section 4B            |
      | Section 5             |
      | Section 6             |
      | Section 7             |
      | Section 7B            |

  Scenario: Verify user cannot add more than 3 photos in ACTIVE_UPDATES_NEEDED state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status            | aft_photo |
      | enclosed_spaces_entry | updates_needed | ACTIVE_UPDATES_NEEDED | 2         |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 8"
    And PhotoAttachment click camera button
    And I sleep for 3 seconds
    And PhotoAttachment verify photo thumbnail is "2"
    Then PhotoAttachment verify "2" photo limit warning after approval
    And PhotoAttachment click Capture Photo button
    And PhotoAttachment click Add Photo button
    And PhotoAttachment verify photo thumbnail is "3"
    Then PhotoAttachment verify "3" photo limit warning after approval
    And PhotoAttachment verify Capture Photo button is "disable"

  Scenario: Verify user can only see the camera button in section 8 in Termination Updates Needed state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status                 |
      | enclosed_spaces_entry | updates_needed | TERMINATION_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 8"
    Then CommonSection "should" see camera button

  Scenario Outline: Verify user cannot see the camera button in other sections of Termination Updates Needed state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status                 |
      | enclosed_spaces_entry | updates_needed | TERMINATION_UPDATES_NEEDED |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "<section>"
    Then CommonSection "should not" see camera button
    Examples:
      | section               |
      | Section 1             |
      | Section 2             |
      | Section 3A            |
      | Section 3B            |
      | Section 3C            |
      | Section 3D            |
      | Section 4A            |
      | Enclosed Spaces Entry |
      | Section 4B            |
      | Section 5             |
      | Section 6             |
      | Section 7             |
      | Section 7B            |

  Scenario: Verify user cannot add more than 3 photos in ACTIVE_UPDATES_NEEDED state
    Given PermitGenerator create permit
      | permit_type           | permit_status  | new_status                 | aft_photo |
      | enclosed_spaces_entry | updates_needed | TERMINATION_UPDATES_NEEDED | 2         |
    And SmartForms navigate to state page
      | type | state          |
      | ptw  | updates-needed |
    And UpdatesNeededPTW click Edit/Update button
    And PinEntry enter pin for rank "C/O"
    And CommonSection navigate to "Section 8"
    And PhotoAttachment click camera button
    And I sleep for 3 seconds
    And PhotoAttachment verify photo thumbnail is "2"
    Then PhotoAttachment verify "2" photo limit warning after approval
    And PhotoAttachment click Capture Photo button
    And PhotoAttachment click Add Photo button
    And PhotoAttachment verify photo thumbnail is "3"
    Then PhotoAttachment verify "3" photo limit warning after approval
    And PhotoAttachment verify Capture Photo button is "disable"