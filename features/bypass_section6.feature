@bypass-section6
Feature: To bypass section 1 to 6
  As a ...
  I want to ...
  So that ...

  @xx
  Scenario Outline: To verify update gas reading button
    Given I submit permit <location> via service with 1212 user

    Examples:
      | permit_types          | location                   |
      | Enclosed Spaces Entry | submit_enclose_space_entry |
# | Use of Non-Intrinsically Safe Camera                                            | non_intrinsical_camera     |
# | Hot Work Level-2 outside E/R (Ballast Passage)                                  | outside_er_ballast         |
# | Hot Work Level-2 outside E/R (Loaded Passage)                                   | outside_er_loaded          |
# | Hot Work Level-2 outside E/R Workshop but within E/R (Loaded & Ballast Passage) | out_er_but_within_er       |
# | Hot Work Level-2 in Designated Area                     | in_er_loaded_and_ballast   |
# | Hot Work Level-1 (Loaded & Ballast Passage)                                     | level_1_loaded_and_ballast |

# Scenario Outline: To verify OA permit

# Scenario Outline: To verify non-OA permit
