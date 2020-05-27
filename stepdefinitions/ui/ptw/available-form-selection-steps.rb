Then("I should see a list of available forms for selections") do |table|
  # puts ">>> #{table.raw}"
  on(PTWPage).click_permit_type_ddl
  puts ">>>> #{on(PTWPage).list_permit_type_elements.size}"
  # is_equal("15",on(PTWPage).list_permit_type_elements.size)
end

And (/^I navigate to create new permit to work$/) do
  on(PTWPage).click_create_permit_btn
end
