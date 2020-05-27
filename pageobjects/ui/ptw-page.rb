require "./././support/env"

class PTWPage
  include PageObject

  link(:click_create_permit_btn, xpath: "//a[starts-with(@class,'Forms__CreateLink')]")
  button(:click_permit_type_ddl, xpath: "//button[@id='type']")
  buttons(:list_permit_type, xpath: "//ul/li/button")

  # def click_create_permit_btn
  #   create_permit_btn
  # end

end
