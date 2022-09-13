Feature:clear and insert generated data

  @clear_wellbeing_reports
  Scenario: clean postgres data of wellbeing reports
  Given Clean postgres data of wellbeing reports

  @create_well_reports_postgres
  Scenario: generate and insert DATA to Postgres
  Given DB service create reports postgres data