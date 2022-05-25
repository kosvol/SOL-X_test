@section0
Feature: Section0 Form prelude

  Scenario: Verify user can see a list of available PTW form
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude verify level1 permit
      | Cold Work                                                                       |
      | Critical Equipment Maintenance                                                  |
      | Enclosed Space Entry                                                            |
      | Helicopter Operation                                                            |
      | Hot Work                                                                        |
      | Personnel Transfer by Transfer Basket                                           |
      | Rigging of Gangway & Pilot Ladder                                               |
      | Rotational Portable Power Tools                                                 |
      | Underwater Operations                                                           |
      | Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces |
      | Use of ODME in Manual Mode                                                      |
      | Work on Electrical Equipment and Circuits – Low/High Voltage                    |
      | Work on Pressure Pipeline/Vessels                                               |
      | Working Aloft / Overside                                                        |
      | Working on Deck During Heavy Weather                                            |

  Scenario Outline: Verify user see the correct second level permits
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "<permit>"
    And FormPrelude verify level2 list "<permit>"
    Examples:
      | permit                          |
      | Cold Work                       |
      | Critical Equipment Maintenance  |
      | Hot Work                        |
      | Rotational Portable Power Tools |
      | Underwater Operations           |

  Scenario: Verify user can navigate back to permit selection screen after navigating to level 2 permit
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude select level1 "Hot Work"
    And FormPrelude should see select permit type header