@op_manage_role_page
Feature: Office Portal Login by Admin and check the Manage Role page
  Correct credentials for test
  email: admnofficeportal@gmail.com
  password: Solxtester12345!

  Background:
    Given OfficeLogin open page
    When OfficeLogin enter email "admnofficeportal@gmail.com"
    And OfficeLogin enter password "Solxtester12345!"
    And OfficeLogin click the Sign in button

  @close_browser
  Scenario: Verify the Manage Role page by default (SOL-10703)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole verify page without roles

  @close_browser
  Scenario: Verify the Create New Role page (SOL-10704)
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole verify "Create New Role" permissions list
      | Control of work: Safety & Compliance | Permit Archive       |
      | Crew Protect: Wellbeing reports      | Permit Trends        |
      |                                      | Risk Assessment      |
      |                                      | Best Practice        |
      |                                      | Near Misses          |
      |                                      | Newly Added Hazards  |
      |                                      | Newly Added Measures |
      |                                      | Average Crew Steps   |
      |                                      | Work Rest Hours      |
      |                                      | Heat Stress          |
      |                                      | Heart Rate Trends    |
    And OfficeManageRole verify "Create|Edit Role" the group checkbox
      | Control of work: Safety & Compliance      | unchecked       |
      | Crew Protect: Wellbeing reports           | unchecked       |
    Then OfficeManageRole verify "Create|Edit Role" the sub-group and single checkbox
      | Permit Archive                            | unchecked       |
      | Permit Trends                             | unchecked       |
      | Risk Assessment                           | unchecked       |
      | Best Practice                             | unchecked       |
      | Near Misses                               | unchecked       |
      | Newly Added Hazards                       | unchecked       |
      | Average Crew Steps                        | unchecked       |
      | Work Rest Hours                           | unchecked       |
      | Heat Stress                               | unchecked       |
      | Heart Rate Trends                         | unchecked       |

  @close_browser
  Scenario: Verify the back arrow (SOl-10499)
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    When OfficeNavigation click "Back" arrow
    Then OfficeManageRole verify page without roles

  @close_browser
  Scenario: Verify the cancel button (SOl-10499)
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Cancel" button
    Then OfficeManageRole verify page without roles

 @close_browser
  Scenario: Verify the "Create Role" button is disabled when no one permission hasn't been selected. (SOL-10689)
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
     | name              | description                 |
     | Automation Name   | Automation Description      |
   Then OfficeManageRole "Create|Edit Role" verify the "Create Role" button is "disabled"

  @close_browser
  Scenario: Verify the button Create Role button is enabled when the data were filled
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name    | Automation Description     |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" verify the "Create Role" button is "enabled"

  @close_browser
  Scenario: Verify the toast message "Role <Role name> created successfully“ is present (SOL-10496)
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name    | Automation Description     |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    And OfficeManageRole verify the toast message is shown "Role 'Automation Name' created successfully"

  @close_browser
  Scenario: Verify the list of roles contains newly created role (SOL-10716)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
     | name              | description                 |
     | Automation Name    | Automation Description     |
    And OfficeManageRole "Create|Edit Role" select the checkbox
     | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" verify the "Create Role" button is "enabled"
    When OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole verify the toast message is shown "Role 'Automation Name' created successfully"
    And OfficeManageRole verify the data of created role
      | Automation Name    | Automation Description       | 0 |
    Then OfficeManageRole verify the 'Edit' button is "enabled" for role 'Automation Name'
    Then OfficeManageRole verify the 'Delete' button is "enabled" for role 'Automation Name'

    @close_browser
  Scenario: Verify the user is NOT able create non unique role name (SOL-10495).
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    And OfficeManageRole "Create|Edit Role" verify the validation message is shown 'This role name is already in use. Please create a unique role name.'

  @close_browser
  Scenario: Verify the user is NOT able to use special characters in name (SOL-10495).
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation_Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    And OfficeManageRole verify the toast message is shown "name cannot have special characters or symbols, please check"

  @close_browser
  Scenario: Verify the user is able create several roles with uniq names (SOL-10495).
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name 2 | Automation Description 2    |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Crew Protect: Wellbeing reports | Heart Rate Trends |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    And OfficeManageRole verify the data of created role
      | Automation Name    | Automation Description       | 0 |
      | Automation Name 2  | Automation Description 2     | 0 |
  @test_passed
  @close_browser
  Scenario: Verify the user is able to delete roles with users = 0. (SOL-10501).
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole verify "Create New Role" page elements
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole 'Automation Name' click 'Delete' button
    Then OfficeManageRole verify "Delete modal window" of role "Automation Name"
    When OfficeManageRole click 'Delete' button of "Delete modal window"
    Then OfficeManageRole verify page without roles

  @close_browser
  Scenario: Verify the toast message "Role <Role name> deleted“ is present when user deleted a role (SOL-10701).
    When DB service clear Manage role list
    Then DB Manage role create "2" roles
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole 'Automation Name 1' click 'Delete' button
    When OfficeManageRole click 'Delete' button of "Delete modal window"
    And OfficeManageRole verify the toast message is shown "Role 'Automation Name 1' deleted"
@test_passed
  @close_browser
  Scenario: Verify a user is able to cancel deleting operation by "Cancel" button. (SOL-10695).
    When DB service clear Manage role list
    Then DB Manage role create "2" roles
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole 'Automation Name 1' click 'Delete' button
    When OfficeManageRole click 'Cancel' button of "Delete modal window"
    And OfficeManageRole verify the data of created role
      | Automation Name 1   | Automation test of 2 roles       | 0 |

  @close_browser
  Scenario: Verify the Edit Role page (SOL-10704)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance | Average Crew Steps |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole 'Automation Name' click 'Edit' button
    And OfficeManageRole verify "Edit Role" page elements
      | name              | description                 |
      | Automation Name   | Automation Description      |
    And OfficeManageRole verify "Create|Edit Role" the group checkbox
      | Control of work: Safety & Compliance      | checked       |
      | Crew Protect: Wellbeing reports           | indeterminate |
    Then OfficeManageRole verify "Create|Edit Role" the sub-group and single checkbox
      | Permit Archive                            | checked       |
      | Permit Trends                             | checked       |
      | Risk Assessment                           | checked       |
      | Best Practice                             | checked       |
      | Near Misses                               | checked       |
      | Newly Added Hazards                       | checked       |
      | Average Crew Steps                        | checked       |
      | Work Rest Hours                           | unchecked     |
      | Heat Stress                               | unchecked     |
      | Heart Rate Trends                         | unchecked     |

  @close_browser
  Scenario: Verify a user is able to select a group of permissions. (SOL-10699)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description              |
      | Automation Name   | Test Group checkbox      |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      | Control of work: Safety & Compliance |       |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole 'Automation Name' click 'Edit' button
    And OfficeManageRole verify "Create|Edit Role" the group checkbox
      | Control of work: Safety & Compliance      | checked       |
    Then OfficeManageRole verify "Create|Edit Role" the sub-group and single checkbox
      | Permit Archive                            | checked       |
      | Permit Trends                             | checked       |
      | Risk Assessment                           | checked       |
      | Best Practice                             | checked       |
      | Near Misses                               | checked       |
      | Newly Added Hazards                       | checked       |

  @close_browser
  Scenario: Verify a user is able to select only one permission from a group. (SOL-10700)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description              |
      | Automation Name   | Test single checkbox     |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      |                   | Near Misses |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole 'Automation Name' click 'Edit' button
    And OfficeManageRole verify "Create|Edit Role" the group checkbox
      | Control of work: Safety & Compliance      | indeterminate  |
    Then OfficeManageRole verify "Create|Edit Role" the sub-group and single checkbox
      | Risk Assessment                           | indeterminate  |
    Then OfficeManageRole verify "Create|Edit Role" the sub-group and single checkbox
      | Near Misses                               | checked        |

  @close_browser
  Scenario: Verify the user is NOT able to update role name to the existing in the list. (SOL-10697)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description             |
      | Automation Name   | Automation Description  |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      |                   | Permit Archive |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole click Create new role button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description             |
      | Automation Name 2 | Automation Description 2|
    And OfficeManageRole "Create|Edit Role" select the checkbox
      |                   | Best Practice |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole 'Automation Name 2' click 'Edit' button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description                     |
      | Automation Name   | Test edit role name to existing |
    Then OfficeManageRole "Create|Edit Role" click on "Save" button
    And OfficeManageRole "Create|Edit Role" verify the validation message is shown 'This role name is already in use. Please create a unique role name.'

  @close_browser
  Scenario: Verify the Save button is disabled when no one permission hasn't been selected.(SOL-10689)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name              | description             |
      | Automation Name   | Automation Description  |
    And OfficeManageRole "Create|Edit Role" select the checkbox
      |                   | Permit Trends |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    Then OfficeManageRole 'Automation Name' click 'Edit' button
    And OfficeManageRole "Create|Edit Role" select the checkbox
      |                   | Permit Trends |
    Then OfficeManageRole "Create|Edit Role" verify the "Save" button is "disabled"
@test
  @close_browser
  Scenario: Verify the toast message "Role <Role name> updated successfully“ is present when user successfully update a role. (SOL-10690)
    When DB service clear Manage role list
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole click Create new role button
    And OfficeManageRole "Create|Edit Role" fill fields
      | name              | description              |
      | Automation Name   | Automation Description     |
    When OfficeManageRole "Create|Edit Role" select the checkbox
      |                   | Near Misses |
    Then OfficeManageRole "Create|Edit Role" click on "Create Role" button
    And OfficeManageRole 'Automation Name' click 'Edit' button
    Then OfficeManageRole "Create|Edit Role" fill fields
      | name                    | description                |
      | Updated Automation Name | Test updated toast message |
    Then OfficeManageRole "Create|Edit Role" click on "Save" button
    And OfficeManageRole verify the toast message is shown "Role 'Updated Automation Name' updated successfully"

  @close_browser
  Scenario: Verify the pagination element number of roles of the "Manage Role" page. (SOL-10702)
    When DB service clear Manage role list
    Then DB Manage role create "100" roles
    And OfficeNavigation navigate to the "Manage Role" page
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select "20" number of roles per page
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select "50" number of roles per page
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select "100" number of roles per page
    Then OfficeManageRole verify number roles per page
    And DB service clear Manage role list

  @close_browser
  Scenario: Verify the pagination element of the "Manage Role" page. (SOL-10702)
    When DB service clear Manage role list
    Then DB Manage role create "100" roles
    And OfficeNavigation navigate to the "Manage Role" page
    And OfficeNavigation select page number "2"
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select "20" number of roles per page
    And OfficeNavigation select page number "3"
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select page number "4"
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select page number "5"
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select "10" number of roles per page
    And OfficeNavigation select "previous" page
    And OfficeNavigation select "20" number of roles per page
    And OfficeNavigation select "next" page
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select page number "1"
    And OfficeNavigation select "100" number of roles per page
    Then OfficeManageRole verify number roles per page
    And OfficeNavigation select "50" number of roles per page
    And OfficeNavigation select "next" page
    Then OfficeManageRole verify number roles per page
    And DB service clear Manage role list

#  Should be enabled when the #4 step will be created in Manage User page
#  @close_browser
#  Scenario: Verify the user is unable to delete roles with users > 0. (SOL-10500)
#    When DB service clear Manage role list
#    Then DB Manage role create "2" roles
#    And OfficeNavigation navigate to the "Manage Role" page
##    Then OfficeManageUser assign role 'Automation Name 1' to a user
#    And OfficeManageRole verify the data of created role
#      | Automation Name 1   | Automation test of 2 roles       | 1 |
#    Then OfficeManageRole verify the 'Delete' button is "disabled" for role 'Automation Name 1'