And (/^I fill up compulsory fields$/) do
    step 'I sign on checklist with 8383 as valid pin'
    step 'I press next for 1 times'
    sleep 1
    step 'I select yes to EIC'
    step 'I fill up EIC certificate'
    step 'I press next for 1 times'
    step 'I fill up section 5'
end

When (/^I fill a full enclosed workspace permit$/) do
  step 'I fill up section 1 with default value'
  step 'I navigate to section 4a'
  step 'I press next for 1 times'
  step 'I sleep for 1 seconds'
  step 'I fill up checklist'
  step 'I sleep for 1 seconds'
  step 'I sign on checklist with 9015 as valid pin'
  step 'I press next for 1 times'
  step 'I select yes to EIC'
  step 'I fill up EIC certificate'
  step 'I press next for 1 times'
  step 'I fill up section 5'
  step 'I press next for 1 times'
  on(Section3APage).scroll_multiple_times(3)
  step 'I submit smoke test permit'
  step 'I sleep for 2 seconds'
  step 'I click on back to home'
  step 'I sleep for 3 seconds'
end

When (/^I fill a full OA permit$/) do
  step 'I fill up section 1 with default value'
  step 'I press next for 7 times'
  step 'I sign on checklist with 9015 as valid pin'
  step 'I press next for 1 times'
  step 'I select yes to EIC'
  step 'I fill up EIC certificate'
  step 'I press next for 1 times'
  step 'I fill up section 5'
  step 'I press next for 1 times'
  on(Section3APage).scroll_multiple_times(3)
  step 'I submit permit for Master Review'
  step 'I sleep for 2 seconds'
  step 'I click on back to home'
  step 'I sleep for 3 seconds'
end