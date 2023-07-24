Given("Google open main page") do
    @driver.get "https://google.com/gmail/about"
    puts('test complete')
end

Given("Google find Sign in") do
    xpath = "//a[contains(.,'Sign in')]"
    @driver.find_element(xpath)
    puts('test complete')
end
