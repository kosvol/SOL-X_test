# frozen_string_literal: true

# module for index db, you need to have driver in your class
module IndexDBUtils
  def retrieve_id_by_temp(temp_id)
    retrieve_form_id(temp_id)
  end

  private

  def retrieve_form_id(temp_id)
    @driver.execute_script("openRequest = indexedDB.open('safevue')")
    @driver.execute_script('db = openRequest.result')
    @driver.execute_script(
      format("res = db.transaction(['idMap'], 'readonly').objectStore('idMap').get('%<form_id>s')", form_id: temp_id)
    )
    @driver.execute_script("return res.result['formId']")
  end
end
