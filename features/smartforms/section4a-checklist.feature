@section4AChecklist
Feature: Section4AChecklist
  As a ...
  I want to ...
  So that ...

  Scenario Outline: Verify checklist content are displayed correctly for maintenance permits
    Given I launch sol-x portal
    When I navigate to "SmartForms" screen
    And I navigate to create new permit
    And I enter RA pin 1313
    And I select <level_one_permit> permit
    And I select <level_two_permit> permit for level 2
    And I submit after filling up section 1 with duration more than 2 hours
    And I navigate to section 4a
    Then I should see correct checklist content for <checklist> checklist
    And I tear down created form

    Examples:
      | level_one_permit               | level_two_permit                                                                              | checklist                                |
      | Critical Equipment Maintenance | Maintenance on Anchor                                                                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Fire Pump                                                            | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Generator                                                            | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Emergency Stop Switches for Engine Room and Cargo Equipment                    | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fire Detection Alarm System                                                    | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fixed Fire Fighting System                                                     | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Fuel/Lubricating Oil Tanks Quick Closing Valve & Panel                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Life/Rescue Boats and Davits                                                   | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Lifeboat Engine                                                                | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Critical Equipment - Magnetic Compass                                          | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Main Boilers and GE - Shutdown Alarm & Tripping Device                         | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Critical Equipment - Main Propulsion System - Shutdown Alarm & Tripping Device | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oil Discharging Monitoring Equipment                                           | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oil Mist Detector Monitoring System                                            | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Oily Water Separator                                                           | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on P/P Room Gas Detection Alarm System                                            | Critical Equipment Maintenance Checklist |
      | Critical Equipment Maintenance | Maintenance on Radio Battery                                                                  | Critical Equipment Maintenance Checklist |

# Scenario: Verify checklist form is pre-populated with PTW permit number, data and time

# Scenario: Verify master cannot enter pin on checklist

# Scenario: Verify name and time is displayed after signing on checklist