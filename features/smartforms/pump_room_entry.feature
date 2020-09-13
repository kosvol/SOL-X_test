Feature: PumpRoomEntry
  As a ...
  I want to ...
  So that ...


  Scenario Outline: Verify only RA can create PRE
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin <pin>
    Then I should see PRE landing screen
    And I tear down created form

    Examples:
      | rank                       | pin  |
            # | Addtional Master           | 9015 |
      | Chief Officer              | 8383 |
      | Additional Chief Officer   | 2761 |
      | Second Officer             | 6268 |
      | Additional Second Officer  | 7865 |
            # | Chief Engineer             | 8248 |
      | Additional Chief Engineer  | 2761 |
            # | Second Engineer            | 2523 |
      | Additional Second Engineer | 3030 |
            # | Electro Technical Officer  | 0856 |
      | 3/O                        | 0159 |
      | A 3/O                      | 2674 |


  Scenario Outline: Verify non RA cannot create permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin <pin>
    Then I should see not authorize error message

    Examples:
      | rank                      | pin  |
      | Master                    | 1111 |
      | Addtional Master          | 9015 |
      | Chief Engineer            | 8248 |
      | Second Engineer           | 2523 |
      | Electro Technical Officer | 0856 |
      | D/C                       | 2317 |
      | 3/E                       | 4685 |
      | A 3/E                     | 6727 |
      | 4/E                       | 1311 |
      | A 4/E                     | 0703 |
      | BOS                       | 1018 |
      | A/B                       | 6316 |
      | O/S                       | 7669 |
      | OLR                       | 0450 |


  Scenario: Verify in the form there are all questions
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new PRE
    And I enter pin 8383
    Then I should see all questions for PRE
      | Is the fixed equipment for continuous monitoring of the atmosphere working properly and calibrated?                              |
      | Has communication with the responsible officer been established?                                                                 |
      | Has the exhaust uptake been set to draw air from the lowest point in the pump room?                                              |
      | Is the Emergency evacuation harness ready for use?                                                                               |
      | Have the personal monitors for persons entering the pump room been checked for readiness?                                        |
      | Are the personnel entering the pump room aware of the locations of the ELSA / EEBD and familiar with its use?                    |
      | Are the personnel entering the pump room aware of the reporting interval?                                                        |
      | Are emergency and evacuation procedures established and understood by the Person(s) entering the pump room?                      |
      | Have the names of the person(s) entering the pump room been recorded in the Port operations log together with the time of entry? |
      | Are the person(s) entering the pump room aware that after exiting the space a report to the responsible officer must be made?    |
      | Are the persons entering the pump room familiar with the emergency alarm meant for  CO2 / Foam flooding?                         |
      | Are the persons entering the pump room familiar with the location of the emergency trips for the cargo pumps?                    |
      | Is the pumproom bilge dry?                                                                                                       |
