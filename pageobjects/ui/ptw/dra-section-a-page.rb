require "./././support/env"

class DRASectionAPage
  include PageObject

  # @root_xpath = "//%s[@data-testid='%s']"
  # elements(:crew_table_header,xpath: "//*/tr/th")
  # elements(:crew_list,xpath: "//*/tbody/tr")

  def create_underwater_permit(permit)
    # nav to create form
    # select permit
    @@default_permit_details = YAML.load_file("data/dra/1.#{permit}.yml")
    puts ">>>> #{@@default_permit_details[permit]["page2"]["existing_methods"][0]}"
  end
end
