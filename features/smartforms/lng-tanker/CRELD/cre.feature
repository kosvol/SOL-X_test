@lng-cre
Feature: LNGCRE
    As a ...
    I want to ...
    So that ...

    Background:
        Given I switch vessel to LNG

    # Scenario: Verify new scheduled CRE permit will replace existing active CRE permit

    Scenario: Verify user can see all the CRE questions
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new CRE
        And I enter pin 8383
        Then I should see CRE form questions

    Scenario Outline: Verify only these crew can create CRE permit
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new CRE
        And I enter pin <pin>
        Then I should see CRE landing screen

        Examples:
            | rank                      | pin  |
            # | Chief Officer             | 8383 |
            | Additional Chief Officer  | 2761 |
            # | Second Officer | 6268 |
            | Additional Second Officer | 7865 |
            # | 3/O                       | 0159 |
            | A 3/O                     | 2674 |

    Scenario: Verify these crew cannot create CRE permit
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new CRE
        And I enter pin 9015
        Then I should see not authorize error message

    Scenario: Verify AGT can add gas reading in CRE permit
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new CRE
        And I enter pin 8383
        And I add all gas readings
        And I enter pin 9015
        And I set time
        Then I will see popup dialog with By A/M Atif Hayat crew rank and name
        When I dismiss gas reader dialog box
        Then I should see gas reading display with toxic gas

    Scenario Outline: Verify any rank can add gas reading in CRE permit
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new CRE
        And I enter pin 8383
        And I add all gas readings
        And I enter pin 4421
        When I dismiss gas reader dialog box

        Examples:

            | rank | pin  |
            | PMAN | 4421 |
            | ETO  | 0856 |
            | ELC  | 2719 |

    Scenario: Verify CRE creator cannot approve the same permit
        Given I launch sol-x portal without unlinking wearable
        # When I clear gas reader entries
        When I navigate to create new CRE
        And I enter pin 8383
        And I fill up CRE. Duration 4. Delay to activate 2
        And for cre I submit permit for Officer Approval
        And I getting a permanent number from indexedDB
        And I open the current CRE with status Pending approval. Pin: 8383
        And I should see not authorize error message

    Scenario: Verify non CRE creator can approve the same permit
        Given I launch sol-x portal without unlinking wearable
        # When I clear gas reader entries
        When I navigate to create new CRE
        And I enter pin 8383
        And I fill up CRE. Duration 4. Delay to activate 2
        And for cre I submit permit for Officer Approval
        And I getting a permanent number from indexedDB
        And I open the current CRE with status Pending approval. Pin: 2761
        Then I should see CRE landing screen

    Scenario Outline: Verify these roles can terminate CRE permit
        Given I launch sol-x portal without unlinking wearable
        When I clear gas reader entries
        And I navigate to create new CRE
        And I enter pin 8383
        Then I fill up CRE. Duration 4. Delay to activate 2
        # And Get PRE id
        And (for pre) I submit permit for Officer Approval
        And I getting a permanent number from indexedDB
        Then I activate the current CRE form
        And I sleep for 1 seconds
        When I navigate to "Scheduled" screen for CRE
        And I should see the current CRE in the "Scheduled" list
        And I click on back arrow
        And I sleep for 100 seconds
        And I navigate to "Active" screen for CRE
        And I should see the current CRE in the "Active CRE" list
        And I click on back arrow
        Then I terminate the PRE
        When I navigate to "Terminated" screen for CRE
        And I should see the current CRE in the "Closed CRE" list

        Examples:
            | rank           | pin  |
            | Chief Officer  | 8383 |
            # | Additional Chief Officer  | 2761 |
            | Second Officer | 6268 |
            # | Additional Second Officer | 7865 |
            | 3/O            | 0159 |
    # | A 3/O                     | 2674 |

    Scenario: Verify only MAS can delete CRE permit in Created State
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new CRE
        And I enter pin 8383
        And I click on back arrow
        And I navigate to "Created" screen for CRE
        And I delete the permit created
        Then I should see deleted permit deleted

    Scenario: Verify user cannot send CRE for approval with start time and duration
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new CRE
        And I enter pin 8383
        And for cre I should see the disabled "Submit for Approval" button

    Scenario: Verify these roles can request update for CRE permit in Pending Approval State
        Given I launch sol-x portal without unlinking wearable
        # When I clear gas reader entries
        When I navigate to create new CRE
        And I enter pin 8383
        And I fill up CRE. Duration 4. Delay to activate 2
        And for cre I submit permit for Officer Approval
        And I getting a permanent number from indexedDB
        And I open the current CRE with status Pending approval. Pin: 2674
        And for cre I should see the disabled "Updates Needed" button

    Scenario: Verify CRE permit turn active on schedule time
        Given I launch sol-x portal without unlinking wearable
        When I clear gas reader entries
        And I navigate to create new CRE
        And I enter pin 8383
        And I fill up CRE. Duration 4. Delay to activate 2
        And Get CRE id
        And for cre I submit permit for Officer Approval
        And I getting a permanent number from indexedDB
        Then I activate the current CRE form
        And I sleep for 1 seconds
        When I navigate to "Scheduled" screen for CRE
        And I should see the current CRE in the "Scheduled" list
        And I click on back arrow
        And I sleep for 100 seconds
        And I navigate to "Active" screen for CRE
        And I should see the current CRE in the "Active PRE" list

    Scenario: Verify creator PRE cannot request update needed
        Given I launch sol-x portal without unlinking wearable
        When I clear gas reader entries
        And I navigate to create new CRE
        And I enter pin 8383
        And I fill up CRE. Duration 4. Delay to activate 2
        And Get CRE id
        And for cre I submit permit for Officer Approval
        And I getting a permanent number from indexedDB
        Then I open the current PRE with status Pending approval. Pin: 8383
        Then I should see Add Gas button disabled
        And I should see Approve for Activation button disabled