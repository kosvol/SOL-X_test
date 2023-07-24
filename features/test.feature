@test_google
Feature: test google

  Scenario: #1 open Google mail page
    Given Google open main page
    
  Scenario: #2 find button Sign in
    Given Google open main page
    And Google find Sign in

  Scenario: #3 Negative test try to find element with name 'error'
  Given Google open main page
    And Google get error
