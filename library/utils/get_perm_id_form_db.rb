# frozen_string_literal: true
module WorkWithIndexeddb
  class << self
    def get_id_from_indexeddb(temp_id)
      open_indexdb(temp_id)
      access_indexdb_data("formId")
    end

    private

    def open_indexdb(temp_id)
      sleep 1
      begin
        $browser.execute_script("openRequest = indexedDB.open('safevue')")
        $browser.execute_script("db = openRequest.result")
        $browser.execute_script("res = db.transaction(['idMap'], 'readonly').objectStore('idMap').get('%s')"%temp_id)
      rescue
        ">> Retrying open_indexdb"
        open_indexdb(temp_id)
      end
    end

    def access_indexdb_data(_data)
      begin
        $browser.execute_script("return res.result['#{_data}']")
      rescue
        p ">> Retrying access_indexdb_data"
        access_indexdb_data(_data)
      end
    end
  end
end