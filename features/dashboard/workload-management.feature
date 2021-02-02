@workload-management
Feature: WorkloadManagement
    As a ...
    I want to ...
    So that ...

    # Scenario: Verify crew cannot work more than 77 hours consecutively for 2 weeks
    # Scenario: Verify crew can work when total work hours is less than 77 hours in any 7 days
    # Scenario: Verify crew rest hours period interval compliance when not exceeding 14 hours
    # Scenario: Verify crew rest periods not compliance when more than 2 periods used to form 10 hours in any 24 hours
    # Scenario: Verify crew rest hours compliance to 10 hours in any 24 hours period using 2 periods with at least 1 6 hours rest
    # Scenario: Verify crew rest hours compliance to 10 hours in next rolling 24 hours using 2 periods with at least 1 6 hours rest
    # Scenario: Verify crew rest hours compliance in next rolling periods when there is more than 2 rest periods in any 24 hours where first 2 adds up to 10 hours
    # Scenario: Verify exception will happen if one of the rest period is not 6 hours or more

    @SOL-6080
    Scenario: Verify work availability bar not display when crew is inactive

    @SOL-6080
    Scenario: Verify work availability bar not display when marker is yellow and showing last seen

    @SOL-6080
    Scenario: Verify work availability bar display blue when crew work less than 10 hours during last 24 hours

    @SOL-6080
    Scenario: Verify work availability bar display yellow when crew work more than 10 but less than 14 hours during last 24 hours

    @SOL-6080
    Scenario: Verify work availability bar display red when crew work more than 14 hours during last 24 hours

    @SOL-6081
    Scenario: Verify only these ranks are able to view work availability in details
    # Master
    # C/O
    # C/E
    # A C/E
    # 2/E
    # A 2/E
    # 3/E
    # A 3/E
    # A C/O
    # 2/O
    # A 2/O
    # 3/O
    # A 3/O

    @SOL-6082
    Scenario:

    @SOL-6083
    Scenario: Verify Total Work display red when crew works for more than 14 hours in any 24 hours

    @SOL-6083
    Scenario: Verify Work Availability display yellow when crew works between 10-13 hours in any 24 hours

    @SOL-6083
    Scenario: Verify Longest Rest display red when crew did not have at least 6 hours of rest in at least one interval in any 24 hours

    @SOL-6083
    Scenario: Verify Longest Rest display red when crew did not have at least 6 hours of rest in at least one interval in any 24 hours

    @SOL-6083
    Scenario: Verify Rest Periods display red when crew has more than 2 interval to form 10 hours of rest in any 24 hours

    @SOL-6088
    Scenario: Verify work hours are rounded to nearest 30 mins
    # 1hr1min -> clocked 1hr 30mins
    # 1hr 31min -> clocked 2hrs
    # 10mins -> clocked 30 mins
    # 40 mins -> clocked 1hr

    @SOL-6090
    Scenario: Verify no more than 77 hours of rest in any 7 days

    @SOL-6090
    Scenario: Verify no less than 70 hours of rest in any 7 days

    @SOL-6090
    # or not more than 72 hours of work ?
    Scenario: Verify no more than 98 hours of work in any 7 days

    @SOL-6093
    Scenario: Verify work hours recorded less 1 hour if ship time advance 1 hour

    @SOL-6093
    Scenario: Verify work hours recorded additional 1 hour if ship time reduce by 1 hour