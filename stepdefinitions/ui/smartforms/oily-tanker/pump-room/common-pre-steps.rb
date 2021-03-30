When (/^I fill and submit PRE permit details$/) do
    step 'I clear gas reader entries'
    step 'I navigate to create new PRE'
    step 'I enter pin for rank C/O'
    step 'I fill up PRE. Duration 4. Delay to activate 2'
    step 'I add all gas readings'
    step 'I enter pin for rank A/M'
    step 'I dismiss gas reader dialog box'
    sleep 1
    step 'for pre I submit permit for A C/O Approval'
    step 'I sleep for 6 seconds'
    step 'I getting a permanent number from indexedDB'
    step 'I activate the current PRE form'
    step 'I sleep for 120 seconds'
    step 'I navigate to PRE Display'
    step 'I enter pin for rank C/O'
    step 'I sleep for 5 seconds'
end