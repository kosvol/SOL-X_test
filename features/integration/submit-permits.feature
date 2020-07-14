@submit-permits-on-section6
Feature: SubmitPermit
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Submit permit successfully for Critical Maintenance Permit
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1212
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I fill up section 1 with default value
    And I navigate to section 3b
    And I fill up section 3b
    And I press next for 2 times
    # And I fill up section 3c
    And I fill up section 3d
    And I press next for 2 times
    # And I fill up section 4a
    And I fill up checklist yes, no, na
    And I press next for 1 times
    And I select yes to EIC
    And I press next for 2 times
    Then I submit permit for Master Approval
    And I click on permits pending approval
    And I review page 1 of submitted non maintenance permit
    And I review page 2 of submitted non maintenance permit
    And I review page 3a of submitted non maintenance permit
    And I review page 3b of submitted non maintenance permit
    And I review page 3c of submitted non maintenance permit
    And I review page 3d of submitted non maintenance permit
    And I review page 4a of submitted non maintenance permit
    And I review page 4a checklist of submitted non maintenance permit
    And I review page 4b of submitted non maintenance permit
    And I review page 5 of submitted non maintenance permit
    And I review page 6 of submitted non maintenance permit

    Examples:
      | level_one_permit      | level_two_permit     | checklist                      |
      | Enclosed Spaces Entry | Enclosed Space Entry | Enclosed Space Entry Checklist |
# | Hotwork               | Hot Work Level-2 in Designated Area | Hot Work Within Designated Area |