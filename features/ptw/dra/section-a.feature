@dra-section-a
Feature: VerifyDRA
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify page 1 major hazards content
    # Given I launch sol-x portal
    When I create a <permit> permit
    # And I navigate to Section 3A of DRA
    # Then I should see a list of default major hazards
    # And I should see a default list of likelihood rating
    # And I should see a default list of consequence rating
    # And I should see default risk rating for each major hazard <rating>
    # And I should see default evaluated residual risk <erisk>

    Examples:
      | permit                                                                |
      | Underwater Operations at Night                                        |
      | Underwater Operation during daytime without any simultenous operation |
      | Hot Work Level - 2 outside ER (Ballast Passage)                       |
      | Hot Work Level - 2 outside ER (Loaded & Ballast Passage)              |
      | Hot Work Level - 2 in Designated Area                                 |
      | Hot Work Level - 1 (Loaded & Ballast Passage)                         |
      | Working Aloft Overside                                                |
      | Use of Non-Intrinsically Safe Camera                                  |
      | Work on pressure pipelines pressure vessels                           |
      | Personnel Transfer by Transfer Basket                                 |
      | Helicopter Operation                                                  |
      | Use of Portable Power Tools                                           |
      | Use of ODME on manual mode                                            |
      | Working on Elect Equip                                                |
      | Use of Hydroblaster                                                   |
      | Maint on Emergency Generator                                          |
      | Maint on Emergency Fire Pump                                          |
      | Maint on Fixed Fire Fighting System                                   |
      | Maint on Lifeboat Engine                                              |
      | Maint on Anchor                                                       |
      | Maint on Radio Battery                                                |
      | Maint on Fire Detection Alarm System                                  |
      | Maint on Rrm Gas Detect Alarm Sys                                     |
      | Maint Emergency Switch Engine                                         |
      | Maint Main Propulsion                                                 |
      | Maint on Boiler and GE                                                |
      | Maint on Oil Mist Detector Monitoring Sys                             |
      | Maint Fuel Lub Oil Tank                                               |
      | Maint on magnetic compass                                             |
      | Maint on Life Boats and Davits                                        |
      | Maint on Oily water Separator                                         |
      | Maint on oil discharge monitoring equip                               |
      | 39.CW Connecting and disconnecting pipelines                          |
      | 40.Removing and fitting of valves blanks spades or blinds             |
      | 41.CW Blanking & deblanking of pipelines and other openings           |
      | 42.Working on Closed Electrical Equipment and Circuits                |
      | 43.CW Cleaning up of spills                                           |
      | 44.CW Working in hazardous or dangerous area                          |
      | 45.Maint work on machinery                                            |
      | 46.RIGGING OF GANGWAY & PILOT LADDER                                  |
      | 47.Working on deck during heavy weather                               |
      | 48.Underwater Sim operation during daytime with other operation       |


# Scenario: Verify identified hazards contents
#   Given I launch sol-x portal
#   When I create a Underwater Operations at Night permit
#   And I navigate to Section 3A of DRA
#   And I click on edit hazards
#   Then I should see a list of default identified hazards
#   And I should see default existing control measure likelihood rating
#   And I should see default existing control measure consequence rating
#   And I should see default existing control measure risk rating
#   And I should see default existing control measures mitgation

#   And I should see default aditional control measure likelihood rating
#   And I should see default aditional control measure consequence rating
#   And I should see default aditional control measure risk rating
#   And I should see default aditional control measures mitgation

######## GENERAL one off check #########

# Scenario: Verify risk matrix change to high, medium, high

# Scenario: Verify pending approval

# Scenario: Verify terminated

# Scenario: Verify update needed