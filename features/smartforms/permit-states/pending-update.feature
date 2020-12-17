@pending-update
Feature: PendingUpdate
  As a ...
  I want to ...
  So that ...

  # Scenario: Verify all sections fields are enabled when editing from pending approval state for RA

  # Scenario: Verify section 6 buttons display are correct via pending termination state

  # Scenario: Verify AGT can add gas reading

  # Scenario: [PTW][Pending Master Approval/Review] - Comment is not saved for the EIC when requesting the form for updates
  # Create a new PTW form (except "Rigging of Ladder");
  # Navigate to Section 4B and create the EIC;
  # Submit the form for Master's Approval (Master's Review for OA forms);
  # Open the form as the captain from the Pending Approval filter;
  # Navigate to Section 7 (Section 6 for OA forms);
  # Click on "Request Updates";
  # Enter a comment;
  # Navigate to Section 4B;
  # Click on "View/Edit Energy Isolation Certificate".

  # The comment that has been entered before is not saved for the EIC. As a result, Checklist Creator ranks will not be able to see the comment on the EIC screen when open the form from the Updates Needed filter.

  # Scenario: [PTW][Pending Master Approval/Review] - Comment text box is missing at the top of the individual DRA screen when requesting for updates
  #   Create a new PTW form (except "Rigging of Gangway & Pilot ladder");
  #   Submit the form for Master's Approval (Master's Review for OA form);
  #   Open the form as the Master from the Pending Approval section;
  #   Navigate to Section 7 (section 6 for OA form);
  #   Click on "Updates Needed" at the bottom of the screen;
  #   Navigate to Section 3A;
  #   Click on "View/Edit Hazards".

  #   Comment dialog is missing at the top of the individual DRA screen.

  Scenario: Verify Master should not see comment box on EIC Certification screen after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I click on update needed filter
    And I update permit with A/M rank and 1111 pin
    And I navigate to section 4b
    And I click on view EIC certification button
    Then I should not see comment box exists

  Scenario: Verify user is able to update permit after Office request for update
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Critical Equipment Maintenance permit
    And I select Maintenance on Magnetic Compass permit for level 2
    And I fill section 1 of maintenance permit with duration more than 2 hours
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    Then I submit permit for Master Review
    When I click on back to home
    And I click on pending approval filter
    And I set oa permit to office approval state manually
    And I navigate to OA link
    And I request the permit for update via oa link manually
    And I click on update needed filter
    And I update permit with A/M rank and 9015 pin
    And I navigate to section 3a
    And I click on View Edit Hazard
    Then I should see DRA content editable

  Scenario: Verify section 6 buttons display are correct via pending master approval state as a reader
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with 5/E rank and 7551 pin
    And I navigate to section 6
    Then I should see previous and close buttons
  #And I tear down created form

  Scenario: Verify checklist creator can edit rol checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Rigging of Gangway & Pilot Ladder permit
    And I select Rigging of Gangway & Pilot Ladder permit for level 2
    When I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I press next for 1 times
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with A 3/E rank and 6727 pin
    And I press next for 1 times
    And I should see rol checklist questions fields enabled
  #And I tear down created form

  Scenario Outline: Verify checklist creator can edit checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with 3/E rank and 4685 pin
    And I navigate to section 4a
    Then I should see checklist selections fields enabled
    And I press next for 1 times
    And I should see checklist questions fields enabled
    # When I sign on checklist with <pin> pin
    # And I sign on canvas
    #And I tear down created form

    Examples:
      | rank  | pin  |
      | 3/E   | 4685 |
      | 4/E   | 1311 |
      | A 4/E | 0703 |

  Scenario: Verify non checklist creator cannot edit checklist during active state via pending approval
    Given I launch sol-x portal without unlinking wearable
    And I navigate to create new permit
    And I enter pin 9015
    And I select Enclosed Spaces Entry permit
    And I select Enclosed Spaces Entry permit for level 2
    And I navigate to section 4a
    And I press next for 1 times
    And I fill up compulsory fields
    And I press next for 1 times
    And I submit permit for Master Approval
    And I click on back to home
    And I click on pending approval filter
    And I open a permit pending Master Approval with Master rank and 1111 pin
    And I navigate to section 7
    And I request update for permit
    And I click on back to home
    And I click on update needed filter
    And I update permit with 3/E rank and 7551 pin
    And I navigate to section 4a
    Then I should not see checklist selections fields enabled
    And I press next for 1 times
    And I should not see checklist questions fields enabled
# And I should not see enter pin button
#And I tear down created form
