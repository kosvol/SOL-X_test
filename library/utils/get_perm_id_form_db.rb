# frozen_string_literal: true
module WorkWithIndexeddb
  class << self
    def get_id_from_indexeddb(temp_id)
      sleep 4
      $browser.execute_script("openRequest = indexedDB.open('safevue')")
      sleep 2
      $browser.execute_script("db = openRequest.result")
      sleep 2
      $browser.execute_script("res = db.transaction(['idMap'], 'readonly').objectStore('idMap').get('%s')"%temp_id)
      sleep 2
      $browser.execute_script("return res.result['formId']")
    end
  end
end