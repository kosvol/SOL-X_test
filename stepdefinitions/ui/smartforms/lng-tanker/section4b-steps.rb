Then (/^I should see competent person label change$/) do
        is_equal(on(Section4BPage).competent_label_elements[3].text,"Competent Person (C/O, 2/E):")
end

Then (/^I should see issuing authority label change$/) do
        is_equal(on(Section4BPage).competent_label_elements[4].text,"Issuing Authorized (Master, C/E):")
end