@section5
Feature: Section5
  As a ...
  I want to ...
  So that ...

  Scenario: Verify signature component is deleted after removing Roles & Responsibilities from drop down
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    Then I should see 1 role listed
    And I should see Authorized Entrant 1 role
    When I delete 1 role from list
    Then I should see 0 role listed
    And I should not see Authorized Entrant 1 role

  Scenario: Verify signature component is deleted after removing Roles & Responsibilities via cross
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 2 role from list
    Then I should see 2 role listed
    And I should see Authorized Entrant 1 role
    And I should see Authorized Entrant 2 role
    When I delete the role from cross
    Then I should see 1 role listed
    And I should not see Authorized Entrant 1 role
    And I should see Authorized Entrant 2 role

  Scenario: Verify user can see a list of roles
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    Then I should see a list of roles

  Scenario: Verify user can sign on responsiblity and reflected as roles for the crew
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I sign on role
    Then I should see first signed role details with 9015 pin

  Scenario: Verify same user can sign for multiple roles
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 2 role from list
    And I sign on role
    Then I should see first signed role details with 9015 pin
    When I sign on next role with same user
    Then I should see second signed role details with 9015 pin

  Scenario: Verify Enter Pin and Sign button is disable if sign as non crew checked
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I check non crew member checkbox
    Then I should see sign button disabled

  Scenario: Verify Enter Pin and Sign button is enabled if name and company fields filled
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I fill up non crew details
    Then I should see sign button enabled

  Scenario: Verify ship staff copy text display after name and company fields filled
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I fill up non crew details
    Then I should see non crew copy text

  Scenario Outline: Verify only sponsor crews can sign
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I fill up non crew details
    And I sign on role with sponsor crew <rank> rank
    Then I should see non crew details
    And I should see supervise by <supervized> detail and Test Automation Company detail

    Examples:
      | rank  | pin  | supervized          |
      | C/O   | 8383 | C/O Alister Leong   |
      | A C/O | 2761 | A C/O Nigel Koh     |
      | 2/O   | 6268 | 2/O Paul Keng Teoh  |
      | A 2/O | 7865 | A 2/O Qasim Khan    |
      | 3/O   | 0159 | 3/O Tim Kinzer      |
      | C/E   | 8248 | C/E Alex Pisarev    |
      | A C/E | 5718 | A C/E A C/E Xiaowei |
      | 2/E   | 2523 | 2/E Poon Choryi     |
      | A 2/E | 3030 | A 2/E Hyman Huang   |
      | 3/E   | 4685 | 3/E Cs Ow           |
      | A 3/E | 6727 | A 3/E James Pike    |
      | 4/E   | 1311 | 4/E Tori Kuncoro    |

  Scenario Outline: Verify non sponsor crews cannot sign
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I fill up non crew details
    And I sign on role with non sponsor crew <rank> rank
    Then I should see not authorize error message

    Examples:
      | rank | pin  |
      | MAS  | 1111 |

  Scenario Outline: Verify crew can sign
    Given I launch sol-x portal
    And I navigate to create new permit
    And I enter pin for rank A/M
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 5
    And I select 1 role from list
    And I sign on role with sponsor crew <rank> rank
    Then I should see first signed role details with <pin> pin

    Examples:
      | rank | pin  | supervized        |
      | C/O  | 8383 | C/O Alister Leong |