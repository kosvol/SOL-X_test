@test_google
Feature: test google

  Scenario: 1 test
    Given Google open main page
    
  Scenario: 2 test
    Given Google open main page
    And Google find Sign in

  Scenario: 3 failtest
    Given Google open main page
    And Google get error
