Then (/^I should see correct column headers$/) do
  is_equal(on(CrewListPage).get_crew_table_headers, "[\"Rank\", \"Crew ID\", \"Surname\", \"First Name\", \"Location\"]")
end

Then (/^I should see total crew count match inactive crew$/) do
  step "I get wearable-simulator/base-get-list-of-crew request payload"
  step "I hit graphql"
  is_equal(on(CrewListPage).crew_list_elements.size, ServiceUtil.get_response_body["data"]["crewMembers"].size)
end
