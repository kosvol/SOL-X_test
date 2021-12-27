## Contributing guidelines
1. Make sure test revised scenarios before submit the PR
2. Make sure the follow the rubocup code static 
   1. bundle exec rubocop
3. Only add the cucumber.yml if necessarily. 
   1. If you need to run the feature on the jenkins. you could pass all environment variables in Jenkins instead of adding the cucumber profile
```shell
# local debug usage
cucumber -p tablet_sample -t @test
# jenkins
cucumber --format pretty --expand -f json -o json_report.json PLATFORM=chrome_headless APPLICATION=c2_preview ENVIRONMENT=auto VESSEL=cot DEVICE=tablet -t ${TAGS}
```
4. Follow the step format to create step 
   1. e.g. "{page} + {behavior}" => 
 ```gherkin
      Given SmartForms open page
      And SmartForms click create permit to work
      And PinEntry enter pin for rank "C/O"
```
5. If need to use pin number, plz use request to get the pin number instead of hardcoded. PIN may change overtime.
6. When there are too many variables in step, please use table to pass variables
e.g. 
```gherkin
    Given PermitGenerator create permit
      | permit_type           | permit_status    | eic | gas_reading | bfr_photo |
      | enclosed_spaces_entry | pending_approval | yes | yes         | 2         |
```
7. If there are logs of duplicated step in one feature, please consider to use background format.
