Feature: Generate various permit type
  Sample usage
  For EIC, Gas reading, you can choose "yes" or "no"
  For photo, if you don't want any photo, you could skip this column
  If you want to attach photo, just specify the amount in "bfr_photo", "aft_photo" columns

  @create_created
  Scenario: Create created permit
    Given PermitGenerator create permit
      | permit_type           | permit_status | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | created       | yes | yes         | 2         |

  @create_pending_approval
  Scenario: Create pending approval permit
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |

  @create_pending_office_approval
  Scenario: Create pending office approval permit
    Given PermitGenerator create permit
      | permit_type     | permit_status    | eic | gas_reading | bfr_photo |
      | use_safe_camera | pending_approval | yes | yes         | 2         |

  @create_active
  Scenario: Create active permit
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | hot_work_designated | active        | yes | no          | 2         | 2         |

  @create_pending_withdrawal
  Scenario: Create pending withdrawal permit
    Given PermitGenerator create permit
      | permit_type           | permit_status      | eic | gas_reading | aft_photo |
      | enclosed_spaces_entry | pending_withdrawal | no  | yes         | 2         |

  @create_withdrawn
  Scenario: Create withdrawn permit
    Given PermitGenerator create permit
      | permit_type         | permit_status | eic | gas_reading | bfr_photo | aft_photo |
      | hot_work_designated | withdrawn     | yes | yes         | 1         | 3         |

  @create_pre
  Scenario Outline: Create pre permit
    Given EntryGenerator create entry permit
      | entry_type | permit_status   |
      | pre        | <permit_status> |
    Examples:
      | permit_status            |
      | PENDING_OFFICER_APPROVAL |
      | APPROVED_FOR_ACTIVATION  |
      | ACTIVE                   |
      | CLOSED                   |

  @create_cre
  Scenario Outline: Create cre permit
    Given EntryGenerator create entry permit
      | entry_type | permit_status   |
      | cre        | <permit_status> |
    Examples:
      | permit_status            |
      | PENDING_OFFICER_APPROVAL |
      | APPROVED_FOR_ACTIVATION  |
      | ACTIVE                   |
      | CLOSED                   |
