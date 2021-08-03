@lng-cre
Feature: LNGCRE
  As a ...
  I want to ...
  So that ...

  #  Background:
  #    Given I switch vessel to LNG

  # Scenario: Verify new scheduled CRE permit will replace existing active CRE permit

  Scenario: Verify user can see all the CRE questions
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    Then I should see CRE form questions

  Scenario Outline: Verify only these crew can create CRE permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new CRE
    And I enter pin for rank <rank>
    Then I should see CRE landing screen

    Examples:
      | rank  |
      | C/O   |
      | A C/O |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify these crew cannot create CRE permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new CRE
    And I enter pin for rank A/M
    Then I should see not authorize error message

  Scenario: Verify AGT can add gas reading in CRE permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I add all gas readings
    And I enter pin via service for rank A/M
    And I set time
    Then I will see popup dialog with A/M LNG A/M crew rank and name
    When I dismiss gas reader dialog box
    Then I should see gas reading display with toxic gas and A/M COT A/M as gas signer

  Scenario Outline: Verify any rank can add gas reading in CRE permit
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I add all gas readings
    And I enter pin via service for rank <rank>
    When I dismiss gas reader dialog box

    Examples:

      | rank | pin  |
      | PMAN | 4421 |
      | ETO  | 0856 |
      | ELC  | 2719 |

  Scenario: Verify CRE Chief Officer can approve the same permit
    Given I launch sol-x portal without unlinking wearable
    # When I clear gas reader entries
    When I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And for cre I should see the enabled "Approve for Activation" button

  Scenario Outline: Verify CRE roles cannot approve the same permit
    Given I launch sol-x portal without unlinking wearable
    # When I clear gas reader entries
    When I navigate to create new CRE
    And I enter pin via service for rank <rank>
    And I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for <rank> Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: <rank>
    And for cre I should see the disabled "Approve for Activation" button
    Examples:

      | rank  |
      | 2/O   |
      | A 2/O |
      | 3/O   |
      | A 3/O |

  Scenario: Verify non CRE creator can approve the same permit
    Given I launch sol-x portal without unlinking wearable
    # When I clear gas reader entries
    When I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: A C/O
    Then I should see CRE landing screen

  Scenario Outline: Verify these roles can terminate CRE permit
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin via service for rank <rank>
    Then I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for <rank> Approval
    And I getting a permanent number from indexedDB
    Then I activate the current CRE form
    And I sleep for 1 seconds
    When I navigate to "Scheduled" screen for CRE
    And I should see the current CRE in the "Scheduled" list
    And I click on back arrow
    And I activate CRE form via service
    And I navigate to "Active" screen for CRE
    And I should see the current CRE in the "Active CRE" list
    And I click on back arrow
    Then I terminate the PRE
    When I navigate to "Terminated" screen for CRE
    And I should see the current CRE in the "Closed CRE" list

    Examples:
      | rank |
      | C/O  |
      # | Additional Chief Officer  | 2761 |
      | 2/O  |
      # | Additional Second Officer | 7865 |
      | 3/O  |
  # | A 3/O                     | 2674 |

  Scenario: Verify only MAS can delete CRE permit in Created State
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I click on back arrow
    And I navigate to "Created" screen for CRE
    And I delete the permit created
    Then I should see deleted permit deleted

  Scenario: Verify user cannot send CRE for approval with start time and duration
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And for cre I should see the disabled "Submit for Approval" button

  Scenario: Verify these roles can request update for CRE permit in Pending Approval State
    Given I launch sol-x portal without unlinking wearable
    # When I clear gas reader entries
    When I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: A 3/O
    Then I should see Approve for Activation button enabled
    Then I should see Updates Needed button enabled

  Scenario: Verify CRE permit turn active on schedule time
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    Then I activate the current CRE form
    And I sleep for 1 seconds
    When I navigate to "Scheduled" screen for CRE
    And I should see the current CRE in the "Scheduled" list
    And I click on back arrow
    And I activate CRE form via service
    And I navigate to "Active" screen for CRE
    And I should see the current CRE in the "Active PRE" list

  Scenario: Verify creator PRE cannot request update needed
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    Then I open the current PRE with status Pending approval. Rank: C/O
    Then I should see Add Gas button enabled
    And I should see Updates Needed button disabled

  Scenario: The Responsible Officer Signature should be displayed CRE
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 10
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And I take note of start and end validity time for CRE
    And I check "Responsible Officer Signature" is present
    When I press the "Approve for Activation" button
    And I sign with valid C/O rank
    And I should see the page 'Permit Successfully Scheduled for Activation'
    Then I press the "Back to Home" button
    And I sleep for 1 seconds
    When I navigate to "Scheduled" screen for CRE
    And I should see the current CRE in the "Scheduled" list
    When I view permit with C/O rank
    And I check "Responsible Officer Signature" is present

  Scenario: The Responsible Officer Signature should be displayed in terminated list CRE
    Given I launch sol-x portal without unlinking wearable
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And I take note of start and end validity time for CRE
    When I press the "Approve for Activation" button
    And I sign with valid C/O rank
    And I should see the page 'Permit Successfully Scheduled for Activation'
    Then I press the "Back to Home" button
    And I sleep for 1 seconds
    And I activate CRE form via service
    And I sleep for 10 seconds
    Then I terminate the PRE
    When I navigate to "Terminated" screen for CRE
    And I should see the current CRE in the "Terminated" list
    When I view permit with C/O rank
    And I check "Responsible Officer Signature" is present

  Scenario: Gas Reader location stamp should not be missing
    Given I launch sol-x portal
    When I link wearable to rank C/O to zone
    When I clear gas reader entries
    And I navigate to create new CRE
    And I enter pin via service for rank C/O
    And I fill up with gas readings CRE. Duration 4. Delay to activate 3
    And for cre I submit permit for A C/O Approval
    And I getting a permanent number from indexedDB
    And I open the current CRE with status Pending approval. Rank: C/O
    And I take note of start and end validity time for CRE
    When I press the "Approve for Activation" button
    And I sign with valid C/O rank
    And I should see the page 'Permit Successfully Scheduled for Activation'
    Then I press the "Back to Home" button
    And I sleep for 1 seconds
    And I activate CRE form via service
    And I sleep for 1 seconds
    When I navigate to "Active" screen for CRE
    When I view permit with C/O rank
    Then I check location in gas readings signature is present

