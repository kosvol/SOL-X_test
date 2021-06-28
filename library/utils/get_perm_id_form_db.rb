# frozen_string_literal: true
module WorkWithIndexeddb
  class << self
    def get_id_from_indexeddb(temp_id)
      # works only after synchronization. Usually you should return to the Home page.
      # otherwise the browser shut down
      sleep 40
      $browser.execute_script("openRequest = indexedDB.open('safevue')")
      sleep 7
      $browser.execute_script("db = openRequest.result")
      $browser.execute_script("res = db.transaction(['idMap'], 'readonly').objectStore('idMap').get('%s')"%temp_id)
      $browser.execute_script("return res.result['formId']")
    end
  end
end