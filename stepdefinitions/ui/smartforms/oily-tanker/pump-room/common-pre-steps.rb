When(/^I fill and submit PRE permit details via (service|ui|without gas readings)$/) do |_condition|
  step 'I clear gas reader entries'
  step 'I navigate to create new PRE'
  step 'I enter pin via service for rank C/O'
  step 'I fill up PRE. Duration 4. Delay to activate 3'
  step 'I add all gas readings' if _condition != 'without gas readings'
  step 'I enter pin via service for rank A/M' if _condition != 'without gas readings'
  step 'I dismiss gas reader dialog box' if _condition != 'without gas readings'
  sleep 1
  step 'for pre I submit permit for A C/O Approval'
  step 'I sleep for 6 seconds'
  step 'I getting a permanent number from indexedDB'
  step 'I activate the current PRE form'
  step 'I sleep for 120 seconds' if _condition === 'ui'
  step 'I activate PRE form via service' if (_condition === 'service') || (_condition === 'without gas readings')
  step 'I navigate to PRE Display'
  step 'I enter pin via service for rank C/O'
  step 'I sleep for 5 seconds'
end
