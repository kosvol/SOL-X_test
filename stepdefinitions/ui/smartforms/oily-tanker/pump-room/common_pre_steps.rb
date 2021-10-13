# frozen_string_literal: true

When(/^I fill and submit PRE permit details via (service|ui|without gas readings)$/) do |condition|
  step 'I clear gas reader entries'
  step 'I navigate to create new PRE'
  step 'I enter pin via service for rank C/O'
  step 'I fill up PRE. Duration 4. Delay to activate 3'
  step 'I add all gas readings with C/O rank' if condition != 'without gas readings'
  step 'I dismiss gas reader dialog box' if condition != 'without gas readings'
  sleep 1
  step 'for pre I submit permit for A C/O Approval'
  step 'I sleep for 6 seconds'
  step 'I getting a permanent number from indexedDB'
  step 'I activate the current PRE form'
  step 'I sleep for 120 seconds' if condition == 'ui'
  step 'I activate PRE form via service' if condition != 'ui'
  step 'I navigate to PRE Display until see active permit'
end

And(/^I get active (CRE|PRE) permit and terminate$/) do |permit_type|
  response = on(BypassPage).retrieve_active_form(permit_type)
  if response['data']['forms']['edges'] != []
    permit_id = response['data']['forms']['edges'][0]['node']['_id']
    CommonPage.set_permit_id(permit_id)
    step "I terminate the #{permit_type} permit via service"
  end
end
