Feature: Crew member scripts

  @reset_crew_member
  Scenario: Reset crew member database
    Given DB service clear couch table
      | db_type | table        |
      | edge    | crew_members |
      | cloud   | crew_members |
    Then CrewMember service reset