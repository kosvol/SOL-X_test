@loa_cot_misc
Feature: Miscellaneous LOA

  @clear_form
  Scenario: clear form data
    Given DB service clear couch table
      | db_type | table                  |
      | edge    | forms                  |
      | cloud   | forms                  |
      | cloud   | office_approval_events |
      | edge    | gas_reader_entry       |
      | cloud   | gas_reader_entry       |
    And DB service clear postgres data

# TODO: system problem with create multi geofence at the same time
#  Scenario Outline: Verify geofence creator can create geofence
#    Given Dashboard open dashboard page
#    And Dashboard click Create GeoFence
#    When PinEntry enter pin for rank "<rank>"
#    Then GeoFence click cancel
#    Examples:
#      | rank  |
#      | MAS   |
#      | A/M   |
#      | C/O   |
#      | A C/O |
#      | 2/O   |
#      | A 2/O |
#      | 3/O   |
#      | A 3/O |
#      | C/E   |
#      | A C/E |
#      | 2/E   |
#      | A 2/E |
#      | 3/E   |
#      | A 3/E |
#      | 4/E   |
#      | A 4/E |
#      | ETO   |
#      | CGENG |


  Scenario Outline: Verify non geofence creator can not create geofence
    Given Dashboard open dashboard page
    And Dashboard click Create GeoFence
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank  |
      | 4/O   |
      | 5/O   |
      | 5/E   |
      | T/E   |
      | E/C   |
      | ETR   |
      | O/S   |
      | SAA   |
      | D/C   |
      | BOS   |
      | PMN   |
      | A/B   |
      | OLR   |
      | WPR   |
      | CCK   |

# to be implemented later
# gas reading acknowledger
# crew assist acknowledger
# work rest hour viewer