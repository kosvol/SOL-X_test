# frozen_string_literal: true

module WorkWithIndexeddb
  class << self
    def get_id_from_indexeddb(temp_id)
      sleep 2
      open_indexdb(temp_id)
      access_indexdb_data('formId')
    end

    private

    def open_indexdb(temp_id)
      $browser.execute_script("openRequest = indexedDB.open('safevue')")
      $browser.execute_script('db = openRequest.result')
      $browser.execute_script("res = db.transaction(['idMap'], 'readonly').objectStore('idMap').get('%s')" % temp_id)
    rescue StandardError
      open_indexdb(temp_id)
    end

    def access_indexdb_data(_data)
      sleep 3
      begin
        $browser.execute_script("return res.result['#{_data}']")
      rescue StandardError
        access_indexdb_data(_data)
      end
    end
  end
end
