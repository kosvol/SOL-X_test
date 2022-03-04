@section0
Feature: Section0 Form prelude

#  Scenario: Verify permits filter displaying the right counts on smartform screen
#    When I launch sol-x portal without unlinking wearable
#    Then I should see permits match backend results
#
#  Scenario Outline: Verify pending approval permit filter listing match counter in smart form
#    Given I launch sol-x portal without unlinking wearable
#    And I click on <filter> filter
#    Then I should see <filter> permits listing match counter
#
#    Examples:
#      | filter             |
#      | pending approval   |
#      | update needed      |
#      | active             |
#      | pending withdrawal |

  Scenario Outline: Verify only RA can create permit
    Given SmartForms open page
    And SmartForms click create permit to work
    When PinEntry enter pin for rank "<rank>"
    Then FormPrelude should see select permit type header
    Examples:
      | rank |
      | C/O  |
#      | A C/O |
      | 2/O  |
#      | A 2/O |
      | 3/O  |
#      | A 3/O |
      | C/E  |
#      | A C/E |
      | 2/E  |
#      | A 2/E |
#      | ETO   |

  Scenario Outline: Verify non RA cannot create permit
    Given SmartForms open page
    And SmartForms click create permit to work
    When PinEntry enter pin for rank "<rank>"
    Then PinEntry should see error msg "You Are Not Authorized To Perform That Action"
    Examples:
      | rank |
#      | A/M   |
      | MAS  |
      | 4/O  |
      | D/C  |
#      | A 3/E |
#      | A 4/E |
      | BOS  |
      | PMN  |
      | A/B  |
      | OLR  |

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