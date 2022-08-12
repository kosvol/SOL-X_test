Feature: Personal data (crew birthday) scripts

  @reset_personal_data
  Scenario: Reset personal data database
    Given DB service clear couch table
      | db_type | table        |
      | edge    | personal_data |
      | cloud   | personal_data |
    Then PersonalData service reset