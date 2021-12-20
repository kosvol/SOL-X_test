Feature: SHELL requirement

  Scenario: Verify user can see a list of available PTW form
    Given SmartForms open page
    And SmartForms click create permit to work
    And PinEntry enter pin for rank "C/O"
    And FormPrelude verify level1 permit
      | Cold Work                                                                       |
      | Critical Equipment Maintenance                                                  |
      | Enclosed Spaces Entry                                                           |
      | Helicopter Operations                                                           |
      | Hot Work                                                                        |
      | Personnel Transfer By Transfer Basket                                           |
      | Rigging of Gangway & Pilot Ladder                                               |
      | Rotational Portable Power Tools                                                 |
      | Underwater Operations                                                           |
      | Use of non-intrinsically safe Camera outside Accommodation and Machinery spaces |
      | Use of ODME in Manual Mode                                                      |
      | Work on Electrical Equipment and Circuits – Low/High Voltage                    |
      | Work on Pressure Pipeline/Vessels                                               |
      | Working Aloft/Overside                                                          |
      | Working on Deck During Heavy Weather                                            |
      | Lifting Operation                                                               |