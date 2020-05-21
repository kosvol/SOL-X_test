When(/^I create a (.+) permit$/) do |permit|
  on(DRASectionAPage).create_underwater_permit(permit)
end