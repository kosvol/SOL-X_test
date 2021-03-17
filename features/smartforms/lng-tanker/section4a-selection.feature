@lng-section4AChecklistSelection
Feature: LNGSection4AChecklistSelection
    As a ...
    I want to ...
    So that ...

    Scenario: Verify checklist display are correct to vessel type
        Given I launch sol-x portal without unlinking wearable
        And I navigate to create new permit
        And I enter pin 9015
        And I select Enclosed Spaces Entry permit
        And I select Enclosed Spaces Entry permit for level 2
        And I navigate to section 4a
        Then I should see this list of available checklist
            | Cold Work Operation Checklist             |
            | Critical Equipment Maintenance Checklist  |
            | Enclosed Space Entry Checklist            |
            | Helicopter Operation Checklist            |
            | Hot Work Outside Designated Area          |
            | Hot Work Within Designated Area           |
            | Personnel Transfer by Transfer Basket     |
            | Compressor/Motor Room Entry Checklist     |
            | Rotational Portable Power Tools (PPT)     |
            | Underwater Operation                      |
            | Use of Camera Checklist                   |
            | Use of ODME in Manual Mode                |
            | Work on Deck During Heavy Weather         |
            | Work on Electrical Equipment and Circuits |
            | Work on Hazardous Substances              |
            | Work on Pressure Pipelines                |
            | Working Aloft/Overside                    |